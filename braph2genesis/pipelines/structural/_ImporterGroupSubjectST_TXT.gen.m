%% ¡header!
ImporterGroupSubjectST_TXT < Importer (im, importer of ST subject group from TXT) imports a group of subjects with structural data from an TXT file.

%%% ¡description!
ImporterGroupSubjectST_TXT imports a group of subjects with structural data from an TXT file and their covariates from another TXT file.
The TXT file consists of the following columns: 
Subject ID (column 1), Subject LABEL (column 2), Subject NOTES (column 3) and
BrainRegions (column 4-end; one brainregion value per column).
The first row contains the headers and each subsequent row the values for each subject.
The TXT file containing the covariates must be in the same directory and have the name as: groupname_covariates.txt
where groupname corresponds to the name of the file containing the data. It consists of the following columns:
Subject ID (column 1), Subject AGE (column 2), and Subject SEX (column 3).
The first row contains the headers and each subsequent row the values for each subject.
It throws an error is problems occur during the import.

%%% ¡seealso!
Element, Importer, ExporterGroupSubjectST_TXT

%% ¡props!

%%% ¡prop!
FILE (data, string) is the TXT file from where to load the ST subject group.
%%%% ¡default!
''

%%% ¡prop!
BA (data, item) is a brain atlas.
%%%% ¡settings!
'BrainAtlas'

%%% ¡prop!
GR (result, item) is a group of subjects with structural data.
%%%% ¡settings!
'Group'
%%%% ¡check_value!
check = any(strcmp(value.get(Group.SUB_CLASS_TAG), subclasses('SubjectST', [], [], true))); % Format.checkFormat(Format.ITEM, value, 'Group') already checked
%%%% ¡default!
Group('SUB_CLASS', 'SubjectST', 'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST'))
%%%% ¡calculate!
% creates empty Group
gr = Group( ...
    'SUB_CLASS', 'SubjectST', ...
    'SUB_DICT', IndexedDictionary('IT_CLASS', 'SubjectST') ...
    );

gr.lock('SUB_CLASS');
% analyzes file
file = im.get('FILE');
if ~isfile(file) && ~braph2_testing()
    im.uigetfile()
    file = im.memorize('FILE');
end
if isfile(file)
    if im.get('WAITBAR')
        wb = waitbar(0, 'Reading File ...', 'Name', BRAPH2.NAME);
        set_braph2_icon(wb)
    end    
    
    raw = textread(file, '%s', 'delimiter', '\t', 'whitespace', '');
    raw = raw(~cellfun('isempty', raw));  % remove empty cells
    raw2 = readtable(file, 'Delimiter', '\t');
    
    % Check if there are covariates to add (age and sex)
    [filepath, filename, ~] = fileparts(file);
    if isfile([filepath filesep() filename '_covariates.txt'])
        raw_covariates = readtable([filepath filesep() filename '_covariates.txt'], 'Delimiter', '\t');
        age = raw_covariates{:, 2};
        sex = raw_covariates{:, 3};
    else
        age = ones(size(raw2, 1),1);
        unassigned =  {'unassigned'};
        sex = unassigned(ones(size(raw2, 1), 1));
    end
    
    % sets group props
    if im.get('WAITBAR')
        waitbar(.15, wb, 'Loading subject group ...');
    end
        
    try
        [~, name, ext] = fileparts(file);
        gr.set( ...
            'ID', name, ...
            'LABEL', [name ext], ...
            'NOTES', ['Group loaded from ' file] ...
            );
        
        % brain atlas
        if im.get('WAITBAR')
            waitbar(.30, wb, 'Loading brain atlas ...')
        end
        
        ba = im.get('BA');
        br_number = size(raw2, 2) - 3;
        if ba.get('BR_DICT').length ~= br_number
            ba = BrainAtlas();
            idict = ba.get('BR_DICT');
            for j = 4:1:size(raw2, 2)
                br_id = raw{j, 1};
                br = BrainRegion('ID', br_id);
                idict.add(br)
            end
            ba.set('br_dict', idict);
        end
        
        subdict = gr.get('SUB_DICT');
        
        % adds subjects
        for i = 1:1:size(raw2, 1)
            if im.get('WAITBAR')
                waitbar(.30 + .70 * i / size(raw2, 1), wb, ['Loading subject ' num2str(i) ' of ' num2str(size(raw2, 1)) ' ...'])
            end
            
            ST = zeros(br_number, 1);
            for j = 1:1:length(ST)
                ST(j) = raw2{i, 3 + j};
            end
            sub = SubjectST( ...
                'ID', char(raw2{i, 1}), ...
                'LABEL', char(raw2{i, 2}), ...
                'NOTES', char(raw2{i, 3}), ...
                'BA', ba, ...
                'ST', ST, ...
                'age', age(i), ...
                'sex', sex{i} ...
                );
            subdict.add(sub);
        end
        gr.set('sub_dict', subdict);
    catch e
        % warndlg('Please select a valid group file.', 'Warning');
        rethrow(e)
    end
    
    if im.get('WAITBAR')
        close(wb)
    end
elseif ~braph2_testing()
    if im.get('WAITBAR')
        close(wb)
    end
    error(BRAPH2.IM_ERR);
end

value = gr;

%% ¡methods!
function uigetfile(im)
    % UIGETFILE opens a dialog box to set the TXT file from where to load the ST subject group.
    
    [filename, filepath, filterindex] = uigetfile('*.txt', 'Select TXT file');
    if filterindex
        file = [filepath filename];
        im.set('FILE', file);
    end
end