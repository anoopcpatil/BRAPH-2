classdef WeightedRichClub < Strength
    % WeightedRichClub Weighted rich-club measure
    % WeightedRichClub provides the weighted rich-club of a node for weighted 
    % undirected (WU) and weighted directed (WD) graphs. 
    %
    % It is a parametric measure, at s level it calculates the fraction of 
    % edges weights that connect nodes of strength s or higher out of the  
    % maximum number of edges weights that such nodes might share within a layer. 
    % The valuea of s are set by the user (setting 'WeightedRichClubThreshold'), 
    % the default value is equal to 1.
    % 
    % WeightedRichClub methods:
    %   WeightedRichClub            - constructor
    %
    % WeightedRichClub methods (Static)
    %   getClass                    - returns the weighted rich-club class
    %   getName                     - returns the name of weighted rich-club measure
    %   getDescription              - returns the description of weighted rich-club measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure   
    %   getMeasure                  - returns the weighted rich-club class
    %   getParameterName            - returns the name of weighted rich-club measure's parameter
    %   getParameterHandle          - returns the handle of the parameter
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % WeightedRichClub methods 
    %   getParameterValues          - returns the values of weighted rich-club measure's parameter
    %
    % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
    
    methods
        function m = WeightedRichClub(g, varargin)
            % WEIGHTEDRICHCLUB(G) creates weighted rich-club with default properties.
            % G is a weighted graph (e.g, an instance of GraphWD, GraphWU,
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % WEIGHTEDRICHCLUB(G, 'WeightedRichClubThreshold', WEIGHTEDRICHCLUBTHRESHOLD) 
            % creates weighted rich-club measure and initializes the property 
            % WeightedRichClubThreshold with WEIGHTEDRICHCLUBTHRESHOLD. 
            % Admissible THRESHOLD options are:
            % WEIGHTEDRICHCLUBTHRESHOLD = 1 (default) - WEIGHTEDRICHCLUB s   
            %                           threshold is set to 1.
            %                           value - WEIGHTEDRICHCLUB s threshold 
            %                           is set to the specificied values (vector).
            % 
            % WEIGHTEDRICHCLUB(G, 'VALUE', VALUE) creates weighted rich-club, and sets 
            % the value to VALUE. G is a graph (e.g, an instance of GraphWD, GraphWU,
            % MultiplexGraphWD or MultiplexGraphWU). 
            %
            % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            m = m@Strength(g, varargin{:});
        end
    end
    methods (Access=protected)
        function weighted_rich_club = calculate(m)
            % CALCULATE calculates the weighted rich-club value of a graph
            %
            % WEIGHTEDRICHCLUB = CALCULATE(M) returns the value of the 
            % weighted rich-club of a graph.
            %
            % See also Measure, Strength, GraphWU, GraphWD, MultiplexGraphWU, MultiplexGraphWD.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix (for graph) or 2D-cell array (for multiplex)
            L = g.layernumber();
            N = g.nodenumber();
            
            weighted_rich_club = cell(g.layernumber(), 1);
            directionality_type =  g.getDirectionalityType(g.layernumber());
            for li = 1:1:L
                
                if g.is_graph(g)
                    Aii = A;
                    directionality_layer = directionality_type;
                else
                    Aii = A{li, li};
                    directionality_layer = directionality_type(li, li);
                end
                
                if directionality_layer == Graph.UNDIRECTED  % undirected graphs
                    
                    if g.is_measure_calculated('Strength')
                        strength = g.getMeasureValue('Strength');
                    else
                        strength = calculate@Strength(m);
                    end
                    
                    st = strength{li};
                    
                else  % directed graphs
                    
                    if g.is_measure_calculated('InStrength')
                        in_strength = g.getMeasureValue('InStrength');
                    else
                        in_strength = InStrength(g, g.getSettings()).getValue();
                    end
                    
                    if g.is_measure_calculated('OutStrength')
                        out_strength = g.getMeasureValue('OutStrength');
                    else
                        out_strength = OutStrength(g, g.getSettings()).getValue();
                    end
                    
                    st = (in_strength{li} + out_strength{li})/2;
                end
                
                weighted_rich_club_threshold = m.getParameter();
                assert(isnumeric(weighted_rich_club_threshold) == 1, ...
                    [BRAPH2.STR ':WeightedRichClub:' BRAPH2.WRONG_INPUT], ...
                    ['WeightedRichClub threshold must be a positive number ' ...
                    'while it is ' tostring(weighted_rich_club_threshold)])

                s_levels = abs(weighted_rich_club_threshold);
                m.setParameter(s_levels)  % Set the parameter
                
                weighted_rich_club_layer = zeros(1, 1, length(s_levels)); 
                wrank = sort(Aii(:), 'descend');  % wrank contains the ranked weights of the network, with strongest connections on top
                count = 1;
                for s = s_levels
                    low_rich_nodes = find(st < s);  % get lower rich nodes with strength < s
                    subAii = Aii;  % extract subnetwork of nodes >=s by removing nodes < s of Aii
                    subAii(low_rich_nodes, :) = [];  % remove rows
                    subAii(:, low_rich_nodes) = [];  % remove columns
                    
                    Wr = sum(subAii(:));  % total weight of connections in subgraph > s
                    Er = length(find(subAii~=0));  % total number of connections in subgraph
                    wrank_r = wrank(1:1:Er);  % E>r number of connections with max weight in network
                    % Calculate weighted rich-club coefficient
                    weighted_rich_club_layer(1, 1, count) = Wr / sum(wrank_r); 
                    count = count + 1;
                end
                weighted_rich_club_layer(isnan(weighted_rich_club_layer)) = 0;  % Should return zeros, since NaN happens when subAii has zero nodes with strength > s
                weighted_rich_club(li) = {weighted_rich_club_layer};  % add rich club strength of layer li
            end
        end
    end  
    methods (Static)  % Descriptive methods
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the weighted rich-club measure.
            %
            % See also getName, getDescription. 
            
            measure_class = 'WeightedRichClub';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the weighted rich-club measure.
            %
            % See also getClass, getDescription. 
            
            name = 'Weighted rich-club';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the weighted rich-club description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % weighted rich-club measure.
            %
            % See also getClass, getName.
            
            description = [ ...
                'The weighted rich-club of a node at level s is the fraction of the' ...
                'edges weights that connect nodes of strength s or higher out of the ' ... 
                'maxium number of edges weights that such nodes might share within a layer. ' ...
                's is set by the user and it can be a vector containting all the ' ...
                'strength thresholds; the default value is equal to 1 ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to WeightedRichClub
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to WeightedRichClub.
            % WEIGHTEDRICHCLUBTHRESHOLD = 1 (default) - WEIGHTEDRICHCLUB s   
            %                           threshold is set to 1.
            %                           value - WEIGHTEDRICHCLUB s threshold 
            %                           is set to the specificied values (vector).
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of WeightedRichClub
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of weighted rich-club measure (GLOBAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.GLOBAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of WeightedRichClub
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of weighted rich-club measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of WeightedRichClub
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of weighted rich-club measure (PARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.PARAMETRIC;
        end
        function name = getParameterName()
            % GETPARAMETERNAME returns the name of WeightedRichClub' parameter
            %
            % NAME = GETPARAMETERNAME() returns the name (string) of 
            % the weighted rich-club' parameter.
            
            name = 'Weighted rich-club thresholds';
        end
        function h = getParameterHandle()
            % GETPARAMETERHANDLE returns the measures's parameter handle
            %
            % H = GETPARAMETERHANDLE(MEASURE)returns the measure's
            % parameter handle.
            %
            % See also getParameterName, getParameter
            
            h = {'WeightedRichClub.Parameter', 1, BRAPH2.NUMERIC};
        end
        function list = getCompatibleGraphList()  
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs with WeightedRichClub 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to weighted rich-club. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber. 
            
            list = { ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphWD' ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible graphs with WeightedRichClub
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs with weighted rich-club.
            % 
            % See also getCompatibleGraphList.
            
            n = Measure.getCompatibleGraphNumber('WeightedRichClub');
        end
    end
    methods
        function values = getParameterValues(m)
            % GETPARAMETERVALUES returns the values of the WeightedRichClub' parameter
            %
            % VALUES = GETPARAMETERVALUES() returns the values of
            % the weighted rich-club' parameter.
            
            values = m.getParameter();
        end
    end
end