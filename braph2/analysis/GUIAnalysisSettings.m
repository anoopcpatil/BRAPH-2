function GUIAnalysisSettings(tmp, analysis_class)

%% General Constants
APPNAME = GUI.GA_NAME;
BUILD = BRAPH2.BUILD;

% Panels Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .19;
COHORT_HEIGHT = .12;
TAB_HEIGHT = .20;
FILENAME_HEIGHT = .02;

MAINPANEL_X0 = LEFTCOLUMN_WIDTH + 2 * MARGIN_X;
MAINPANEL_Y0 = FILENAME_HEIGHT + TAB_HEIGHT + 3 * MARGIN_Y;
MAINPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
MAINPANEL_HEIGHT = 1 - TAB_HEIGHT - FILENAME_HEIGHT - 4 * MARGIN_Y;
MAINPANEL_POSITION = [MAINPANEL_X0 MAINPANEL_Y0 MAINPANEL_WIDTH MAINPANEL_HEIGHT];

% Commands
OPEN_CMD = GUI.OPEN_CMD; 
OPEN_SC = GUI.OPEN_SC;
OPEN_TP = ['Open Analysis. Shortcut: ' GUI.ACCELERATOR '+' OPEN_SC];

SAVE_CMD = GUI.SAVE_CMD;
SAVE_SC = GUI.SAVE_SC;
SAVE_TP = ['Save current Analysis. Shortcut: ' GUI.ACCELERATOR '+' SAVE_SC];

SAVEAS_CMD = GUI.SAVEAS_CMD;

CLOSE_CMD = GUI.CLOSE_CMD;
CLOSE_SC = GUI.CLOSE_SC;

FIGURE_CMD = GUI.FIGURE_CMD;
FIGURE_SC = GUI.FIGURE_SC;

CLOSE_TP = ['Close ' APPNAME '. Shortcut: ' GUI.ACCELERATOR '+' CLOSE_SC]; %#ok<NASGU>

initial_number_childs = 0;
maesures_rules = [];

%% Application Data
analysis_list = Analysis.getList();
if exist('tmp', 'var') && ismember(class(tmp), analysis_list) % pass an analysis
    ga = Analysis.getAnalysis(tmp);
    cohort = ga.getCohort();
elseif exist('tmp', 'var') && isa(tmp, 'Cohort') && exist('analysis_class', 'var') % pass a cohort
    % defaul will be WU
    ga = Analysis.getAnalysis(analysis_class, '', '', '', tmp, {}, {}, {});    
    cohort = ga.getCohort();
else % string of analysis class    
     assert(ismember(tmp, analysis_list));     
     subject_type = Analysis.getSubjectClass(tmp);         
    
     atlas = BrainAtlas('', 'Brain Atlas Label', 'Brain atlas notes.', 'BrainMesh_ICBM152.nv', {});
     cohort = Cohort('', 'cohort label', 'cohort notes', subject_type, atlas, {});
     ga = Analysis.getAnalysis(tmp, '', '', '', cohort, {}, {}, {});        
end

    function cb_open(~, ~)
        % select file
         [file,path,filterindex] = uigetfile(GUI.GA_EXTENSION, GUI.GA_MSG_GETFILE);
        % load file
        if filterindex
            filename = fullfile(path, file);
            temp = load(filename, '-mat', 'ga', 'BUILD');
            if isfield(temp, 'BUILD') && temp.BUILD >= 2020 && ...
                   isfield(temp, 'ga') && ...
                   ismember(temp.getClass(), analysis_list)
                ga = temp.ga;
                GUIAnalysisSettings(ga)
            end
        end
    end
    function cb_save(~, ~)
        filename = get(ui_text_filename, 'String');
        if isempty(filename)
            cb_saveas();
        else
            save(filename, 'ga', 'cohort', 'BUILD');  % prob not cohort
        end
    end
    function cb_saveas(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(GUI.GA_EXTENSION, GUI.GA_MSG_PUTFILE);
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename, 'ga', 'BUILD');
            update_filename(filename)
        end
    end
 

