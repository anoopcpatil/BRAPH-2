%% ¡header!
ExporterGroupSubjectST_MP_TXT < Exporter (ex, exporter of ST MP subject group in TXT) exports a group of subjects with structural multiplex data to an TXT file.

%%% ¡description!
ExporterGroupSubjectST_MP_TXT exports a group of subjects with structural multiplex data to an TXT file and their covariates age and sex (if existing) to another TXT file.
The files from the same group containing the data from L layers are saved in the same folder.
Each TXT file consists of the following columns: 
Group ID (column 1), Group LABEL (column 2), Group NOTES (column 3) and
BrainRegions of that layer (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The TXT file containing the covariates consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and, Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.

%%% ¡seealso!
Group, SubjectST_MP, ImporterGroupSubjectST_MP_TXT

%% ¡props_update!

%%% ¡prop!
NAME (constant, string) is the name of the ST subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectST_MP_TXT'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the ST subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectST_MP_TXT exports a group of subjects with structural multiplex data to an TXT file and their covariates age and sex (if existing) to another TXT file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the ST subject group exporter in TXT.

%%% ¡prop!
ID (data, string) is a few-letter code for the ST subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectST_MP_TXT ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the ST subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectST_MP_TXT label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the ST subject group exporter in TXT.
%%%% ¡default!
'ExporterGroupSubjectST_MP_TXT notes'

%% ¡props!

%%% ¡prop!
GR (data, item) is a group of subjects with structural multiplex data.
%%%% ¡settings!
'Group'
%%%% ¡check_prop!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST_MP', [], [], true))); 
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST_MP', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP'))

%%% ¡prop!
DIRECTORY (data, string) is the directory name where to save the group of subjects with structural multiplex data.
%%%% ¡default!
[fileparts(which('test_braph2')) filesep 'default_group_subjects_ST_ML_most_likely_to_be_erased']

%%% ¡prop!
PUT_DIR (query, item) opens a dialog box to set the directory where to save the group of subjects with structural multiplex data.
%%%% ¡settings!
'ExporterGroupSubjectST_ML_TXT'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
    ex.set('DIRECTORY', directory);
end
value = ex;

%%% ¡prop!
SAVE (result, empty) saves the group of subjects with structural multiplex data in TXT files in the selected directory.
%%%% ¡calculate!
directory = ex.get('DIRECTORY');

