%% ¡header!
NNClassifierCrossValidation_ST < NNClassifierCrossValidation (nncv, cross-validation of a neural network classifier) cross-validates the performance of a neural network classifier with a dataset.

%% ¡description!
This cross validation performan k-fold cross validation of a neural network
classifier with desired repetitions for structural data. The dataset is 
split into k consecutive folds with shuffling by default, and each fold is 
then used once as a validation while the k-1 remaining folds form the 
training set. The confusion matrix, ROC curves, AUCs, and contributing maps 
are calculated across the testing sets over k folds.

%% ¡props_update!
%%% ¡prop!
NNE_DICT (result, idict) is the NN evaluators for k folds across repetitions.
%%%% ¡settings!
'NNClassifierEvaluator'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'NNClassifierEvaluator')
%%%% ¡calculate!
nne_dict = IndexedDictionary('IT_CLASS', 'NNClassifierEvaluator');
if ~isa(nncv.get('GR1').getr('SUB_DICT'), 'NoValue')
    for i = 1:1:nncv.get('REPETITION')
        idx_per_fold_gr1 = nncv.get('SPLIT_KFOLD_GR1');
        idx_per_fold_gr2 = nncv.get('SPLIT_KFOLD_GR2');
        for j = 1:1:nncv.get('KFOLD')
            nnd = NNClassifierData_ST( ...
                'ID', ['kfold ', num2str(j), ' repetition ', num2str(i)], ...
                'GR1', nncv.get('GR1'), ...
                'GR2', nncv.get('GR2'), ...
                'SPLIT_GR1', idx_per_fold_gr1{j}, ...
                'SPLIT_GR2', idx_per_fold_gr2{j}, ...
                'FEATURE_MASK', 0.05 ...
                );

            nnd.memorize('FEATURE_MASK_ANALYSIS');
            nnd.memorize('INPUTS');
            nnd.memorize('VAL_INPUTS');
            nnd.memorize('TARGETS');
            nnd.memorize('VAL_TARGETS');

            classifier = NNClassifierDNN( ...
                'ID', ['kfold ', num2str(j), 'repetition ', num2str(i)], ...
                'NNDATA', nnd, ...
                'VERBOSE', true, ...
                'SHUFFLE', 'every-epoch' ...
                );

            classifier.memorize('MODEL');

            nne = NNClassifierEvaluator( ...
                'ID', ['kfold ', num2str(j), 'repetition ', num2str(i)], ...
                'NNDATA', nnd, ...
                'NN', classifier, ...
                'PLOT_CM', false, ...
                'PLOT_ROC', false, ...
                'PLOT_MAP', false ...
                );

            nne.memorize('VAL_PREDICTION');
            nne.memorize('VAL_AUC');
            nne.memorize('VAL_CONFUSION_MATRIX');
            nne.memorize('FEATURE_MAP');

            nne_dict.add(nne)
        end
    end
end

value = nne_dict;

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_NNCV_ST_Classification