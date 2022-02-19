%EXAMPLE_NN_ST_Regression
% Script example pipeline NN ST Regression

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_NN_ST_Regression')) filesep 'example data ST (MRI)' filesep 'desikan_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST as a Training Set
im_gr = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_NN_ST_Regression')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_train = im_gr.get('GR');

%% Construct the Dataset
nnd_train = NNRegressorData_ST( ...
    'GR', gr_train, ...
    'SPLIT', 0.2, ...
    'FEATURE_MASK', 0.05 ...
    );

nnd_train.memorize('FEATURE_MASK_ANALYSIS');
nnd_train.memorize('INPUTS');
nnd_train.memorize('VAL_INPUTS');
nnd_train.memorize('TARGETS');
nnd_train.memorize('VAL_TARGETS');

%% Train the Neural networks
regressor = NNRegressorDNN( ...
    'NNDATA', nnd_train, ...
    'VERBOSE', true, ...
    'SHUFFLE', 'every-epoch' ...
    );
regressor.memorize('MODEL');

%% Evaluate the Model with the Training Set
nne_train = NNRegressorEvaluator( ...
    'NNDATA', nnd_train, ...
    'NN', regressor, ...
    'PLOT_MAP', true ...
    );

prediction_train = nne_train.memorize('PREDICTION');
rmse_train = nne_train.get('RMSE');
map = nne_train.get('FEATURE_MAP');

prediction_val = nne_train.memorize('VAL_PREDICTION');
rmse_val = nne_train.get('VAL_RMSE');

%% Load Groups of SubjectST as a Training Set
im_gr = ImporterGroupSubjectST_XLS( ...
    'FILE', [fileparts(which('example_NN_ST_Regression')) filesep 'example data ST (MRI)' filesep 'xls' filesep 'ST_group1.xlsx'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr_test = im_gr.get('GR');

%% Evaluate the Trained Model with the Testing dataset
nnd_test = NNRegressorData_ST( ...
    'GR', gr_test, ...
    'FEATURE_MASK', nnd_train.get('FEATURE_MASK_ANALYSIS') ...
    );

nne_test = NNRegressorEvaluator( ...
    'NNDATA', nnd_test, ...
    'NN', regressor ...
    );

prediction_test = nne_test.memorize('PREDICTION');
rmse_test = nne_test.get('RMSE');

close all