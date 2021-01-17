function GUIAnalysis(ga, measure_rules)

%% General Constants
APPNAME = GUI.GA_NAME;
BUILD = BRAPH2.BUILD;

if nargin == 1 || isempty(measure_rules)
    measure_rules = {'', ''};
end

% Panels Dimensions
MARGIN_X = .01;
MARGIN_Y = .01;
LEFTCOLUMN_WIDTH = .19;
COHORT_HEIGHT = .11;
TAB_HEIGHT = .20;
FILENAME_HEIGHT = .02;

MAINPANEL_X0 = LEFTCOLUMN_WIDTH + 2 * MARGIN_X;
MAINPANEL_Y0 =  MARGIN_Y;
MAINPANEL_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
MAINPANEL_HEIGHT = 1 - COHORT_HEIGHT - FILENAME_HEIGHT;
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

CLOSE_TP = ['Close ' APPNAME '. Shortcut: ' GUI.ACCELERATOR '+' CLOSE_SC];

initial_number_childs = 0;

%% Application Data
analysis_list = Analysis.getList();
assert(ismember(ga.getClass(), analysis_list), ...
    [BRAPH2.STR ':GUIAnalysis:' BRAPH2.WRONG_INPUT], ...
    'Input is not subclass of Analysis.')

cohort = ga.getCohort();
selected_calc = [];
selected_regionmeasures = [];
selected_brainmeasures = [];
bg = [];
brain_panel = [];
current_figure_axes = [];
current_figure_name = [];

    function cb_open(~, ~)
        % select file
        [file,path,filterindex] = uigetfile(GUI.GA_EXTENSION, GUI.GA_MSG_GETFILE);
        % load file
        if filterindex
            filename = fullfile(path, file);
            temp = load(filename, '-mat', 'ga', 'selected_calc', 'selected_brainmeasures', 'selected_regionmeasures', 'BUILD');
            if isfield(temp, 'BUILD') && temp.BUILD >= 2020 && ...
                    isfield(temp, 'ga') && ...
                    ismember(temp.getClass(), analysis_list)
                ga = temp;
                selected_calc = temp.select_measure;
                setup()
            end
        end
    end
    function cb_save(~, ~)
        filename = get(ui_text_filename, 'String');
        if isempty(filename)
            cb_saveas();
        else
            save(filename, 'ga', 'selected_calc', 'selected_brainmeasures', 'selected_regionmeasures','BUILD');  % prob not cohort
        end
    end
    function cb_saveas(~, ~)
        % select file
        [file, path, filterindex] = uiputfile(GUI.GA_EXTENSION, GUI.GA_MSG_PUTFILE);
        % save file
        if filterindex
            filename = fullfile(path, file);
            save(filename, 'ga', 'selected_calc','selected_calc','selected_regionmeasures', 'BUILD');
            update_filename(filename)
        end
    end


%% GUI Init
f = GUI.init_figure(APPNAME, .9, .9, 'center');
    function init_disable()
        
    end
    function init_enable()
        
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
COHORT_POSITION = [COHORT_X0 COHORT_Y0+0.01 COHORT_WIDTH COHORT_HEIGHT];

COHORT_BUTTON_SELECT_CMD = 'Select Cohort';
COHORT_BUTTON_SELECT_TP = 'Select file (*.cohort) from where to load a Cohort';

COHORT_BUTTON_VIEW_CMD = 'View Cohort ...';
COHORT_BUTTON_VIEW_TP = ['Open Cohort with ' GUI.CE_NAME '.'];

SELECTALL_CALC_CMD = GUI.SELECTALL_CMD;
SELECTALL_CALC_TP = 'Select all measures';

CLEARSELECTION_CALC_CMD = GUI.CLEARSELECTION_CMD;
CLEARSELECTION_CALC_TP = 'Clear measure selection';

SELECTGLOBAL_CALC_CMD = 'Select Global';
SELECTGLOBAL_CALC_TP = 'Select all global measures';

SELECTNODAL_CALC_CMD = 'Select Nodal';
SELECTNODAL_CALC_TP = 'Select all nodal measures';

SELECTBINODAL_CALC_CMD = 'Select Binodal';
SELECTBINODAL_CALC_TP = 'Select all Binodal measures';

CALCULATE_CALC_CMD = 'Calculate Group Measures ...';
CALCULATE_CALC_TP = 'Calculates selected measures for a group';

COMPARE_CALC_CMD = 'Compare Group Measures ...';
COMPARE_CALC_TP = 'Compares selected measures for two group';

RANDOM_CALC_CMD = 'Compare With Random Graph ...';
RANDOM_CALC_TP = 'Compares selected measures with a random graph';

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

%% Panel - Calculation panel
SET_WIDTH = LEFTCOLUMN_WIDTH;
SET_HEIGHT = 1 - COHORT_HEIGHT - MARGIN_Y;
SET_X0 = MARGIN_X;
SET_Y0 =  MARGIN_Y;
CALC_POSITION = [SET_X0 SET_Y0 SET_WIDTH SET_HEIGHT];

