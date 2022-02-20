%EXAMPLE_NN_WU_Classification_AdjacencyMatrix
% Script example pipeline NN WU Classification Ajacency Matrix  

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'craddock_atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN as a Training Set
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_train = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_train = im_gr2.get('GR');

%% Construct the Dataset
nnd_train = NNClassifierData_FUN_WU( ...
    'GR1', gr1_train, ...
    'GR2', gr2_train, ...
    'SPLIT_GR1', 0.2, ...
    'SPLIT_GR2', 0.2, ...
    'FEATURE_MASK', 0.05 ...
    );


nnd_train.memorize('FEATURE_MASK_ANALYSIS');
nnd_train.memorize('INPUTS');
nnd_train.memorize('VAL_INPUTS');
nnd_train.memorize('TARGETS');
nnd_train.memorize('VAL_TARGETS');

%% Train the Neural networks
classifier = NNClassifierDNN( ...
    'NNDATA', nnd_train, ...
    'VERBOSE', true, ...
    'SHUFFLE', 'every-epoch' ...
    );
classifier.memorize('MODEL');

%% Evaluate the Model with the Training Set
nne_train = NNClassifierEvaluator( ...
    'NNDATA', nnd_train, ...
    'NN', classifier, ...
    'PLOT_CM', true, ...
    'PLOT_ROC', true, ...
    'PLOT_MAP', true ...
    );

prediction_train = nne_train.memorize('PREDICTION');
auc_train = nne_train.get('AUC');
cm_train = nne_train.get('CONFUSION_MATRIX');
map = nne_train.get('FEATURE_MAP');

prediction_val = nne_train.memorize('VAL_PREDICTION');
auc_val = nne_train.get('VAL_AUC');
cm_val = nne_train.get('VAL_CONFUSION_MATRIX');

%% Load Groups of SubjectFUN as a Testing Set 
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1_test = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('example_NN_FUN_WU_Classification_AdjacencyMatrix')) filesep 'example data FUN (fMRI)' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2_test = im_gr2.get('GR');

%% Evaluate the Trained Model with the Testing dataset
nnd_test = NNClassifierData_FUN_WU( ...
    'GR1', gr1_test, ...
    'GR2', gr2_test, ....
    'FEATURE_MASK', nnd_train.get('FEATURE_MASK_ANALYSIS') ...
    );

nne_test = NNClassifierEvaluator( ...
    'NNDATA', nnd_test, ...
    'NN', classifier ...
    );

prediction_test = nne_test.memorize('PREDICTION');
auc_test = nne_test.get('AUC');

close all