%% GUI Init
f = GUI.init_figure(APPNAME, .9, .9, 'center');
    function init_disable()
        GUI.disable(ui_matrix_panel)
        GUI.disable(ui_graph_settings)
        GUI.disable(ui_measures_panel)  
        set(ui_matrix_panel, 'Visible', 'off')
        set(ui_table_calc, 'enable', 'off')
        
        childs = allchild(ui_graph_setttings_inner_panel);
        if initial_number_childs == 0
            initial_number_childs = length(childs);
        end        
        for j = initial_number_childs:-1:1           
           set(childs(j), 'enable', 'off')
        end
    end
    function init_enable()
        GUI.enable(ui_matrix_panel)
        GUI.enable(ui_graph_settings)
        GUI.enable(ui_measures_panel)
        set(ui_matrix_panel, 'Visible', 'on')
        childs = allchild(ui_graph_setttings_inner_panel);
        if initial_number_childs == 0
            initial_number_childs = length(childs);
        end        
        for j = initial_number_childs:-1:1           
           set(childs(j), 'enable', 'on')
           set(ui_table_calc, 'enable', 'on')
        end
    end

%% Text File Name
FILENAME_WIDTH = 1 - 2 * MARGIN_X;
FILENAME_POSITION = [MARGIN_X MARGIN_Y FILENAME_WIDTH FILENAME_HEIGHT];

ui_text_filename = uicontrol('Style', 'text');
init_filename()
    function init_filename()
        GUI.setUnits(ui_text_filename)
        GUI.setBackgroundColor(ui_text_filename)
        
        set(ui_text_filename, 'Position', FILENAME_POSITION)
        set(ui_text_filename, 'HorizontalAlignment', 'left')
    end
    function update_filename(filename)
        set(ui_text_filename, 'String', [filename ' Settings'])
    end

%% Panel Cohort
COHORT_NAME = 'Cohort';
COHORT_WIDTH = LEFTCOLUMN_WIDTH;
COHORT_X0 = MARGIN_X;
COHORT_Y0 = 1 - MARGIN_Y - COHORT_HEIGHT;
COHORT_POSITION = [COHORT_X0 COHORT_Y0 COHORT_WIDTH COHORT_HEIGHT];

COHORT_BUTTON_SELECT_CMD = 'Select Cohort';
COHORT_BUTTON_SELECT_TP = 'Select file (*.cohort) from where to load a Cohort';

COHORT_BUTTON_VIEW_CMD = 'View Cohort ...';
COHORT_BUTTON_VIEW_TP = ['Open Cohort with ' GUI.CE_NAME '.'];

ui_panel_cohort = uipanel();
ui_text_cohort_name = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_text_cohort_subjectnumber = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_text_cohort_groupnumber = uicontrol(ui_panel_cohort, 'Style', 'text');
ui_button_cohort = uicontrol(ui_panel_cohort, 'Style', 'pushbutton');
init_cohort()
    function init_cohort()
        GUI.setUnits(ui_panel_cohort)
        GUI.setBackgroundColor(ui_panel_cohort)
        
        set(ui_panel_cohort, 'Position', COHORT_POSITION)
        set(ui_panel_cohort, 'Title', COHORT_NAME)
        
        set(ui_text_cohort_name, 'Position', [.05 .60 .50 .20])
        set(ui_text_cohort_name, 'HorizontalAlignment', 'left')
        set(ui_text_cohort_name, 'FontWeight', 'bold')
        
        set(ui_text_cohort_subjectnumber, 'Position', [.05 .40 .50 .20])
        set(ui_text_cohort_subjectnumber, 'HorizontalAlignment', 'left')
        
        set(ui_text_cohort_groupnumber, 'Position', [.05 .20 .50 .20])
        set(ui_text_cohort_groupnumber, 'HorizontalAlignment', 'left')
        
        set(ui_button_cohort, 'Position', [.55 .30 .40 .40])
        set(ui_button_cohort, 'Callback', {@cb_cohort})
    end
    function update_cohort()
        if ~isempty(cohort) && ~isequal(cohort.getID(), '')
            set(ui_text_cohort_name, 'String', cohort.getID())
            set(ui_text_cohort_subjectnumber, 'String', ['subject number = ' num2str(cohort.getSubjects().length())])
            set(ui_text_cohort_groupnumber, 'String', ['group number = ' num2str(cohort.getGroups().length())])
            set(ui_button_cohort, 'String', COHORT_BUTTON_VIEW_CMD)
            set(ui_button_cohort, 'TooltipString', COHORT_BUTTON_VIEW_TP);
            init_enable()
        else
            set(ui_text_cohort_name, 'String', '- - -')
            set(ui_text_cohort_subjectnumber, 'String', 'subject number = 0')
            set(ui_text_cohort_groupnumber, 'String', 'group number = 0')
            set(ui_button_cohort, 'String', COHORT_BUTTON_SELECT_CMD)
            set(ui_button_cohort, 'TooltipString', COHORT_BUTTON_SELECT_TP);
            init_disable()
        end
    end
    function cb_cohort(src, ~)  % (src,event)
        % missing BUD and BUT compatibility
        if strcmp(get(src, 'String'), COHORT_BUTTON_VIEW_CMD)
            GUICohort(ga.getCohort(), true)  % open atlas with restricted permissions
        else
            try
                % select file
                [file,path,filterindex] = uigetfile(GUI.CE_EXTENSION, GUI.CE_MSG_GETFILE);
                % load file
                if filterindex
                    filename = fullfile(path, file);
                    temp = load(filename, '-mat', 'cohort', 'selected_group', 'selected_subjects', 'BUILD');
                    if isfield(temp, 'BUILD') && temp.BUILD >= 2020 && ...
                            isfield(temp, 'cohort') && isa(temp.cohort, 'Cohort') && ...
                            isfield(temp, 'selected_group') && isfield(temp, 'selected_subjects')
                        cohort = temp.cohort;
                        analysis = ga.getClass();                          
                        ga = Analysis.getAnalysis(analysis, ['Empty GA with ' cohort.getID()], '', '', cohort, {}, {}, {});
                    end                    
                    setup()                    
                end
            catch ME
                errordlg(ME.error)