TAB_NODAL = 'Global';
TAB_GLOBAL = 'Nodal';
TAB_BINODAL = 'Binodal';

TAB_UNILAYER = 'Unilayer';
TAB_BILAYER = 'Bilayer';
TAB_SUPERGLOBAL = 'Super Global';

ui_calc_panel = uipanel();
ui_calc_analysis_id = uicontrol(ui_calc_panel, 'Style', 'edit');
ui_calc_analysis_label = uicontrol(ui_calc_panel, 'Style', 'edit');
ui_calc_analysis_notes = uicontrol(ui_calc_panel, 'Style', 'edit');
ui_calc_settings_panel = uipanel(ui_calc_panel);
ui_calc_new_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_comparison_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_randomcomparison_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
ui_calc_measurement_button = uicontrol(ui_calc_panel, 'Style', 'pushbutton');
init_calc()
    function init_calc()
        GUI.setUnits(ui_calc_panel)
        GUI.setBackgroundColor(ui_calc_panel)
        
        set(ui_calc_panel, 'Position', CALC_POSITION)
        set(ui_calc_panel, 'BorderType', 'none')
        
        set(ui_calc_analysis_id, 'Position', [0 .95 .36 .03])
        set(ui_calc_analysis_id, 'HorizontalAlignment', 'left')
        set(ui_calc_analysis_id, 'FontWeight', 'bold')
        set(ui_calc_analysis_id, 'Callback', {@cb_calc_ga_id})
        
        set(ui_calc_analysis_label, 'Position', [.42 .95 .56 .03])
        set(ui_calc_analysis_label, 'HorizontalAlignment', 'left')
        set(ui_calc_analysis_label, 'FontWeight', 'bold')
        set(ui_calc_analysis_label, 'Callback', {@cb_calc_ga_label})
        
        set(ui_calc_analysis_notes, 'Position', [.42 .90 .56 .03])
        set(ui_calc_analysis_notes, 'HorizontalAlignment', 'left')
        set(ui_calc_analysis_notes, 'FontWeight', 'bold')
        set(ui_calc_analysis_notes, 'Callback', {@cb_calc_ga_notes})
        
        set(ui_calc_settings_panel, 'Position', [0 0.19 0.98 .61])
        set(ui_calc_settings_panel, 'Title', 'Analysis Settings')
        set(ui_calc_settings_panel, 'Units', 'normalized')
        
        set(ui_calc_new_button, 'Position', [.02 .83 .96 .045])
        set(ui_calc_new_button, 'String', 'New Analysis ...')
        set(ui_calc_new_button, 'Callback', {@cb_calc_new})
        
        set(ui_calc_measurement_button, 'Position', [.02 .12 .96 .045])
        set(ui_calc_measurement_button, 'String', CALCULATE_CALC_CMD)
        set(ui_calc_measurement_button, 'TooltipString', CALCULATE_CALC_TP)
        set(ui_calc_measurement_button, 'Callback', {@cb_calc_calculate})
        
        set(ui_calc_comparison_button, 'Position', [.02 .06 .96 .045])
        set(ui_calc_comparison_button, 'String', COMPARE_CALC_CMD)
        set(ui_calc_comparison_button, 'TooltipString', COMPARE_CALC_TP)
        set(ui_calc_comparison_button, 'Callback', {@cb_calc_compare})
        
        set(ui_calc_randomcomparison_button, 'Position', [.02 .0 .96 .045])
        set(ui_calc_randomcomparison_button, 'String', RANDOM_CALC_CMD)
        set(ui_calc_randomcomparison_button, 'TooltipString', RANDOM_CALC_TP)
        set(ui_calc_randomcomparison_button, 'Callback', {@cb_calc_random})
        
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
            
            texts(j, 1) = uicontrol('Parent', ui_calc_settings_panel, 'Style', 'text', ...
                'Units', 'normalized', 'FontSize', 10, 'HorizontalAlignment', 'left', 'Position', [0.01 inner_panel_y-0.02 0.50 0.1], ...
                'String', erase(as{1,1}, ['Analysis' dc{1} '.']), 'enable', 'off');
            
            fields(j, 1) = uicontrol('Parent', ui_calc_settings_panel,  ...
                'Units', 'normalized', 'Position', [0.58 inner_panel_y+0.04 0.40 0.03] );
            
            if isequal(as{1, 2}, 1) % string
                set(fields(j, 1), 'Style', 'popup');
                set(fields(j, 1), 'String', ga.getSettings(as{1,1}))
                set(fields(j, 1), 'HorizontalAlignment', 'left')
                set(fields(j, 1), 'FontWeight', 'bold')
                set(fields(j, 1), 'enable', 'off')
                
            elseif isequal(as{1, 2}, 2) % numerical
                set(fields(j, 1), 'Style', 'edit');
                set(fields(j, 1), 'String', ga.getSettings(as{1,1}))  % put default
                set(fields(j, 1), 'enable', 'off')
            else % logical
                set(fields(j, 1), 'Style', 'popup');
                set(fields(j, 1), 'String', {'true', 'false'})
                set(fields(j, 1), 'enable', 'off')
            end
        end
        
    end
    function update_set_ga_id()
        if isempty(ga.getID())
            set(f, 'Name', GUI.GA_NAME)
        else
            set(f, 'Name', [GUI.GA_NAME ' - ' ga.getID()])
        end
        set(ui_calc_analysis_id, 'String', ga.getID())
    end
    function cb_calc_ga_id(~, ~)
        ga.setID(get(ui_calc_analysis_id, 'String'))
        update_set_ga_id()
    end
    function cb_calc_ga_label(~, ~)
        ga.setLabel(get(ui_calc_analysis_label, 'String'))
    end
    function cb_calc_ga_notes(~, ~)
        ga.setNotes(get(ui_calc_analysis_notes, 'String'))
    end
    function mlist = measurelist()
        mlist = Graph.getCompatibleMeasureList(ga.getGraphType());
    end
    function cb_calc_calculate(~, ~)       
        GUIMeasurement(ga.getMeasurementClass(), ga, measure_rules)
    end
    function cb_calc_compare(~, ~)
        GUIComparison(ga.getComparisonClass(), ga, measure_rules)
    end
    function cb_calc_random(~, ~)
        GUIRandomComparison(ga.getRandomComparisonClass(), ga, measure_rules)
    end
    function cb_calc_new(~, ~)
        GUIAnalysis(ga);
    end

