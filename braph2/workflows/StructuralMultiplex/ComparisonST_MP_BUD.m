classdef ComparisonST_MP_BUD < ComparisonST_MP_WU
    % ComparisonST_MP_BUD A comparison of structural multiplex data with BU graphs at fixed density
    % ComparisonST_MP_BUD is a subclass of Comparison.
    %
    % ComparisonST_MP_BUD stores a comparison between two groups.
    % The data from the groups it compares have a fixed density for each layer.
    % Structural multiplex data can be for example MRI or/and PET data.
    %
    % ComparisonST_MP_BUD constructor methods:
    %  ComparisonST_MP_BUD          - Constructor
    %
    % ComparisonST_MP_BUD get methods:
    %  getDensity1                  - returns the density of the first layer
    %  getDensity2                  - returns the density of the second layer
    %
    % ComparisonST_MP_BUD descriptive methods (Static):
    %  getClass                     - returns the class of the comparison
    %  getName                      - returns the name of the comparison
    %  getDescription               - returns the description of the comparison
    %  getAnalysisClass             - returns the class of the analysis
    %
    % ComparisonST_MP_BUD plot methods (Static):
    %  getComparisonSettingsPanel   - returns a UIPanel
    % 
    % See also Comparison, AnalysisST_MP_BUD, MeasurementST_MP_BUD, RandomComparisonST_MP_BUD.
    
    properties (Access = protected)
        density1  % density of the values of the first layer
        density2  % density of the values of the second layer   
    end
    methods  % Constructor
        function c =  ComparisonST_MP_BUD(id, label, notes, atlas, measure_code, group_1, group_2, varargin)
            % COMPARISONST_MP_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2, 'density1', DENSITY1, 'density2', DENSITY2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed DENSITY1 for the first layer and a fixed DENSITY2 for 
            % the second layer.
            %
            % COMPARISONST_MP_BUD(ID, LABEL, NOTES, ATLAS, MEASURE_CODE, GROUP_1, GROUP_2)
            % creates a comparison with ID, LABEL, ATLAS and MEASURE_CODE
            % between the data from GROUP_1 and GROUP_2. The data will have
            % a fixed default DENSITY1 for the first layer and a fixed default 
            % DENSITY2 for the second layer.
            %
            % See also MeasurementST_MP_BUD, RandomComparisonST_MP_BUD, AnalysisST_MP_BUD.
            
            c = c@ComparisonST_MP_WU(id, label, notes, atlas, measure_code, group_1, group_2, varargin{:});
            density1 = get_from_varargin(0, 'density1', varargin{:});
            density2 = get_from_varargin(0, 'density2', varargin{:});
            c.setDensity1(density1)
            c.setDensity2(density2)
        end
    end
    methods (Access = protected) % Set functions
        function setDensity1(c, density1)
            % SETDENSITY1 sets the fixed density of the values of the first layer
            %
            % SETDENSITY1(C, DENSITY) sets the fixed density of the values
            % of the first layer.
            %
            % See also getDensity1, setDensity2.
            
            c.density1 = density1;
        end
        function setDensity2(c, density2)
            % SETDENSITY2 sets the fixed density of the values of the second layer
            %
            % SETDENSITY2(C, DENSITY) sets the fixed density of the values
            % of the second layer.
            %
            % See also getDensity2, setDensity1.
            
            c.density2 = density2;
        end
    end
    methods  % Get functions
        function density1 = getDensity1(c)
            % GETDENSITY1 returns the fixed density of the data values of the first layer
            %
            % DENSITY1 = GETDENSITY1(C) returns the fixed density of the
            % data values of the first layer.
            %
            % See also getMeasureValue, setDensity1, getDensity2.
            
            density1 = c.density1;
        end
        function density2 = getDensity2(c)
            % GETDENSITY2 returns the fixed density of the data values of the second layer
            %
            % DENSITY2 = GETDENSITY2(C) returns the fixed density of the
            % data values of the second layer.
            %
            % See also getMeasureValue, setDensity2, getDensity1.
            
            density2 = c.density2;
        end
    end
    methods (Static)  % Descriptive functions
        function class = getClass()
            % GETCLASS returns the class of structural multiplex comparison
            %
            % ANALYSIS_CLASS = GETCLASS(ANALYSIS) returns the class of
            % comparison. In this case 'ComparisonST_MP_BUD'.
            %
            % See also getList, getName, getDescription.
            
            class = 'ComparisonST_MP_BUD';
        end
        function name = getName()
            % GETNAME returns the name of structural multiplex comparison
            %
            % NAME = GETNAME() returns the name of the ComparisonST_MP_BUD.
            %
            % See also getList, getClass, getDescription.
            
            name = 'Comparison Structural Multiplex BUD';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the description of structural multiplex comparison
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description
            % of ComparisonST_MP_BUD.
            %
            % See also getList, getClass, getName.
            
            description = [ ...
                'ST MP comparison with structural multiplex data using binary ' ...
                'graphs calculated at a fixed density. ' ...
                'For example, it can use MRI or/and PET data.' ...
                ];
        end
        function analysis_class = getAnalysisClass()
            % GETANALYSISCLASS returns the class of the analsysis
            %
            % ANALYSIS_CLASS = GETANALYSISCLASS() returns the class of the
            % analysis the comparison is part of, 'AnalysisST_MP_BUD'.
            %
            % See also getList, getClass, getName.
            
            analysis_class = 'AnalysisST_MP_BUD';
        end
    end
    methods (Static)  % Plot MeasurementGUI Child Panel
        function handle = getComparisonSettingsPanel(analysis, uiparent) %#ok<INUSL>
            % GETCHILDPANEL returns a dynamic UIPanel
            %
            % HANDLE = GETCHILDPANEL(ANALYSIS, UIPARENT) returns a dynamic
            % UIPanel. Modificable settings are: Verbose, Interruptible,
            % Permutation and Density.
            %
            % See also ComparisonST_BUD.

            handle.variables = {'density1', 'density2'};
            handle.step = [];
            handle.min = [];
            handle.max = [];
            handle.permutation = [];
        end
    end
end