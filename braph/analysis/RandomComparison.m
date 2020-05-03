classdef RandomComparison < handle & matlab.mixin.Copyable
    properties (GetAccess=protected, SetAccess=protected)
        id  % unique identifier
        groups  % group
        atlases  % cell array with brain atlases
        settings  % settings of the RandomComparison
    end
    methods (Access = protected)
        function rc = RandomComparison(id, atlases, groups, varargin)
            rc.id = tostring(id);
            
            if ~iscell(atlases)
                atlases = {atlases};
            end
            assert(iscell(atlases) && all(cellfun(@(x) isa(x, 'BrainAtlas'), atlases)), ...
                ['BRAPH:RandomComparison:AtlasErr'], ...
                ['The input must be a cell containing BrainAtlas objects']) %#ok<NBRAK>
            rc.atlases = atlases;
            
            assert(iscell(groups) && length(groups)==2 && all(cellfun(@(x) isa(x, 'Group'), groups)), ...
                ['BRAPH:RandomComparison:GroupErr'], ...
                ['The input must be a Group object']) %#ok<NBRAK>
            rc.groups = groups;
            
            rc.settings = get_from_varargin(varargin, 'RandomComparisonSettings', varargin{:});
            
            rc.initialize_data(atlases, groups, varargin{:});
            
        end
        function randomcomparison_copy = copyElement(rc)
            % It does not make a deep copy of atlases or groups
            
            % Make a shallow copy
            randomcomparison_copy = copyElement@matlab.mixin.Copyable(rc);
            
            % Make a deep copy of datadict
            
        end
    end
    methods (Abstract, Access = protected)
        initialize_data(rc, varargin)  % initialize datadict
    end
    methods
        function id = getID(m)
            id = m.id;
        end
        function str = tostring(rc)
            str = [RandomComparison.getClass(rc)]; %#ok<NBRAK>
        end
        function disp(rc)
            disp(['<a href="matlab:help ' RandomComparison.getClass(rc) '">' RandomComparison.getClass(rc) '</a>'])
            disp(['id = ' rc.getID()])
        end
        function setBrainAtlases(rc, atlases)
            % adds a atlas to the end of the cell array
            rc.atlases = atlases;
        end
        function setGroups(rc, groups)
            rc.groups = groups;
        end
        function atlases = getBrainAtlases(rc)
            atlases = rc.atlases;
        end
        function groups = getGroups(rc)
            groups = rc.groups;
        end
    end
    methods (Static)
        function randomcomparisonlist = getList()
            randomcomparisonlist = subclasses('RandomComparison');
        end
        function randomcomparisonclass = getClass(rc)
            if isa(rc, 'RandomComparison')
                randomcomparisonclass = class(rc);
            else % mshould be a string with the RandomComparison class
                randomcomparisonclass = rc;
            end
        end
         function name = getName(rc)
            name = eval([RandomComparison.getClass(rc) '.getName()']);
        end
        function description = getDescription(rc)
            % RandomComparison description
            description = eval([RandomComparison.getClass(rc) '.getDescription()']);
        end
        function atlas_number = getBrainAtlasNumber(rc)
            atlas_number =  eval([RandomComparison.getClass(rc) '.getBrainAtlasNumber()']);
        end  
        function analysis_class = getAnalysisClass(c)
            % comparison analysis class
            analysis_class = eval([RandomComparison.getClass(c) '.getAnalysisClass()']);
        end
        function subject_class = getSubjectClass(c)
            % comparison subject class
            subject_class = eval([RandomComparison.getClass(c) '.getSubjectClass()']);
        end
        function sub = getRandomComparison(randomComparisonClass, id, atlas, groups, varargin) %#ok<INUSD>
            sub = eval([randomComparisonClass '(id, atlas, groups, varargin{:})']);
        end
    end
end