%% Console
CONSOLE_WIDTH = 1 - LEFTCOLUMN_WIDTH - 3 * MARGIN_X;
CONSOLE_HEIGHT = COHORT_HEIGHT;
CONSOLE_X0 = LEFTCOLUMN_WIDTH+2*MARGIN_X;
CONSOLE_Y0 = 1-MARGIN_Y-CONSOLE_HEIGHT;
CONSOLE_POSITION = [CONSOLE_X0 CONSOLE_Y0 CONSOLE_WIDTH CONSOLE_HEIGHT];

CONSOLE_MATRIX_CMD = 'Adjacency';
CONSOLE_MATRIX_SC = '1';
CONSOLE_MATRIX_TP = ['Visualizes correlation matrix. Shortcut: ' GUI.ACCELERATOR '+' CONSOLE_MATRIX_SC];

CONSOLE_GLOBAL_CMD = 'Global Measures';
CONSOLE_GLOBAL_SC = '2';
CONSOLE_GLOBAL_TP = 'Visualizes Global Measurements';

CONSOLE_NODAL_CMD = 'Nodal Measures';
CONSOLE_NODAL_SC = '3';
CONSOLE_NODAL_TP = 'Visualizes Nodal Measurements';

CONSOLE_BINODAL_CMD = 'Binodal Measures';
CONSOLE_BINODAL_SC = '4';
CONSOLE_BINODAL_TP = 'Visualizes Binodal Measurements';

CONSOLE_BRAINVIEW_CMD = 'Brain View';
CONSOLE_BRAINVIEW_SC = '5';
CONSOLE_BRAINVIEW_TP = 'Visualizes BrainView';

