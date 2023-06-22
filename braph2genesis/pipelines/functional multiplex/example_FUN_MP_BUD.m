%EXAMPLE_FUN_MP_BUD
% Script example pipeline FUN MP BUD

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP XLS' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectFUN_MP
im_gr1 = ImporterGroupSubjectFUN_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP XLS' filesep 'FUN_MP_Group_1_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectFUN_MP_XLS( ...
    'DIRECTORY', [fileparts(which('SubjectFUN_MP')) filesep 'Example data FUN_MP XLS' filesep 'FUN_MP_Group_2_XLS'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis FUN MP BUD
densities = 5:10:15;

a_BUD1 = AnalyzeEnsemble_FUN_MP_BUD( ...
    'GR', gr1, ...
    'DENSITIES', densities ...
    );

a_BUD2 = AnalyzeEnsemble_FUN_MP_BUD( ...
    'GR', gr2, ...
    'DENSITIES', densities ...
    );

% measure calculation
mpc_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'MultiplexParticipation').get('M');
mpc_av_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'MultiplexParticipationAv').get('M');
edgeov_BUD1 = a_BUD1.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

mpc_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'MultiplexParticipation').get('M');
mpc_av_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'MultiplexParticipationAv').get('M');
edgeov_BUD2 = a_BUD2.get('MEASUREENSEMBLE', 'EdgeOverlap').get('M');

% % % % comparison
% % % c_BUD = CompareEnsemble( ...
% % %     'P', 10, ...
% % %     'A1', a_BUD1, ...
% % %     'A2', a_BUD2, ...
% % %     'WAITBAR', true, ...
% % %     'VERBOSE', false, ...
% % %     'MEMORIZE', true ...
% % %     );
% % % 
% % % mpc_BUD_diff = c_BUD.get('COMPARISON', 'MultiplexParticipation').get('DIFF');
% % % mpc_BUD_p1 = c_BUD.get('COMPARISON', 'MultiplexParticipation').get('P1');
% % % mpc_BUD_p2 = c_BUD.get('COMPARISON', 'MultiplexParticipation').get('P2');
% % % mpc_BUD_cil = c_BUD.get('COMPARISON', 'MultiplexParticipation').get('CIL');
% % % mpc_BUD_ciu = c_BUD.get('COMPARISON', 'MultiplexParticipation').get('CIU');
% % % 
% % % mpc_av_BUD_diff = c_BUD.get('COMPARISON', 'MultiplexParticipationAv').get('DIFF');
% % % mpc_av_BUD_p1 = c_BUD.get('COMPARISON', 'MultiplexParticipationAv').get('P1');
% % % mpc_av_BUD_p2 = c_BUD.get('COMPARISON', 'MultiplexParticipationAv').get('P2');
% % % mpc_av_BUD_cil = c_BUD.get('COMPARISON', 'MultiplexParticipationAv').get('CIL');
% % % mpc_av_BUD_ciu = c_BUD.get('COMPARISON', 'MultiplexParticipationAv').get('CIU');