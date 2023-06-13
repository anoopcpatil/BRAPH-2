%EXAMPLE_ST_MP_BUT
% Script example pipeline ST MP BUT

clear variables %#ok<*NASGU>

%% Load BrainAtlas
im_ba = ImporterBrainAtlasXLS( ...
    'FILE', [fileparts(which('example_ST_MP_BUT')) filesep 'Example data ST_MP' filesep 'atlas.xlsx'], ...
    'WAITBAR', true ...
    );

ba = im_ba.get('BA');

%% Load Groups of SubjectST_MP
im_gr1 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('example_ST_MP_BUT')) filesep 'Example data ST_MP' filesep 'xls' filesep 'GroupName1'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr1 = im_gr1.get('GR');

im_gr2 = ImporterGroupSubjectST_MP_XLS( ...
    'DIRECTORY', [fileparts(which('example_ST_MP_BUT')) filesep 'Example data ST_MP' filesep 'xls' filesep 'GroupName2'], ...
    'BA', ba, ...
    'WAITBAR', true ...
    );

gr2 = im_gr2.get('GR');

%% Analysis ST MP BUT
thresholds = .7:.1:.9;
a_BUT1 = AnalyzeGroup_ST_MP_BUT( ...
    'GR', gr1, ...
    'THRESHOLDS', thresholds ...
    );

a_BUT2 = AnalyzeGroup_ST_MP_BUT( ...
    'GR', gr2, ...
    'THRESHOLDS', thresholds ...
    );

% measure calculation
g_BUT1 = a_BUT1.get('G');
ovdegree_BUT1 = g_BUT1.get('MEASURE', 'OverlappingDegree').get('M');
ovdegree_av_BUT1 = g_BUT1.get('MEASURE', 'OverlappingDegreeAv').get('M');
edgeov_BUT1 = g_BUT1.get('MEASURE', 'EdgeOverlap').get('M');

g_BUT2 = a_BUT2.get('G');
ovdegree_BUT2 = g_BUT2.get('MEASURE', 'OverlappingDegree').get('M');
ovdegree_av_BUT2 = g_BUT2.get('MEASURE', 'OverlappingDegreeAv').get('M');
edgeov_BUT2 = g_BUT2.get('MEASURE', 'EdgeOverlap').get('M');

% comparison
c_BUT = CompareGroup( ...
    'P', 10, ...
    'A1', a_BUT1, ...
    'A2', a_BUT2, ...
    'WAITBAR', true, ...
    'VERBOSE', false, ...
    'MEMORIZE', true ...
    );

ovdegree_BUT_diff = c_BUT.get('COMPARISON', 'OverlappingDegree').get('DIFF');
ovdegree_BUT_p1 = c_BUT.get('COMPARISON', 'OverlappingDegree').get('P1');
ovdegree_BUT_p2 = c_BUT.get('COMPARISON', 'OverlappingDegree').get('P2');
ovdegree_BUT_cil = c_BUT.get('COMPARISON', 'OverlappingDegree').get('CIL');
ovdegree_BUT_ciu = c_BUT.get('COMPARISON', 'OverlappingDegree').get('CIU');

ovdegree_av_BUT_diff = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('DIFF');
ovdegree_av_BUT_p1 = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('P1');
ovdegree_av_BUT_p2 = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('P2');
ovdegree_av_BUT_cil = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('CIL');
ovdegree_av_BUT_ciu = c_BUT.get('COMPARISON', 'OverlappingDegreeAv').get('CIU');