ui_console_panel = uipanel();
ui_console_matrix_button  = uicontrol(ui_console_panel, 'Style', 'pushbutton');
ui_console_global_button = uicontrol(ui_console_panel, 'Style', 'pushbutton');
ui_console_nodal_button = uicontrol(ui_console_panel, 'Style', 'pushbutton');
ui_console_binodal_button = uicontrol(ui_console_panel, 'Style', 'pushbutton');
ui_console_brainview_button = uicontrol(ui_console_panel, 'Style', 'pushbutton');
init_console()
    function init_console()
        GUI.setUnits(ui_console_panel)
        GUI.setBackgroundColor(ui_console_panel)
        
        set(ui_console_panel, 'Position', CONSOLE_POSITION)
        set(ui_console_panel, 'BorderType', 'none')
        
        set(ui_console_matrix_button, 'Position', [.05 .30 .10 .40])
        set(ui_console_matrix_button, 'String', CONSOLE_MATRIX_CMD)
        set(ui_console_matrix_button, 'TooltipString', CONSOLE_MATRIX_TP)
        set(ui_console_matrix_button, 'Callback', {@cb_console_matrix})
        
        set(ui_console_global_button, 'Position', [.16 .30 .10 .40])
        set(ui_console_global_button, 'String', CONSOLE_GLOBAL_CMD)
        set(ui_console_global_button, 'TooltipString', CONSOLE_GLOBAL_TP)
        set(ui_console_global_button, 'Callback', {@cb_console_global})
        
        set(ui_console_nodal_button, 'Position', [.27 .30 .10 .40])
        set(ui_console_nodal_button, 'String', CONSOLE_NODAL_CMD)
        set(ui_console_nodal_button, 'TooltipString', CONSOLE_GLOBAL_TP)
        set(ui_console_nodal_button, 'Callback', {@cb_console_nodal})
        
        set(ui_console_binodal_button, 'Position', [.38 .30 .10 .40])
        set(ui_console_binodal_button, 'String', CONSOLE_BINODAL_CMD)
        set(ui_console_binodal_button, 'TooltipString', CONSOLE_GLOBAL_TP)
        set(ui_console_binodal_button, 'Callback', {@cb_console_binodal})
        
        set(ui_console_brainview_button, 'Position', [.49 .30 .1 .40])
        set(ui_console_brainview_button, 'String', CONSOLE_BRAINVIEW_CMD)
        set(ui_console_brainview_button, 'TooltipString', CONSOLE_GLOBAL_TP)
        set(ui_console_brainview_button, 'Callback', {@cb_console_brainview})
    end
    function update_console_panel_visibility(console_panel_cmd)
        switch console_panel_cmd
            case CONSOLE_GLOBAL_CMD
                childs_visibility(ui_panel_matrix, 'off')
                childs_visibility(ui_panel_global, 'on')
                childs_visibility(ui_panel_nodal, 'off')
                childs_visibility(ui_panel_binodal, 'off')
                childs_visibility(ui_panel_brainview, 'off')
                
                set(ui_console_matrix_button, 'FontWeight', 'normal')
                set(ui_console_global_button, 'FontWeight', 'bold')
                set(ui_console_nodal_button, 'FontWeight', 'normal')  
                set(ui_console_binodal_button, 'FontWeight', 'normal')
                set(ui_console_brainview_button, 'FontWeight', 'normal')

            case CONSOLE_NODAL_CMD
                childs_visibility(ui_panel_matrix, 'off')
                childs_visibility(ui_panel_global, 'off')
                childs_visibility(ui_panel_nodal, 'on')                
                childs_visibility(ui_panel_binodal, 'off')                
                childs_visibility(ui_panel_brainview, 'off')
                
                set(ui_console_matrix_button, 'FontWeight', 'normal')
                set(ui_console_global_button, 'FontWeight', 'normal')
                set(ui_console_nodal_button, 'FontWeight', 'bold')                
                set(ui_console_binodal_button, 'FontWeight', 'normal')
                set(ui_console_brainview_button, 'FontWeight', 'normal')
                
            case CONSOLE_BINODAL_CMD
                childs_visibility(ui_panel_matrix, 'off')
                childs_visibility(ui_panel_global, 'off')
                childs_visibility(ui_panel_nodal, 'off')
                childs_visibility(ui_panel_binodal, 'on')
                childs_visibility(ui_panel_brainview, 'off')
                
                set(ui_console_matrix_button, 'FontWeight', 'normal')
                set(ui_console_global_button, 'FontWeight', 'normal')
                set(ui_console_nodal_button, 'FontWeight', 'normal')  
                set(ui_console_binodal_button, 'FontWeight', 'bold')
                set(ui_console_brainview_button, 'FontWeight', 'normal')
                
            case CONSOLE_BRAINVIEW_CMD
                childs_visibility(ui_panel_matrix, 'off')
                childs_visibility(ui_panel_global, 'off')
                childs_visibility(ui_panel_nodal, 'off')
                childs_visibility(ui_panel_binodal, 'off') 
                childs_visibility(ui_panel_brainview, 'on')
                
                set(ui_console_matrix_button, 'FontWeight', 'normal')
                set(ui_console_global_button, 'FontWeight', 'normal')
                set(ui_console_nodal_button, 'FontWeight', 'normal')  
                set(ui_console_binodal_button, 'FontWeight', 'normal')                  
                set(ui_console_brainview_button, 'FontWeight', 'bold')