if isfolder(directory)
    wb = braph2waitbar(ex.get('WAITBAR'), 0, 'Retrieving path ...');

    gr = ex.get('GR');

    gr_directory = [directory filesep() gr.get('ID')];
    if ~exist(gr_directory, 'dir')
        mkdir(gr_directory)
    end

    sub_dict = gr.get('SUB_DICT');
    sub_number = sub_dict.get('LENGTH');

    braph2waitbar(wb, .15, 'Organizing info ...')

    if sub_number ~= 0
        sub = sub_dict.get('IT', 1);
        ba = sub.get('BA');
        br_list = cellfun(@(i) ba.get('BR_DICT').get('IT', i), ...
            num2cell([1:1:ba.get('BR_DICT').get('LENGTH')]), 'UniformOutput', false);
        br_labels = cellfun(@(br) br.get('ID'), br_list, 'UniformOutput', false);
        layers_number = sub_dict.get('IT', 1).get('L');
        br_number = length(br_labels);
        all_data = cell(layers_number, sub_number, br_number);
        subjects_info = cell(sub_number, 3);
        age = cell(sub_number, 1);
        sex = cell(sub_number, 1);
        
        for i = 1:1:sub_number
            sub = sub_dict.get('IT', i);
            subjects_info{i, 1} = sub.get('ID');
            subjects_info{i, 2} = sub.get('LABEL');
            subjects_info{i, 3} = sub.get('NOTES');
            age{i} =  sub.get('AGE');
            sex{i} =  sub.get('SEX');
            
            for k = 1:1:layers_number
                data_val = sub.get('ST_MP');
                all_data(k, i, :) = num2cell(data_val{k}');
            end             
        end
        
        braph2waitbar(wb, .55, 'Saving info ...')

        for j = 1:1:layers_number
            gr_id = gr.get('ID');
            % save id label notes
            tab_id = cell2table(subjects_info);
            tab_id.Properties.VariableNames = {'ID', 'Label', 'Notes'};
            
            % save data
            tab_data =  cell2table(reshape(all_data(j, :, :), [sub_number, br_number]));
            tab_data.Properties.VariableNames = br_labels;
            tab = [tab_id tab_data];
            writetable(tab, [gr_directory filesep() gr_id  '_' num2str(j) '.txt'], 'Delimiter', '	', 'WriteVariableNames', 1);
        end
    end
        
% % %     % if covariates save them in another file
% % %     if sub_number ~= 0 && ~isequal(sex{:}, 'unassigned')  && ~isequal(age{:},  0) 
% % %         tab2 = cell(1 + sub_number, 3);
% % %         tab2{1, 1} = 'ID';
% % %         tab2{1, 2} = 'Age';
% % %         tab2{1, 3} = 'Sex';
% % %         tab2(2:end, 1) = tab{:, 1};
% % %         tab2(2:end, 2) = age;
% % %         tab2(2:end, 3) = sex;
% % %         tab2 = table(tab2);
% % %         
% % %         % save
% % %         cov_directory = [gr_directory filesep() 'covariates'];
% % %         if ~exist(cov_directory, 'dir')
% % %             mkdir(cov_directory)
% % %         end
% % %         writetable(tab2, [cov_directory filesep() gr_id '_covariates.txt'], 'Delimiter', '\t', 'WriteVariableNames', 0);
% % %     end
    
    braph2waitbar(wb, 'close')
end

% sets value to empty
value = [];

%% ¡tests!

%%% ¡excluded_props!
[ExporterGroupSubjectST_MP_TXT.PUT_DIR]

%%% ¡test!
%%%% ¡name!
Delete directory TBE
%%%% ¡probability!
1
%%%% ¡code!
warning('off', 'MATLAB:DELETE:FileNotFound')
dir_to_be_erased = ExporterGroupSubjectST_MP_TXT.getPropDefault('DIRECTORY');
if isfolder(dir_to_be_erased)
    rmdir(dir_to_be_erased, 's')
end
warning('on', 'MATLAB:DELETE:FileNotFound')

%%% ¡test!
%%%% ¡name!
Export and import
%%%% ¡probability!
.01
%%%% ¡code!
br1 = BrainRegion( ...
    'ID', 'ISF', ...
    'LABEL', 'superiorfrontal', ...
    'NOTES', 'notes1', ...
    'X', -12.6, ...
    'Y', 22.9, ...
    'Z', 42.4 ...
    );
br2 = BrainRegion( ...
    'ID', 'lFP', ...
    'LABEL', 'frontalpole', ...
    'NOTES', 'notes2', ...
    'X', -8.6, ...
    'Y', 61.7, ...
    'Z', -8.7 ...
    );
br3 = BrainRegion( ...
    'ID', 'lRMF', ...
    'LABEL', 'rostralmiddlefrontal', ...
    'NOTES', 'notes3', ...
    'X', -31.3, ...
    'Y', 41.2, ...
    'Z', 16.5 ...
    );
br4 = BrainRegion( ...
    'ID', 'lCMF', ...
    'LABEL', 'caudalmiddlefrontal', ...
    'NOTES', 'notes4', ...
    'X', -34.6, ...
    'Y', 10.2, ...
    'Z', 42.8 ...
    );
br5 = BrainRegion( ...
    'ID', 'lPOB', ...
    'LABEL', 'parsorbitalis', ...
    'NOTES', 'notes5', ...
    'X', -41, ...
    'Y', 38.8, ...
    'Z', -11.1 ...
    );

ba = BrainAtlas( ...
    'ID', 'TestToSaveCoolID', ...
    'LABEL', 'Brain Atlas', ...
    'NOTES', 'Brain atlas notes', ...
    'BR_DICT', IndexedDictionary('IT_CLASS', 'BrainRegion', 'IT_KEY', 1, 'IT_LIST', {br1, br2, br3, br4, br5}) ...
    );

sub1 = SubjectST_MP( ...
    'ID', 'SUB ST 1', ...
    'LABEL', 'Subejct ST 1', ...
    'NOTES', 'Notes on subject ST 1', ...
    'BA', ba, ... % % %     'age', 30, ... % % %     'sex', 'female', ...
    'L', 2, ...
    'ST_MP', {rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1)} ...
    );
