classdef AnalysisfMRI < Analysis
    methods
        function analysis = AnalysisfMRI(cohort, measurements, randomcomparisons, comparisons,varargin)
            
            analysis = analysis@Analysis(cohort, measurements, randomcomparisons, comparisons, varargin{:});
        end
    end
    methods
        function measurement_id = getMeasurementID(analysis, measure_code, group, varargin)
            is_random = get_from_varargin(0, 'is_randomfMRI', varargin{:});
            if is_random
                measurement_id = [ ...
                    tostring(analysis.getMeasurementClass()) ' ' ...
                    tostring(measure_code) ' RandomGroup' ...
                    ];
            else
                measurement_id = [ ...
                    tostring(analysis.getMeasurementClass()) ' ' ...
                    tostring(measure_code) ' ' ...
                    tostring(analysis.cohort.getGroups().getIndex(group)) ...
                    ];
            end
        end
        function randomcomparison_id = getRandomComparisonID(analysis, measure_code, group, varargin)
            randomcomparison_id = [ ...
                tostring(analysis.getRandomComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(group)) ...
                ];
        end
        function comparison_id = getComparisonID(analysis, measure_code, groups, varargin)
            comparison_id = [ ...
                tostring(analysis.getComparisonClass()) ' ' ...
                tostring(measure_code) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(groups{1})) ' ' ...
                tostring(analysis.cohort.getGroups().getIndex(groups{2})) ...
                ];
        end
    end
    methods (Access = protected)
        function measurement = calculate_measurement(analysis, measure_code, group, varargin)
            
            measures = cell(1, group.subjectnumber());

            subjects = group.getSubjects();
            for i = 1:1:group.subjectnumber()
                subject = subjects{i};
                data = subject.getData('fMRI').getValue();
                
                % filter data
                fmin = 0;  % values from braph 1
                fmax = Inf;
                T = 1;
                fs = 1 / T;
                if fmax > fmin && T > 0
                    NFFT = 2 * ceil(size(data, 1) / 2);
                    ft = fft(data, NFFT);  % Fourier transform
                    f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
                    ft(f < fmin | f > fmax, :) = 0;
                    data = ifft(ft, NFFT);
                end
                
                correlation_rule = analysis.getSettings('AnalysisfMRI.CorrelationRule');
                negative_weight_rule = analysis.getSettings('AnalysisfMRI.NegativeWeightRule');
                A = Correlation.getAdjacencyMatrix(data, correlation_rule, negative_weight_rule);
                
                graph_type = analysis.getSettings('AnalysisfMRI.GraphType');
                g = Graph.getGraph(graph_type, A, varargin{:});
                measure = Measure.getMeasure(measure_code, g, varargin{:});
                
                measures{1, i} = measure.getValue();
            end
            
            measures_average = mean(reshape(cell2mat(measures), [size(measures{1}, 1), size(measures{1}, 2), group.subjectnumber()]), 3);
            
            measurement = Measurement.getMeasurement('MeasurementfMRI', ...
                analysis.getMeasurementID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group,  ...
                'MeasurementfMRI.measure_code', measure_code, ...
                'MeasurementfMRI.values', measures, ...
                'MeasurementfMRI.average_value', measures_average ...
                );
        end
        function randomcomparison = calculate_random_comparison(analysis, measure_code, group, varargin)
            % rules
            attemptsPerEdge = analysis.getSettings('AnalysisfMRI.AttemptsPerEdge');
            numerOfWeights = analysis.getSettings('AnalysisfMRI.NumberOfWeights');
            graph_type = analysis.getSettings('AnalysisfMRI.GraphType');
            verbose = analysis.getSettings('AnalysisfMRI.ComparisonVerbose');
            interruptible = analysis.getSettings('AnalysisfMRI.ComparionInterruptible');
            is_longitudinal = analysis.getSettings('AnalysisfMRI.Longitudinal');
            M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
   
            % get randomize graphs of subjects
            subjects = group.getSubjects();
            for i = 1:1:numel(subjects)
                subject = subjects{i};
                subject_class = subject.getClass();
                atlas = subject.getBrainAtlases();
                A = subject.getData('fMRI').getValue();
                g = Graph.getGraph(graph_type, A);
                [permutated_A, ~] = g.randomize_graph('AttemptsPerEdge', attemptsPerEdge, 'NumberOfWeights', numerOfWeights);
                permuted_subject = Subject.getSubject(subject_class, atlas, 'fMRI', permutated_A);
                permuted_subjects{i} = permuted_subject; %#ok<AGROW>
            end
            
            permuted_group = Group(subject_class, permuted_subjects, 'GroupName', ['RandomGroup_' group.getName()]);
            
            % create Measurements
            measurement_group = analysis.calculate_measurement(measure_code, group, varargin{:});
            measurement_random = analysis.calculate_measurement(measure_code, permuted_group, 'is_randomfMRI', 1, varargin{:});
            
            % get compared values
            values_group = measurement_group.getMeasureValues();
            values_random = measurement_random.getMeasureValues();
            average_values_group =  mean(reshape(cell2mat(values_group), [size(values_group{1}, 1), size(values_group{1}, 2), group.subjectnumber()]), 3);
            average_values_random = mean(reshape(cell2mat(values_random), [size(values_random{1}, 1), size(values_random{1}, 2), permuted_group.subjectnumber()]), 3);
            
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                if is_longitudinal
                    [permutation_1, permutation_2] = Permutation.permute(values_group, values_random, is_longitudinal);
                else
                    [permutation_1, permutation_2] = Permutation.permute(values_group, values_random, is_longitudinal);
                end
                
                mean_permutated_1 = mean(reshape(cell2mat(permutation_1), [size(permutation_1{1}, 1), size(permutation_1{1}, 2), group.subjectnumber()]), 3);
                mean_permutated_2 = mean(reshape(cell2mat(permutation_2), [size(permutation_2{1}, 1), size(permutation_2{1}, 2), permuted_group.subjectnumber()]), 3);
                
                all_permutations_1(1, i) = {mean_permutated_1};
                all_permutations_2(1, i) = {mean_permutated_2};
                
                difference_all_permutations{1, i} = mean_permutated_1 - mean_permutated_2; %#ok<AGROW>
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_mean = average_values_random - average_values_group;  % difference of the mean values of the non permutated groups
            difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated random group - permutated group
            
            p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
            p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
            percentiles = quantiles(difference_all_permutations, 40);  % for confidence interval
            if size(percentiles) == [1 1] %#ok<BDSCA>
                ci_lower = percentiles{1}(2);
                ci_upper = percentiles{1}(40); % 95 percent
            elseif size(percentiles) == [size(difference_mean, 1) 1] %#ok<BDSCA>
                for i = 1:1:length(percentiles)
                    percentil = percentiles{i};
                    ci_lower{i, 1} = percentil(2);  %#ok<AGROW>
                    ci_upper{i, 1} = percentil(40); %#ok<AGROW>
                end
            else
                for i = 1:1:size(percentiles, 1)
                    for j = 1:1:size(percentiles, 2)
                        percentil = percentiles{i, j};
                        ci_lower{i, j} = percentil(2); %#ok<AGROW>
                        ci_upper{i, j} = percentil(40); %#ok<AGROW>
                    end
                end
            end            
            
            % create randomComparisonClass
            randomcomparison = RandomComparison.getRandomComparison('RandomComparisonfMRI', ...
                analysis.getRandomComparisonID(measure_code, group, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), group, ...
                'RandomComparisonfMRI.measure_code', measure_code, ...
                'RandomComparisonfMRI.values_group', values_group, ...
                'RandomComparisonfMRI.values_random', values_random, ...
                'RandomComparisonfMRI.average_values_group', average_values_group, ...
                'RandomComparisonfMRI.average_values_random', average_values_random, ...
                'RandomComparisonfMRI.difference', difference_mean, ...
                'RandomComparisonfMRI.all_differences', difference_all_permutations, ...
                'RandomComparisonfMRI.p1', p1, ...
                'RandomComparisonfMRI.p2', p2, ....
                'RandomComparisonfMRI.confidence_min', ci_lower, ...
                'RandomComparisonfMRI.confidence_max', ci_upper, ...
                'RandomComparisonfMRI.number_of_permutations', M ...
                );    
        end
        function comparison = calculate_comparison(analysis, measure_code, groups, varargin)
            verbose = analysis.getSettings('AnalysisfMRI.ComparisonVerbose');
            interruptible = analysis.getSettings('AnalysisfMRI.ComparionInterruptible');
            is_longitudinal = analysis.getSettings('AnalysisfMRI.Longitudinal');
            M = get_from_varargin(1e+3, 'NumerOfPermutations', varargin{:});
            group_1 = groups{1};
            group_2 = groups{2};
            
            measurements_1 = analysis.calculateMeasurement(measure_code, groups{1}, varargin{:});
            values_1 = measurements_1.getMeasureValues();
            res_1 = mean(reshape(cell2mat(values_1), [size(values_1{1}, 1), size(values_1{1}, 2), group_1.subjectnumber()]), 3);
            
            measurements_2 = analysis.calculateMeasurement(measure_code, groups{2}, varargin{:});
            values_2 = measurements_2.getMeasureValues();
            res_2 =  mean(reshape(cell2mat(values_2), [size(values_2{1}, 1), size(values_2{1}, 2), group_2.subjectnumber()]), 3);
            
            all_permutations_1 = cell(1, M);
            all_permutations_2 = cell(1, M);
            
            start = tic;
            for i = 1:1:M
                if verbose
                    disp(['** PERMUTATION TEST - sampling #' int2str(i) '/' int2str(M) ' - ' int2str(toc(start)) '.' int2str(mod(toc(start),1)*10) 's'])
                end
                
                if is_longitudinal
                    [permutation_1, permutation_2] = Permutation.permute(values_1, values_2, is_longitudinal);
                else
                    [permutation_1, permutation_2] = Permutation.permute(values_1, values_2, is_longitudinal);
                end
                
                mean_permutated_1 = mean(reshape(cell2mat(permutation_1), [size(permutation_1{1}, 1), size(permutation_1{1}, 2), group_1.subjectnumber()]), 3);
                mean_permutated_2 = mean(reshape(cell2mat(permutation_2), [size(permutation_2{1}, 1), size(permutation_2{1}, 2), group_2.subjectnumber()]), 3);
                
                all_permutations_1(1, i) = {mean_permutated_1};
                all_permutations_2(1, i) = {mean_permutated_2};
                
                difference_all_permutations{1, i} = mean_permutated_1 - mean_permutated_2; %#ok<AGROW>
                
                if interruptible
                    pause(interruptible)
                end
            end
            
            difference_mean = res_2 - res_1;  % difference of the mean values of the non permutated groups
            difference_all_permutations = cellfun(@(x) [x], difference_all_permutations, 'UniformOutput', false);  %#ok<NBRAK> % permutated group 1 - permutated group 2
            
            p1 = pvalue1(difference_mean, difference_all_permutations);  % singe tail,
            p2 = pvalue2(difference_mean, difference_all_permutations);  % double tail
            percentiles = quantiles(difference_all_permutations, 40);
            if size(percentiles) == [1 1] %#ok<BDSCA>
                ci_lower = percentiles{1}(2);
                ci_upper = percentiles{1}(40); % 95 percent
            elseif size(percentiles) == [size(difference_mean, 1) 1] %#ok<BDSCA>
                for i = 1:1:length(percentiles)
                    percentil = percentiles{i};
                    ci_lower{i, 1} = percentil(2);  %#ok<AGROW>
                    ci_upper{i, 1} = percentil(40); %#ok<AGROW>
                end
            else
                for i = 1:1:size(percentiles, 1)
                    for j = 1:1:size(percentiles, 2)
                        percentil = percentiles{i, j};
                        ci_lower{i, j} = percentil(2); %#ok<AGROW>
                        ci_upper{i, j} = percentil(40); %#ok<AGROW>
                    end
                end
            end  
            
            comparison = Comparison.getComparison('ComparisonfMRI', ...
                analysis.getComparisonID(measure_code, groups, varargin{:}), ...
                analysis.getCohort().getBrainAtlases(), groups, ...
                'ComparisonfMRI.measure_code', measure_code, ...
                'ComparisonfMRI.difference', difference_mean, ...
                'ComparisonfMRI.all_differences', difference_all_permutations, ...
                'ComparisonfMRI.p1', p1, ...
                'ComparisonfMRI.p2', p2, ...
                'ComparisonfMRI.confidence_min', ci_lower, ...
                'ComparisonfMRI.confidence_max', ci_upper, ...
                'ComparisonfMRI.values_1', values_1, ...
                'ComparisonfMRI.average_values_1', res_1, ...
                'ComparisonfMRI.values_2', values_2, ...
                'ComparisonfMRI.average_values_2', res_2, ...
                'ComparisonfMRI.number_of_permutations', M ...
                );
        end
    end
    methods (Static)
        function analysis_class = getClass()
            analysis_class = 'AnalysisfMRI';
        end
        function name = getName()
            name = 'Analysis Functional fMRI';
        end
        function subject_class = getSubjectClass()
            subject_class = 'SubjectfMRI';
        end       
        function description = getDescription()
            description = [ ...
                'Analysis using functional MRI data, ' ...
                'such as activation timeseries for each brain region' ...
                ];
        end
        function measurement_class = getMeasurementClass()
            measurement_class = 'MeasurementfMRI';
        end
        function randomcomparison_class = getRandomComparisonClass()
            randomcomparison_class = 'RandomComparisonfMRI';
        end
        function comparison_class = getComparisonClass()
            comparison_class = 'ComparisonfMRI';
        end
        function available_settings = getAvailableSettings(analysis) %#ok<INUSD>
            available_settings = {
                {'AnalysisfMRI.GraphType', Constant.STRING, 'GraphWU', {'GraphWU'}}, ...
                {'AnalysisfMRI.CorrelationRule', Constant.STRING, 'pearson', Correlation.CORRELATION_RULE_LIST}, ...
                {'AnalysisfMRI.NegativeWeightRule', Constant.STRING, 'default', Correlation.NEGATIVE_WEIGHT_RULE_LIST}, ...
                {'AnalysisfMRI.ComparisonVerbose', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisfMRI.ComparionInterruptible', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisfMRI.Longitudinal', Constant.LOGICAL, false, {false, true}}, ...
                {'AnalysisfMRI.AttemptsPerEdge', Constant.NUMERIC, 1, {}}, ...
                {'AnalysisfMRI.NumberOfWeights', Constant.NUMERIC, 1, {}} ...
                };
        end
    end
end