%                 
%                 set([ui_toolbar_zoomin ...
%                     ui_toolbar_zoomout ...
%                     ui_toolbar_pan ...
%                     ui_toolbar_datacursor ...
%                     ui_toolbar_insertcolorbar ...
%                     ui_toolbar_rotate ...
%                     ui_toolbar_3D ...
%                     ui_toolbar_SL ...
%                     ui_toolbar_SR ...
%                     ui_toolbar_AD ...
%                     ui_toolbar_AV ...
%                     ui_toolbar_CP ...
%                     ui_toolbar_CA ...
%                     ui_toolbar_brain ...
%                     ui_toolbar_br ...
%                     ui_toolbar_axis ...
%                     ui_toolbar_grid ...
%                     ui_toolbar_label ...
%                     ui_toolbar_sym], ...
%                     'Visible','on')
%                 set(ui_toolbar_brain,'Separator','on');
%                 set(ui_toolbar_3D,'Separator','on');
                
            otherwise % CONSOLE_MATRIX_CMD
                childs_visibility(ui_panel_matrix, 'on')
                childs_visibility(ui_panel_global, 'off')
                childs_visibility(ui_panel_nodal, 'off')
                childs_visibility(ui_panel_binodal, 'off')                
                childs_visibility(ui_panel_brainview, 'off')
                
                set(ui_console_matrix_button, 'FontWeight', 'bold')
                set(ui_console_global_button, 'FontWeight', 'normal')
                set(ui_console_nodal_button, 'FontWeight', 'normal')
                set(ui_console_binodal_button, 'FontWeight', 'normal')
                set(ui_console_brainview_button, 'FontWeight', 'normal')
        end
    end
    function update_console_panel()
        if strcmpi(get(ui_panel_matrix, 'Visible'), 'on')
            update_matrix()            
        elseif strcmpi(get(ui_panel_global, 'Visible'), 'on')
            update_global_panel()
        elseif strcmpi(get(ui_panel_nodal, 'Visible'), 'on')
            update_nodal_panel()
        elseif strcmpi(get(ui_panel_binodal, 'Visible'), 'on')
            update_binodal_panel()
        elseif strcmpi(get(ui_panel_brainview, 'Visible'), 'on')
            update_brainview_panel()
        end        
    end
    function cb_console_matrix(~, ~)         
        update_console_panel_visibility(CONSOLE_MATRIX_CMD)
        update_console_panel()
    end
    function cb_console_global(~, ~)        
        update_console_panel_visibility(CONSOLE_GLOBAL_CMD)
        update_console_panel()
    end
    function cb_console_nodal(~, ~)
        update_console_panel_visibility(CONSOLE_NODAL_CMD)
        update_nodal_panel()
    end
    function cb_console_binodal(~, ~)
        update_console_panel_visibility(CONSOLE_BINODAL_CMD)
        update_console_panel()
    end
    function cb_console_brainview(~, ~)
        update_console_panel_visibility(CONSOLE_BRAINVIEW_CMD)
        update_console_panel()
    end
    function childs_visibility(handle, rule)
        childs = allchild(handle);
        set(handle, 'visible', rule)
        for i = 1:1:length(childs)
            set(childs(i), 'visible', rule)
        end        
    end

%% Panel Plot Matrix
CONSOLE_MATRIX_CMD  = 'Correlation Matrix';

ui_panel_matrix = uipanel();
ui_matrix_axes = axes();
init_matrix()
    function init_matrix()
        GUI.setUnits(ui_panel_matrix)
        GUI.setBackgroundColor(ui_panel_matrix)
        
        set(ui_panel_matrix, 'Position', MAINPANEL_POSITION)
        set(ui_panel_matrix, 'Title', CONSOLE_MATRIX_CMD)
        
        set(ui_matrix_axes, 'Parent', ui_panel_matrix)
        set(ui_matrix_axes, 'Position', [.05 .05 .60 .88])
    end
    function update_matrix()
        current_figure_axes = ui_matrix_axes;
        current_figure_name = 'Correlation Matrix';
        ga.getGraphPanel('UIParent', ui_panel_matrix, 'UIParentAxes', ui_matrix_axes)
    end

%% Panel Global
PANEL_GLOBAL_TITLE  = 'Global Measures';

ui_panel_global = uipanel();
ui_panel_global_axes = axes();
init_global()
    function init_global()
        GUI.setUnits(ui_panel_global)
        GUI.setBackgroundColor(ui_panel_global)
       
        set(ui_panel_global, 'Position', MAINPANEL_POSITION)
        set(ui_panel_global, 'Title', PANEL_GLOBAL_TITLE)
        
        set(ui_panel_global_axes, 'Position', [0 0 0 0])
    end
    function update_global_panel()
        current_figure_axes = ui_panel_global_axes;
        current_figure_name = 'Global Measure Plot';
        ga.getGlobalPanel('UIParent', ui_panel_global, 'UIAxesGlobal', ui_panel_global_axes)
    end

%% Panel Nodal
PANEL_NODAL_TITLE = 'NODAL MEASURES';

ui_panel_nodal = uipanel();
ui_panel_nodal_axes = axes();
init_nodal()
    function init_nodal()
        GUI.setUnits(ui_panel_nodal)
        GUI.setBackgroundColor(ui_panel_nodal)
        
        set(ui_panel_nodal, 'Position', MAINPANEL_POSITION)
        set(ui_panel_nodal, 'Title', PANEL_NODAL_TITLE)
        
        set(ui_panel_nodal_axes, 'Position', [0 0 0 0])
    end
    function update_nodal_panel()
        current_figure_axes = ui_panel_nodal_axes;
        current_figure_name = 'Nodal Measure Plot';
        ga.getNodalPanel('UIParent', ui_panel_nodal, 'UIAxesNodal', ui_panel_nodal_axes);
    end


%% Panel Binodal
PANEL_BINODAL_TITLE = 'BINODAL MEASURES';

