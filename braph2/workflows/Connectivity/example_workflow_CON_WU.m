% Script example workflow CON WU
clear
%#ok<*NOPTS>

%% Load BrainAtlas
[file, path, filterindex] = uigetfile('*.xlsx');
if filterindex
    atlas_file = fullfile(path, file);
else
    atlas_file = [fileparts(which('example_workflow_CON_WU.m')) filesep() 'example data CON (DTI)' filesep() 'desikan_atlas.xlsx'];
end
clear file filterindex path

atlas = BrainAtlas.load_from_xls('File', atlas_file);

disp(['Loaded BrainAtlas: ' atlas.tostring()])

% %% Subjects
% % input_data = rand(atlas.getBrainRegions().length(), atlas.getBrainRegions().length());
% % sub11 = Subject.getSubject('SubjectCON', 'SubjectID11', 'label1', 'notes1', atlas, 'CON', input_data);
% % sub12 = Subject.getSubject('SubjectCON', 'SubjectID12', 'label2', 'notes2', atlas, 'CON', input_data);
% % sub13 = Subject.getSubject('SubjectCON', 'SubjectID13', 'label3', 'notes3', atlas, 'CON', input_data);
% % sub14 = Subject.getSubject('SubjectCON', 'SubjectID14', 'label4', 'notes4', atlas, 'CON', input_data);
% % sub15 = Subject.getSubject('SubjectCON', 'SubjectID15', 'label5', 'notes5', atlas, 'CON', input_data);
% % group = Group('SubjectCON', 'GroupName2', 'TestGroup2', 'notes2', {sub11, sub12, sub13, sub14, sub15});
% % cohort = Cohort('trial_cohort', 'label1', 'notes1', 'SubjectCON', atlas, {sub11, sub12, sub13, sub14, sub15});
% % cohort.getGroups().add(group.getID(), group);
% % SubjectCON.save_to_json(cohort);

%% Load CON Subject Data for group 1
[file, path, filterindex] = uigetfile('.json');
if filterindex
    group1_file = fullfile(path, file);
else
    group1_file = [fileparts(which('example_workflow_CON_WU.m')) filesep() 'example data CON (DTI)' filesep() 'json'  filesep() 'GroupName1'];
end
clear file path filterindex;

cohort = SubjectCON.load_from_json(atlas, 'Directory', group1_file);

disp(['Loaded Group 1: ' cohort.tostring()])

%% Load CON Subject Data for group 2 into the same cohort
[file, path, filterindex] = uigetfile('.json');
if filterindex
    group2_file = fullfile(path, file);    
else    
    group2_file = [fileparts(which('example_workflow_CON_WU.m')) filesep() 'example data CON (DTI)' filesep() 'json' filesep() 'GroupName2'];
end
clear file path filterindex;

cohort = SubjectCON.load_from_json(cohort, 'Directory', group2_file);

disp(['Loaded Group 2: ' cohort.tostring()])

%% Create Analysis
analysis = AnalysisCON_WU('analysis example ID', 'analysis example label', 'analysis example notes', cohort, {}, {}, {});
disp('AnalysisCON_WU created.')

groups = analysis.getCohort().getGroups();
group_1 = groups.getValue(1);
group_2 = groups.getValue(2);

%% Create Measurement
measure = 'Degree';

measurement_group_1 = analysis.getMeasurement(measure, group_1) 
measurement_group_2 = analysis.getMeasurement(measure, group_2)

%% Create RandomComparison
measure = 'Degree';
number_of_randomizations = 10;

random_comparison_group_1 = analysis.getRandomComparison(measure, group_1, 'RandomizationNumber', number_of_randomizations)
random_comparison_group_2 = analysis.getRandomComparison(measure, group_2, 'RandomizationNumber', number_of_randomizations)

%% Create Comparison
measure = 'Degree';
number_of_permutations = 10;

comparison = analysis.getComparison(measure, group_1, group_2, 'PermutationNumber', number_of_permutations)
