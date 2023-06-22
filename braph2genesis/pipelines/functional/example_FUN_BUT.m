%EXAMPLE_FUN_BUT
% Script example pipeline FUN BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN
im_gr1 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'FUN_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN')) filesep 'Example data FUN XLS' filesep 'FUN_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis FUN BUT
thresholds = 0.4:.2:1;

a_BUT1 = AnalyzeEnsemble_FUN_BUT( ...
    'GR', gr1, ...
    'THRESHOLDS', thresholds ...
    );

a_BUT2 = AnalyzeEnsemble_FUN_BUT( ...
    'GR', gr2, ...
    'THRESHOLDS', thresholds ...
    );

% measure calculation
clustering_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'Clustering').get('M');
clustering_av_BUT1 = a_BUT1.get('MEASUREENSEMBLE', 'ClusteringAv').get('M');

clustering_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'Clustering').get('M');
clustering_av_BUT2 = a_BUT2.get('MEASUREENSEMBLE', 'ClusteringAv').get('M');

% % % % comparison
% % % c_BUT = CompareEnsemble( ...
% % %     'P', 10, ...
% % %     'A1', a_BUT1, ...
% % %     'A2', a_BUT2, ...
% % %     'WAITBAR', true, ...
% % %     'VERBOSE', false, ...
% % %     'MEMORIZE', true ...
% % %     );
% % % 
% % % clustering_BUT_diff = c_BUT.get('COMPARISON', 'Clustering').get('DIFF');
% % % clustering_BUT_p1 = c_BUT.get('COMPARISON', 'Clustering').get('P1');
% % % clustering_BUT_p2 = c_BUT.get('COMPARISON', 'Clustering').get('P2');
% % % clustering_BUT_cil = c_BUT.get('COMPARISON', 'Clustering').get('CIL');
% % % clustering_BUT_ciu = c_BUT.get('COMPARISON', 'Clustering').get('CIU');
% % % 
% % % clustering_av_BUT_diff = c_BUT.get('COMPARISON', 'ClusteringAv').get('DIFF');
% % % clustering_av_BUT_p1 = c_BUT.get('COMPARISON', 'ClusteringAv').get('P1');
% % % clustering_av_BUT_p2 = c_BUT.get('COMPARISON', 'ClusteringAv').get('P2');
% % % clustering_av_BUT_cil = c_BUT.get('COMPARISON', 'ClusteringAv').get('CIL');
% % % clustering_av_BUT_ciu = c_BUT.get('COMPARISON', 'ClusteringAv').get('CIU');