ui_panel_binodal = uipanel();
ui_panel_binodal_axes = axes();
init_binodal()
    function init_binodal()
        GUI.setUnits(ui_panel_binodal)
        GUI.setBackgroundColor(ui_panel_binodal)
        
        set(ui_panel_binodal, 'Position', MAINPANEL_POSITION)
        set(ui_panel_binodal, 'Title', PANEL_BINODAL_TITLE)
        
        set(ui_panel_binodal_axes, 'Position', [0 0 0 0])
    end
    function update_binodal_panel()
        current_figure_axes = ui_panel_binodal_axes;
        current_figure_name = 'Nodal Measure Plot';
        ga.getBinodalPanel('UIParent', ui_panel_binodal, 'UIAxesBinodal', ui_panel_binodal_axes);
    end

%% Panel BrainView
PANEL_BRAINVIEW_TITLE = 'Brain View';
ui_panel_brainview = uipanel();
ui_panel_brainview_axes = axes();
init_brainview()
    function init_brainview()
        GUI.setUnits(ui_panel_brainview)
        GUI.setBackgroundColor(ui_panel_brainview)
        
        set(ui_panel_brainview, 'Position', MAINPANEL_POSITION)
        set(ui_panel_brainview, 'Title', PANEL_BRAINVIEW_TITLE)
        
        set(ui_panel_brainview_axes, 'Position', [0 0 0 0])
    end
    function update_brainview_panel()
        current_figure_axes = ui_panel_brainview_axes;
        current_figure_name = 'Brain View';
        brain_panel = ga.getBrainView('UIParent', ui_panel_brainview, 'UIAxesBrain', ui_panel_brainview_axes, 'BrainGraph', bg);
    end

%% Menus
MENU_FILE = GUI.MENU_FILE;
MENU_FIGURE = 'Figure';