%                 errordlg('The file is not a valid Cohort file. Please load a valid .cohort file');
            end
        end
    end

%% Panel - Settings
SET_WIDTH = LEFTCOLUMN_WIDTH;
SET_HEIGHT = MAINPANEL_HEIGHT - COHORT_HEIGHT - MARGIN_Y;
SET_X0 = MARGIN_X;
SET_Y0 = FILENAME_HEIGHT + TAB_HEIGHT + 3 * MARGIN_Y;
SET_POSITION = [SET_X0 SET_Y0 SET_WIDTH SET_HEIGHT];

ui_graph_settings = uipanel();
ui_graph_analysis_id = uicontrol(ui_graph_settings, 'Style', 'edit');
ui_graph_analysis_label = uicontrol(ui_graph_settings, 'Style', 'edit');
ui_graph_analysis_notes = uicontrol(ui_graph_settings, 'Style', 'edit');
ui_graph_setttings_inner_panel = uipanel(ui_graph_settings);
ui_graph_settings_analysis_button = uicontrol(ui_graph_settings, 'Style', 'pushbutton');

init_graph_settings()
    function init_graph_settings()
        GUI.setUnits(ui_graph_settings)
        GUI.setBackgroundColor(ui_graph_settings)
        
        set(ui_graph_settings, 'Position', SET_POSITION)
        set(ui_graph_settings, 'BorderType', 'none')        
        
        set(ui_graph_setttings_inner_panel, 'Position', [0 0.15 0.98 .7])
        set(ui_graph_setttings_inner_panel, 'Title', 'Analysis Settings')
        set(ui_graph_setttings_inner_panel, 'Units', 'normalized')        
        
        set(ui_graph_analysis_id, 'Position', [0 .95 .36 .03])
        set(ui_graph_analysis_id, 'HorizontalAlignment', 'left')
        set(ui_graph_analysis_id, 'FontWeight', 'bold')
        set(ui_graph_analysis_id, 'Callback', {@cb_calc_ga_id})
        
        set(ui_graph_analysis_label, 'Position', [.42 .95 .56 .03])
        set(ui_graph_analysis_label, 'HorizontalAlignment', 'left')
        set(ui_graph_analysis_label, 'FontWeight', 'bold')
        set(ui_graph_analysis_label, 'Callback', {@cb_calc_ga_label})
        
        set(ui_graph_analysis_notes, 'Position', [.42 .90 .56 .03])
        set(ui_graph_analysis_notes, 'HorizontalAlignment', 'left')
        set(ui_graph_analysis_notes, 'FontWeight', 'bold')
        set(ui_graph_analysis_notes, 'Callback', {@cb_calc_ga_notes}) 
       
        
        available_settings = ga.getAvailableSettings();
        texts = zeros(length(available_settings), 1);
        fields =  zeros(length(available_settings), 1);
        inner_panel_height = 1/length(available_settings); 
        subject = ga.getSubjectClass();
        dc = Subject.getDataCodes(subject);
        
        for j = 1:1:length(available_settings)
            as = available_settings{j};
            y_correction = 0.05;
            inner_panel_y = 1 - j * inner_panel_height + y_correction; 

            texts(j, 1) = uicontrol('Parent', ui_graph_setttings_inner_panel, 'Style', 'text', ...
                 'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'left', 'Position', [0.01 inner_panel_y 0.50 0.07], 'String', erase(as{1,1}, ['Analysis' dc{1} '.']));
            
            fields(j, 1) = uicontrol('Parent', ui_graph_setttings_inner_panel,  ...
                'Units', 'normalized', 'Position', [0.58 inner_panel_y+0.04 0.40 0.03] );
 
            if isequal(as{1, 2}, 1) % string
                set(fields(j, 1), 'Style', 'popup');
                set(fields(j, 1), 'String', as{1, 4})
                set(fields(j, 1), 'HorizontalAlignment', 'left')
                set(fields(j, 1), 'FontWeight', 'bold')
                set(fields(j, 1), 'Callback', {@cb_analysis_settings_popup})
            elseif isequal(as{1, 2}, 2) % numerical
                set(fields(j, 1), 'Style', 'edit');
                set(fields(j, 1), 'Position', [0.58 inner_panel_y+0.03 0.40 0.04]);
                set(fields(j, 1), 'String', as{1, 3})  % put default
                set(fields(j, 1), 'Callback', {@cb_analysis_settings_popup})
            else % logical                
                set(fields(j, 1), 'Style', 'popup');
                set(fields(j, 1), 'String', {'true', 'false'}) 
                set(fields(j, 1), 'FontWeight', 'bold')
                set(fields(j, 1), 'Callback', {@cb_analysis_settings_popup})
            end
        end

        set(ui_graph_settings_analysis_button, 'Position', [.20 .02 .60 .08])
        set(ui_graph_settings_analysis_button, 'String', 'Start Analysis ...')
        set(ui_graph_settings_analysis_button, 'TooltipString', 'Start Analysis')
        set(ui_graph_settings_analysis_button, 'Callback', {@cb_calc_settings_start_analysis})
    end
    function update_set_ga_id()       
        if isempty(ga.getID())
            set(f, 'Name', [GUI.GA_NAME ' Settings - ' BRAPH2.VERSION])
        else
            set(f, 'Name', [GUI.GA_NAME ' Settings - ' ga.getID()  ])
        end
        set(ui_graph_analysis_id, 'String', ga.getID())
    end
    function cb_calc_ga_id(~, ~)
        ga.setID(get(ui_graph_analysis_id, 'String'))
        update_set_ga_id()
    end
    function cb_calc_ga_label(~, ~)
        ga.setLabel(get(ui_graph_analysis_label, 'String'))
    end
    function cb_calc_ga_notes(~, ~)
        ga.setNotes(get(ui_graph_analysis_notes, 'String'))
    end
    function cb_analysis_settings_popup(~, ~)
        childs = allchild(ui_graph_setttings_inner_panel);
        if initial_number_childs == 0
            initial_number_childs = length(childs);
        end
        subject = ga.getSubjectClass();
        dc = Subject.getDataCodes(subject); 
        for j = initial_number_childs:-1:1
            % text, value : pairs values, nonpair is name
            k  = initial_number_childs - j + 1;
            if rem(j, 2) == 0
                correlation_rules_array{k} = ['Analysis' dc{1} '.' childs(j).String];
            else
                if childs(j).Value >= 1
                    correlation_rules_array{k} = childs(j).String{childs(j).Value};
                else
                    correlation_rules_array{k} = childs(j).String;
                end
            end            
        end
        analysis = ga.getClass();
        ga = Analysis.getAnalysis(analysis, ['Empty GA with ' cohort.getID()], '', '', cohort, {}, {}, {}, correlation_rules_array);
        setup(); 
    end
    function cb_calc_settings_start_analysis(~, ~)
        GUIAnalysis(ga, maesures_rules)
    end

%% Panel - Measure Table
TAB_LOGICAL_COL = 1;
TAB_NAME_COL = 2;
TAB_NODAL_COL = 3;
TAB_NODAL = 'Nodal';
TAB_GLOBAL = 'Global';
TAB_BINODAL = 'Binodal';
TAB_LAYER_COL = 4;
TAB_UNILAYER = 'Unilayer';
TAB_BILAYER = 'Bilayer';
TAB_SUPERGLOBAL = 'Super Global';
TAB_TXT_COL = 5;

selected_measure = [];

TAB_WIDTH = 1 - 1.25 * MARGIN_X;
TAB_X0 = MARGIN_X;
TAB_Y0 = 2 * MARGIN_Y + FILENAME_HEIGHT;
TAB_POSITION = [TAB_X0 TAB_Y0 TAB_WIDTH TAB_HEIGHT];

ui_measures_panel = uipanel();
ui_table_calc = uitable(ui_measures_panel);
ui_measures_settings_panel = uipanel(ui_measures_panel);
init_measures_table_panel()
    function init_measures_table_panel()
        GUI.setUnits(ui_measures_panel)
        GUI.setBackgroundColor(ui_measures_panel)
        
        set(ui_measures_panel, 'Position', TAB_POSITION)
        set(ui_measures_panel, 'BorderType', 'none')
        
        set(ui_table_calc, 'Position', [0 0.02 0.7 0.98])   
        set(ui_table_calc, 'ColumnName', {'', '   Brain Measure   ', '  Format  ', '  Scope  ' , '   Notes   '})
        set(ui_table_calc, 'ColumnFormat', {'logical', 'char', {TAB_NODAL TAB_GLOBAL TAB_BINODAL}, {TAB_UNILAYER TAB_BILAYER TAB_SUPERGLOBAL} , 'char'})
        set(ui_table_calc, 'ColumnEditable', [true false false false false])
        set(ui_table_calc, 'ColumnWidth', {GUI.width(f, 0.02 * TAB_WIDTH), GUI.width(f, .15 * TAB_WIDTH), GUI.width(f, .07 * TAB_WIDTH), GUI.width(f, .07 * TAB_WIDTH), GUI.width(f, .68 * TAB_WIDTH)})
        set(ui_table_calc, 'CellEditCallback', {@cb_measure_tbl})
        
        set(ui_measures_settings_panel, 'Units', 'Normalized')
        set(ui_measures_settings_panel, 'Position', [0.702 0 0.29 1])
        
    end
    function update_tab()     
        mlist = measurelist();
        
        data = cell(length(mlist), 3);
        for mi = 1:1:length(mlist)
            if any(selected_measure == mi)
                data{mi, TAB_LOGICAL_COL} = true;
            else
                data{mi, TAB_LOGICAL_COL} = false;
            end
            data{mi, TAB_NAME_COL} = Measure.getName(mlist{mi});
            if Measure.is_nodal(mlist{mi})
                data{mi, TAB_NODAL_COL} = TAB_NODAL;               
            elseif Measure.is_global(mlist{mi})
                data{mi, TAB_NODAL_COL} = TAB_GLOBAL;
            else
                data{mi, TAB_NODAL_COL} = TAB_BINODAL;
            end
            
            if Measure.is_superglobal(mlist{mi})
                data{mi, TAB_LAYER_COL} = TAB_SUPERGLOBAL;
            elseif Measure.is_unilayer(mlist{mi})
                data{mi, TAB_LAYER_COL} = TAB_UNILAYER;
            else
                data{mi, TAB_LAYER_COL} = TAB_BILAYER;
            end
            
            data{mi, TAB_TXT_COL} = Measure.getDescription(mlist{mi});
        end
        set(ui_table_calc, 'Data', data)
    end
    function mlist = measurelist()             
        mlist = Graph.getCompatibleMeasureList(ga.getGraphType());
    end
    function cb_measure_tbl(~, event)
        g = event.Indices(1);
        col = event.Indices(2);
        newdata = event.NewData;
        switch col
            case TAB_LOGICAL_COL
                if newdata == 1
                    selected_measure = g;
                else
                    selected_measure = [];
                end
        end
        update_tab()
        update_measure_settings_panel()
    end
    function update_measure_settings_panel()
        mlist = measurelist();
        if ~isempty(selected_measure)
            cleanUpChilds(ui_measures_settings_panel);
            measure = mlist{selected_measure};
            measure_settings = Measure.getAvailableSettings(measure);
            
            if isempty(measure_settings) && Measure.is_nonparametric(measure)
                set(ui_measures_settings_panel, 'Visible', 'off')            
            elseif ~isempty(measure_settings)  && Measure.is_nonparametric(measure)
                set(ui_measures_settings_panel, 'Visible', 'on')
                measure_labels = zeros(size(measure_settings, 1), 1);
                measure_fields =  zeros(size(measure_settings, 1), 1);
                inner_measure_panel_height = 1/length(measure_settings);
                
                for j = 1:1:size(measure_settings, 1)
                    if size(measure_settings, 1) == 1
                        ms = measure_settings;
                    else
                        ms = measure_settings{j};
                    end
                    
                    y_correction = 0.1;
                    inner_panel_y = 1 - j * inner_measure_panel_height + y_correction;
                    
                    measure_labels(j, 1) = uicontrol('Parent', ui_measures_settings_panel, 'Style', 'text', ...
                        'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'left', 'Position', [0.01 inner_panel_y-0.2 0.50 0.2], 'String', ms{1,1});
                    
                    measure_fields(j, 1) = uicontrol('Parent', ui_measures_settings_panel,  ...
                        'Units', 'normalized', 'Position', [0.58 inner_panel_y 0.40 0.003] );
                    
                    if isequal(ms{1, 2}, 1) % string
                        set(measure_fields(j, 1), 'Style', 'popup');
                        set(measure_fields(j, 1), 'String', ms{1, 4})
                        set(measure_fields(j, 1), 'HorizontalAlignment', 'left')
                        set(measure_fields(j, 1), 'FontWeight', 'bold')
                        set(measure_fields(j, 1), 'Callback', {@cb_measure_settings})
                    elseif isequal(ms{1, 2}, 2) % numerical
                        set(measure_fields(j, 1), 'Style', 'edit');
                        set(measure_fields(j, 1), 'String', ms{1, 3})  % put default
                        set(measure_fields(j, 1), 'Callback', {@cb_measure_settings})
                    else % logical
                        set(measure_fields(j, 1), 'Style', 'popup');
                        set(measure_fields(j, 1), 'String', {'true', 'false'})
                        set(measure_fields(j, 1), 'Callback', {@cb_measure_settings})
                    end
                end
            elseif ~isempty(measure_settings) && Measure.is_parametric(measure)
                parameter_name = Measure.getParameterName(measure);
                set(ui_measures_settings_panel, 'Visible', 'on')
                measure_labels = zeros(size(measure_settings, 1) + 1, 1);
                measure_fields = zeros(size(measure_settings, 1) + 1, 1);
                inner_measure_panel_height = 1 / (length(measure_settings) + 1);                
                y_correction = 0.1;
                
                for j = 1:1:size(measure_settings, 1)
                    if size(measure_settings, 1) == 1
                        ms = measure_settings;
                    else
                        ms = measure_settings{j};
                    end
                    
                    inner_panel_y = 1 - j * inner_measure_panel_height + y_correction;
                    
                    measure_labels(j, 1) = uicontrol('Parent', ui_measures_settings_panel, 'Style', 'text', ...
                        'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'left', 'Position', [0.01 inner_panel_y-0.2 0.50 0.2], 'String', ms{1,1});
                    
                    measure_fields(j, 1) = uicontrol('Parent', ui_measures_settings_panel,  ...
                        'Units', 'normalized', 'Position', [0.58 inner_panel_y 0.40 0.08] );
                    
                    if isequal(ms{1, 2}, 1) % string
                        set(measure_fields(j, 1), 'Style', 'popup');
                        set(measure_fields(j, 1), 'String', ms{1, 4})
                        set(measure_fields(j, 1), 'HorizontalAlignment', 'left')
                        set(measure_fields(j, 1), 'FontWeight', 'bold')
                        set(measure_fields(j, 1), 'Callback', {@cb_measure_settings})
                    elseif isequal(ms{1, 2}, 2) % numerical
                        set(measure_fields(j, 1), 'Style', 'edit');
                        set(measure_fields(j, 1), 'Position', [0.58 inner_panel_y-0.1 0.40 0.1]);
                        set(measure_fields(j, 1), 'String', ms{1, 3})  % put default
                        set(measure_fields(j, 1), 'Callback', {@cb_measure_settings})
                    else % logical
                        set(measure_fields(j, 1), 'Style', 'popup');
                        set(measure_fields(j, 1), 'String', {'true', 'false'})
                        set(measure_fields(j, 1), 'Callback', {@cb_measure_settings})
                    end
                end
                
                inner_panel_y = 1 - size(measure_labels, 1) * inner_measure_panel_height + y_correction;
                measure_labels(end, 1) = uicontrol('Parent', ui_measures_settings_panel, 'Style', 'text', ...
                    'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'left', 'Position', [0.01 inner_panel_y-0.2 0.50 0.2], 'String', parameter_name); %#ok<NASGU>
                measure_fields(end, 1) = uicontrol('Parent', ui_measures_settings_panel,  ...
                    'Units', 'normalized', 'Position', [0.58 inner_panel_y-0.1 0.40 0.1] );
                
                set(measure_fields(end, 1), 'Style', 'edit');
                set(measure_fields(end, 1), 'String', '0')  % put default
                set(measure_fields(end, 1), 'Callback', {@cb_parametric_settings})
            else                
                parameter_name = Measure.getParameterName(measure);
                set(ui_measures_settings_panel, 'Visible', 'on')
                
                parameter_label = uicontrol('Parent', ui_measures_settings_panel, 'Style', 'text', ...
                    'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'left', ...
                    'Position', [0.01 0.7 0.50 0.2], 'String', parameter_name); %#ok<NASGU>
                parameter_edit = uicontrol('Parent', ui_measures_settings_panel,  ...
                    'Units', 'normalized', 'Position', [0.58 0.8 0.40 0.1], ...
                    'Style', 'edit', 'String', '0', 'Callback', {@cb_parametric_settings}); %#ok<NASGU>
                
            end
        end
        function cb_measure_settings(src, ~)
            measure = mlist{selected_measure};
            measure_settings = Measure.getAvailableSettings(measure);
            if isequal(src.Style, 'popupmenu') 
                selection = src.String{src.Value};
                maesures_rules{end + 1} = measure_settings{1, 1}; 
                maesures_rules{end + 1} = selection;
            elseif  isequal(src.Style, 'edit')
                maesures_rules{end + 1} = measure_settings{1, 1};
                maesures_rules{end + 1} = src.Value;
            end
        end
        function cb_parametric_settings(src, ~)
            measure = mlist{selected_measure};
            parameter_name = Measure.getParameterName(measure);
            if isequal(src.Style, 'edit')
                maesures_rules{end + 1} = parameter_name;
                maesures_rules{end + 1} = src.Value;
            end
        end
    end
    function cleanUpChilds(ui_object)
        childs = allchild(ui_object);        
        for i = 1:1:length(childs)
            set(childs(i), 'visible', 'off')
        end
    end

%% Panel Plot Matrix
CONSOLE_MATRIX_CMD  = 'Correlation Matrix';

ui_matrix_panel = uipanel();
ui_matrix_axes = axes();
init_matrix()
    function init_matrix()
        GUI.setUnits(ui_matrix_panel)
        GUI.setBackgroundColor(ui_matrix_panel)
        
        set(ui_matrix_panel, 'Position', MAINPANEL_POSITION)
        set(ui_matrix_panel, 'Title', CONSOLE_MATRIX_CMD)
        
        set(ui_matrix_axes,'Parent', ui_matrix_panel)
        set(ui_matrix_axes,'Position', [.05 .05 .60 .88])
    end
    function update_matrix()     
        childs = allchild(ui_graph_setttings_inner_panel);
        if initial_number_childs == 0
            initial_number_childs = length(childs);
        end
        subject = ga.getSubjectClass();
        dc = Subject.getDataCodes(subject); 
        for j = initial_number_childs:-1:1
            % text, value : pairs values, nonpair is name
            k  = initial_number_childs - j + 1;
            if rem(j, 2) == 0
                correlation_rules_array{k} = ['Analysis' dc{1} '.' childs(j).String];
            else
                if childs(j).Value >= 1
                    correlation_rules_array{k} = childs(j).String{childs(j).Value};
                else
                    correlation_rules_array{k} = childs(j).String;
                end
            end            
        end
        
        ga.getGraphPanel('UIParent', ui_matrix_panel, 'UIParentAxes', ui_matrix_axes, correlation_rules_array{:})
    end

%% Menus
MENU_FILE = GUI.MENU_FILE;
MENU_FIGURE = 'Figure'; %#ok<NASGU>

ui_menu_file = uimenu(f, 'Label', MENU_FILE);
ui_menu_file_open = uimenu(ui_menu_file);
ui_menu_file_save = uimenu(ui_menu_file);
ui_menu_file_saveas = uimenu(ui_menu_file);
ui_menu_file_close = uimenu(ui_menu_file);
ui_menu_plotview = uimenu(f, 'Label', 'Plot View');
ui_menu_plotview_figure = uimenu(ui_menu_plotview);
init_menu()
    function init_menu()
        set(ui_menu_file_open, 'Label', OPEN_CMD)
        set(ui_menu_file_open, 'Accelerator', OPEN_SC)
        set(ui_menu_file_open, 'Callback', {@cb_open})
        
        set(ui_menu_file_save, 'Separator', 'on')
        set(ui_menu_file_save, 'Label', SAVE_CMD)
        set(ui_menu_file_save, 'Accelerator', SAVE_SC)
        set(ui_menu_file_save, 'Callback', {@cb_save})
        
        set(ui_menu_file_saveas, 'Label', SAVEAS_CMD)
        set(ui_menu_file_saveas, 'Callback', {@cb_saveas});
        
        set(ui_menu_file_close, 'Separator', 'on')
        set(ui_menu_file_close, 'Label', CLOSE_CMD)
        set(ui_menu_file_close, 'Accelerator', CLOSE_SC);
        set(ui_menu_file_close, 'Callback', ['GUI.close(''' APPNAME ''', gcf)'])
        
        set(ui_menu_plotview_figure, 'Label', FIGURE_CMD)
        set(ui_menu_plotview_figure, 'Accelerator', FIGURE_SC)
        set(ui_menu_plotview_figure, 'Callback', {@cb_menu_figure})
        
    end
[ui_menu_about, ui_menu_about_about] = GUI.setMenuAbout(f, APPNAME); %#ok<ASGLU>
    function cb_menu_figure(~, ~)  % (src, event)
        h = figure('Name', ['Correlation Matrix - ' ga.getName()]);
        set(gcf, 'Color', 'w')        
        copyobj(ui_matrix_axes, h)
        set(gca, 'Units', 'normalized')
        set(gca, 'OuterPosition', [0 0 1 1])        
        colormap jet
    end

%% Toolbar
set(f, 'Toolbar', 'figure')
ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
ui_toolbar_open = findall(ui_toolbar, 'Tag', 'Standard.FileOpen');
ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');
init_toolbar()
    function init_toolbar()
        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        % delete(findall(ui_toolbar, 'Tag', 'Standard.FileOpen'))
        % delete(findall(ui_toolbar, 'Tag', 'Standard.SaveFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.ZoomIn'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.ZoomOut'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.Pan'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Rotate'))
        %delete(findall(ui_toolbar, 'Tag', 'Exploration.DataCursor'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
        delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
        %delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertColorbar'))
        delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
        
        set(ui_toolbar_open, 'TooltipString', OPEN_TP);
        set(ui_toolbar_open, 'ClickedCallback', {@cb_open})
        set(ui_toolbar_save, 'TooltipString', SAVE_TP);
        set(ui_toolbar_save, 'ClickedCallback', {@cb_save})
    end

%% Make the GUI visible.
setup()
set(f, 'Visible', 'on');

%% Auxiliary functions
    function setup()        
        % setup cohort
        update_cohort()        
        
        % setup graph analysis
        update_tab()
        update_matrix()
        
        % setup data
        update_set_ga_id()
    end
end