sub2 = SubjectST_MP( ...
    'ID', 'SUB ST 2', ...
    'LABEL', 'Subejct ST 2', ...
    'NOTES', 'Notes on subject ST 2', ...
    'BA', ba, ... % % %     'age', 40, ... % % %     'sex', 'male', ...
    'L', 2, ...
    'ST_MP', {rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1)} ...
    );
sub3 = SubjectST_MP( ...
    'ID', 'SUB ST 3', ...
    'LABEL', 'Subejct ST 3', ...
    'NOTES', 'Notes on subject ST 3', ...
    'BA', ba, ... % % %     'age', 50, ... % % %     'sex', 'female', ...
    'L', 2, ...
    'ST_MP', {rand(ba.get('BR_DICT').get('LENGTH'), 1), rand(ba.get('BR_DICT').get('LENGTH'), 1)} ...
    );

gr = Group( ...
    'ID', 'GR ST MP', ...
    'LABEL', 'Group label', ...
    'NOTES', 'Group notes', ...
    'SUB_CLASS', 'SubjectST_MP', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST_MP', 'IT_KEY', 1, 'IT_LIST', {sub1, sub2, sub3}) ...
    );

directory = [fileparts(which('test_braph2')) filesep 'trial_group_subjects_ST_MP_to_be_erased'];
if ~exist(directory, 'dir')
    mkdir(directory)
end

ex = ExporterGroupSubjectST_MP_TXT( ...
    'DIRECTORY', directory, ...
    'GR', gr ...
    );
ex.get('SAVE');

% import with same brain atlas
im1 = ImporterGroupSubjectST_MP_TXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)], ...
    'BA', ba ...
    );
gr_loaded1 = im1.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded1.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded1.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded1.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('LABEL'), sub_loaded.get('LABEL')) & ...
        isequal(sub.get('NOTES'), sub_loaded.get('NOTES')) & ...
        isequal(sub.get('BA'), sub_loaded.get('BA')) & ... % % %         isequal(sub.get('AGE'), sub_loaded.get('AGE')) & ... % % %         isequal(sub.get('SEX'), sub_loaded.get('SEX')) & ...
        isequal(sub.get('L'), sub_loaded.get('L')) & ...
        isequal(cellfun(@(v) round(v, 10), sub.get('ST_MP'), 'UniformOutput', false), cellfun(@(v) round(v, 10), sub_loaded.get('ST_MP'), 'UniformOutput', false)), ...
        [BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

% import with new brain atlas
im2 = ImporterGroupSubjectST_MP_TXT( ...
    'DIRECTORY', [directory filesep() gr.get(Group.ID)] ...
    );
gr_loaded2 = im2.get('GR');

assert(gr.get('SUB_DICT').get('LENGTH') == gr_loaded2.get('SUB_DICT').get('LENGTH'), ...
	[BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.FAIL_TEST], ...
    'Problems saving or loading a group.')
for i = 1:1:max(gr.get('SUB_DICT').get('LENGTH'), gr_loaded2.get('SUB_DICT').get('LENGTH'))
    sub = gr.get('SUB_DICT').get('IT', i);
    sub_loaded = gr_loaded2.get('SUB_DICT').get('IT', i);    
    assert( ...
        isequal(sub.get('ID'), sub_loaded.get('ID')) & ...
        isequal(sub.get('LABEL'), sub_loaded.get('LABEL')) & ...
        isequal(sub.get('NOTES'), sub_loaded.get('NOTES')) & ...
        ~isequal(sub.get('BA').get('ID'), sub_loaded.get('BA').get('ID')) & ... % % %         isequal(sub.get('AGE'), sub_loaded.get('AGE')) & ... % % %         isequal(sub.get('SEX'), sub_loaded.get('SEX')) & ...
        isequal(sub.get('L'), sub_loaded.get('L')) & ...
        isequal(cellfun(@(v) round(v, 10), sub.get('ST_MP'), 'UniformOutput', false), cellfun(@(v) round(v, 10), sub_loaded.get('ST_MP'), 'UniformOutput', false)), ...
        [BRAPH2.STR ':ExporterGroupSubjectST_MP_TXT:' BRAPH2.FAIL_TEST], ...
        'Problems saving or loading a group.')    
end

rmdir(directory, 's')