ui_menu_file = uimenu(f, 'Label', MENU_FILE);
ui_menu_file_open = uimenu(ui_menu_file);
ui_menu_file_save = uimenu(ui_menu_file);
ui_menu_file_saveas = uimenu(ui_menu_file);
ui_menu_file_close = uimenu(ui_menu_file);
ui_menu_plotview = uimenu(f,  'Label',  'Plot View');
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
        set(ui_menu_file_close, 'Callback', ['GUI.close(''' APPNAME ''',  gcf)'])
        
        set(ui_menu_plotview_figure, 'Label', FIGURE_CMD)
        set(ui_menu_plotview_figure, 'Accelerator', FIGURE_SC)
        set(ui_menu_plotview_figure, 'Callback', {@cb_menu_figure})
        
    end
[ui_menu_about,  ui_menu_about_about] = GUI.setMenuAbout(f, APPNAME);
    function cb_menu_figure(~,  ~)  % (src,  event)
        h = figure('Name', [current_figure_name ' - ' ga.getName()]);
        set(gcf, 'Color', 'w')
        copyobj(current_figure_axes, h)
        set(gca, 'Units', 'normalized')
        set(gca, 'OuterPosition', [0 0 1 1])
        if get(ui_panel_matrix, 'Visible')
            colormap jet
            end
    end

%% Toolbar
FIG_BRAIN_CMD = 'Show brain';
FIG_AXIS_CMD = 'Show axis';
FIG_GRID_CMD = 'Show grid';
FIG_LABELS_CMD = 'Show labels';
FIG_BR_CMD = 'Show brain regions';

FIG_VIEW_3D_CMD = PlotBrainAtlas.VIEW_3D_CMD;
FIG_VIEW_SR_CMD = PlotBrainAtlas.VIEW_SR_CMD;
FIG_VIEW_SL_CMD = PlotBrainAtlas.VIEW_SL_CMD;
FIG_VIEW_AD_CMD = PlotBrainAtlas.VIEW_AD_CMD;
FIG_VIEW_AV_CMD = PlotBrainAtlas.VIEW_AV_CMD;
FIG_VIEW_CA_CMD = PlotBrainAtlas.VIEW_CA_CMD;
FIG_VIEW_CP_CMD = PlotBrainAtlas.VIEW_CP_CMD;

set(f,  'Toolbar', 'figure')
ui_toolbar = findall(f, 'Tag', 'FigureToolBar');
ui_toolbar_open = findall(ui_toolbar, 'Tag', 'Standard.FileOpen');
ui_toolbar_save = findall(ui_toolbar, 'Tag', 'Standard.SaveFigure');
ui_toolbar_3D = uipushtool(ui_toolbar);
ui_toolbar_SL = uipushtool(ui_toolbar);
ui_toolbar_SR = uipushtool(ui_toolbar);
ui_toolbar_AD = uipushtool(ui_toolbar);
ui_toolbar_AV = uipushtool(ui_toolbar);
ui_toolbar_CA = uipushtool(ui_toolbar);
ui_toolbar_CP = uipushtool(ui_toolbar);
ui_toolbar_brain = uitoggletool(ui_toolbar);
ui_toolbar_axis = uitoggletool(ui_toolbar);
ui_toolbar_grid = uitoggletool(ui_toolbar);
ui_toolbar_br = uitoggletool(ui_toolbar);
ui_toolbar_label = uitoggletool(ui_toolbar);
init_toolbar()
    function init_toolbar()
        delete(findall(ui_toolbar, 'Tag', 'Standard.NewFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.PrintFigure'))
        delete(findall(ui_toolbar, 'Tag', 'Standard.EditPlot'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Rotate'))
        delete(findall(ui_toolbar, 'Tag', 'Exploration.Brushing'))
        delete(findall(ui_toolbar, 'Tag', 'DataManager.Linking'))
        delete(findall(ui_toolbar, 'Tag', 'Annotation.InsertLegend'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOff'))
        delete(findall(ui_toolbar, 'Tag', 'Plottools.PlottoolsOn'))
        
        set(ui_toolbar_open, 'TooltipString', OPEN_TP);
        set(ui_toolbar_open, 'ClickedCallback', {@cb_open})
        set(ui_toolbar_save, 'TooltipString', SAVE_TP);
        set(ui_toolbar_save, 'ClickedCallback', {@cb_save})
        
        set(ui_toolbar_3D, 'Separator', 'on');
        
        set(ui_toolbar_3D, 'TooltipString', FIG_VIEW_3D_CMD);
        set(ui_toolbar_3D, 'CData', imread('icon_view_3d.png'));
        set(ui_toolbar_3D, 'ClickedCallback', {@cb_toolbar_3D})
        function cb_toolbar_3D(~, ~)  % (src, event)
            bg.view(PlotBrainAtlas.VIEW_3D)
        end
        
        set(ui_toolbar_SL, 'TooltipString', FIG_VIEW_SL_CMD);
        set(ui_toolbar_SL, 'CData', imread('icon_view_sl.png'));
        set(ui_toolbar_SL, 'ClickedCallback', {@cb_toolbar_SL})
        function cb_toolbar_SL(~, ~)  % (src, event)
            bg.view(PlotBrainAtlas.VIEW_SL)
        end
        
        set(ui_toolbar_SR, 'TooltipString', FIG_VIEW_SR_CMD);
        set(ui_toolbar_SR, 'CData', imread('icon_view_sr.png'));
        set(ui_toolbar_SR, 'ClickedCallback', {@cb_toolbar_SR})
        function cb_toolbar_SR(~, ~)  % (src, event)
            bg.view(PlotBrainAtlas.VIEW_SR)
        end
        
        set(ui_toolbar_AD, 'TooltipString', FIG_VIEW_AD_CMD);
        set(ui_toolbar_AD, 'CData', imread('icon_view_ad.png'));
        set(ui_toolbar_AD, 'ClickedCallback', {@cb_toolbar_AD})
        function cb_toolbar_AD(~, ~)  % (src, event)
            bg.view(PlotBrainAtlas.VIEW_AD)
        end
        
        set(ui_toolbar_AV, 'TooltipString', FIG_VIEW_AV_CMD);
        set(ui_toolbar_AV, 'CData', imread('icon_view_av.png'));
        set(ui_toolbar_AV, 'ClickedCallback', {@cb_toolbar_AV})
        function cb_toolbar_AV(~, ~)  % (src, event)
            bg.view(PlotBrainAtlas.VIEW_AV)
        end
        
        set(ui_toolbar_CA, 'TooltipString', FIG_VIEW_CA_CMD);
        set(ui_toolbar_CA, 'CData', imread('icon_view_ca.png'));
        set(ui_toolbar_CA, 'ClickedCallback', {@cb_toolbar_CA})
        function cb_toolbar_CA(~, ~)  % (src, event)
            bg.view(PlotBrainAtlas.VIEW_CA)
        end
        
        set(ui_toolbar_CP, 'TooltipString', FIG_VIEW_CP_CMD);
        set(ui_toolbar_CP, 'CData', imread('icon_view_cp.png'));
        set(ui_toolbar_CP, 'ClickedCallback', {@cb_toolbar_CP})
        function cb_toolbar_CP(~, ~)  % (src, event)
            bg.view(PlotBrainAtlas.VIEW_CP)
        end
        
        set(ui_toolbar_brain, 'Separator', 'on');
        
        set(ui_toolbar_brain, 'TooltipString', FIG_BRAIN_CMD);
        set(ui_toolbar_brain, 'State', 'on');
        set(ui_toolbar_brain, 'CData', imread('icon_brain.png'));
        set(ui_toolbar_brain, 'OnCallback', {@cb_toolbar_brain_on})
        set(ui_toolbar_brain, 'OffCallback', {@cb_toolbar_brain_off})
        function cb_toolbar_brain_on(~, ~)  % (src, event)
            checkboxs_brain  = findobj(brain_panel, 'Style', 'checkbox'); %findobj(ui_control, 'Style', 'checkbox');
            for i = 1:1:length(checkboxs_brain)
                current_children = checkboxs_brain(i);
                if isequal(current_children.String, 'Show Brain Surface')
                    set(current_children, 'Value', true)
                end
            end
            bg.brain_on();
        end
        function cb_toolbar_brain_off(~, ~)  % (src, event)
            checkboxs_brain  = findobj(brain_panel, 'Style', 'checkbox'); %findobj(ui_control, 'Style', 'checkbox');
            for i = 1:1:length(checkboxs_brain)
                current_children = checkboxs_brain(i);
                if isequal(current_children.String, 'Show Brain Surface')
                    set(current_children, 'Value', false)
                end
            end
            bg.brain_off();
        end
        
        set(ui_toolbar_axis, 'TooltipString', FIG_AXIS_CMD);
        set(ui_toolbar_axis, 'State', 'on');
        set(ui_toolbar_axis, 'CData', imread('icon_axis.png'));
        set(ui_toolbar_axis, 'OnCallback', {@cb_toolbar_axis_on})
        set(ui_toolbar_axis, 'OffCallback', {@cb_toolbar_axis_off})
        function cb_toolbar_axis_on(~, ~)  % (src, event)
            bg.axis_on()
        end
        function cb_toolbar_axis_off(~, ~)  % (src, event)
            bg.axis_off()
        end
        
        set(ui_toolbar_grid, 'TooltipString', FIG_GRID_CMD);
        set(ui_toolbar_grid, 'State', 'on');
        set(ui_toolbar_grid, 'CData', imread('icon_grid.png'));
        set(ui_toolbar_grid, 'OnCallback', {@cb_toolbar_grid_on})
        set(ui_toolbar_grid, 'OffCallback', {@cb_toolbar_grid_off})
        function cb_toolbar_grid_on(~, ~)  % (src, event)
            bg.grid_on()
        end
        function cb_toolbar_grid_off(~, ~)  % (src, event)
            bg.grid_off()
        end
        
        set(ui_toolbar_br, 'TooltipString', FIG_BR_CMD);
        set(ui_toolbar_br, 'State', 'on');
        set(ui_toolbar_br, 'CData', imread('icon_br.png'));
        set(ui_toolbar_br, 'OnCallback', {@cb_toolbar_br_on})
        set(ui_toolbar_br, 'OffCallback', {@cb_toolbar_br_off})
        function cb_toolbar_br_on(~, ~)  % (src, event)
            checkboxs_brain  = findobj(brain_panel, 'Style', 'checkbox'); %findobj(ui_control, 'Style', 'checkbox');
            for i = 1:1:length(checkboxs_brain)
                current_children = checkboxs_brain(i);
                if isequal(current_children.String, 'Show Brain Regions')
                    set(current_children, 'Value', true)
                end
            end
            bg.br_syms_on();
        end
        function cb_toolbar_br_off(~, ~)  % (src, event)
            checkboxs_brain  = findobj(brain_panel, 'Style', 'checkbox'); %findobj(ui_control, 'Style', 'checkbox');
            for i = 1:1:length(checkboxs_brain)
                current_children = checkboxs_brain(i);
                if isequal(current_children.String, 'Show Brain Regions')
                    set(current_children, 'Value', false)
                end
            end
            bg.br_syms_off();
        end
        
        set(ui_toolbar_label, 'TooltipString', FIG_LABELS_CMD);
        set(ui_toolbar_label, 'State', 'on');
        set(ui_toolbar_label, 'CData', imread('icon_label.png'));
        set(ui_toolbar_label, 'OnCallback', {@cb_toolbar_label_on})
        set(ui_toolbar_label, 'OffCallback', {@cb_toolbar_label_off})
        function cb_toolbar_label_on(~, ~)  % (src, event)
            checkboxs_brain  = findobj(brain_panel, 'Style', 'checkbox'); %findobj(ui_control, 'Style', 'checkbox');
            for i = 1:1:length(checkboxs_brain)
                current_children = checkboxs_brain(i);
                if isequal(current_children.String, 'Show Brain Labels')
                    set(current_children, 'Value', true)
                end
            end
            bg.br_labs_on();
        end
        function cb_toolbar_label_off(~, ~)  % (src, event)
            checkboxs_brain  = findobj(brain_panel, 'Style', 'checkbox'); %findobj(ui_control, 'Style', 'checkbox');
            for i = 1:1:length(checkboxs_brain)
                current_children = checkboxs_brain(i);
                if isequal(current_children.String, 'Show Brain Labels')
                    set(current_children, 'Value', false)
                end
            end
            bg.br_labs_off();
        end
    end

%% Make the GUI visible.
setup()
set(f, 'Visible', 'on');

%% Auxiliary functions
    function setup()
        % setup cohort
        update_cohort()
        
        % setup graph analysis
        update_matrix()
        
        % setup console
        update_console_panel_visibility(CONSOLE_MATRIX_CMD)
        
        % setup data
        update_set_ga_id()
        
        % setup brainview
        atlases = ga.getCohort().getBrainAtlases();
        atlas = atlases{1};
        bg = PlotBrainGraph(atlas);
    end
end