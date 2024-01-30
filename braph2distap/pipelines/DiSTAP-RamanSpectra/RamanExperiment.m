classdef RamanExperiment < ConcreteElement
	%RamanExperiment is a  Raman spectroscopy experiment.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% RamanExperiment is a  Raman spectroscopy experiment.
	%
	% The list of RamanExperiment properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Raman spectroscopy experiment.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Raman spectroscopy experiment.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Raman spectroscopy experiment.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Raman spectroscopy experiment.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Raman spectroscopy experiment.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Raman spectroscopy experiment.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Raman spectroscopy experiment.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>SP_DICT</strong> 	SP_DICT (data, idict) contains the aquired Raman spectra.
	%  <strong>10</strong> <strong>RESEARCHER</strong> 	RESEARCHER (data, option) is the researcher name.
	%  <strong>11</strong> <strong>DATE</strong> 	DATE (data, rvector) is the experiment date.
	%  <strong>12</strong> <strong>PLANT_NAME</strong> 	PLANT_NAME (data, option) is the plant name.
	%  <strong>13</strong> <strong>PLANT_TYPE</strong> 	PLANT_TYPE (data, option) is the plant type
	%  <strong>14</strong> <strong>PLANT_TYPE_COMMENT</strong> 	PLANT_TYPE_COMMENT (data, string) is the mutant type (when mutant is selected).
	%  <strong>15</strong> <strong>PLANT_AGE</strong> 	PLANT_AGE (data, scalar) is the plant age (in weeks).
	%  <strong>16</strong> <strong>LEAF_NUMBER</strong> 	LEAF_NUMBER (data, scalar) is the leaf number.
	%  <strong>17</strong> <strong>GROWTH_MEDIUM</strong> 	GROWTH_MEDIUM (data, option) is the growth medium.
	%  <strong>18</strong> <strong>STRESS_TYPE</strong> 	STRESS_TYPE (data, option) is the lant stress type.
	%  <strong>19</strong> <strong>SETUP</strong> 	SETUP (data, option) is the kind of setup employed.
	%  <strong>20</strong> <strong>LASER_WAVELENGTH</strong> 	LASER_WAVELENGTH (data, option) is the laser wavelength.
	%  <strong>21</strong> <strong>LASER_POWER</strong> 	LASER_POWER (data, scalar) is the laser power.
	%  <strong>22</strong> <strong>ACQUISITION_TIME</strong> 	ACQUISITION_TIME (data, scalar) is the Raman spectral acquisition time.
	%
	% RamanExperiment methods (constructor):
	%  RamanExperiment - constructor
	%
	% RamanExperiment methods:
	%  set - sets values of a property
	%  check - checks the values of all properties
	%  getr - returns the raw value of a property
	%  get - returns the value of a property
	%  memorize - returns the value of a property and memorizes it
	%             (for RESULT, QUERY, and EVANESCENT properties)
	%  getPropSeed - returns the seed of a property
	%  isLocked - returns whether a property is locked
	%  lock - locks unreversibly a property
	%  isChecked - returns whether a property is checked
	%  checked - sets a property to checked
	%  unchecked - sets a property to NOT checked
	%
	% RamanExperiment methods (display):
	%  tostring - string with information about the Raman spectroscopy experiment
	%  disp - displays information about the Raman spectroscopy experiment
	%  tree - displays the tree of the Raman spectroscopy experiment
	%
	% RamanExperiment methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Raman spectroscopy experiment are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Raman spectroscopy experiment
	%
	% RamanExperiment methods (save/load, Static):
	%  save - saves BRAPH2 Raman spectroscopy experiment as b2 file
	%  load - loads a BRAPH2 Raman spectroscopy experiment from a b2 file
	%
	% RamanExperiment method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Raman spectroscopy experiment
	%
	% RamanExperiment method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Raman spectroscopy experiment
	%
	% RamanExperiment methods (inspection, Static):
	%  getClass - returns the class of the Raman spectroscopy experiment
	%  getSubclasses - returns all subclasses of RamanExperiment
	%  getProps - returns the property list of the Raman spectroscopy experiment
	%  getPropNumber - returns the property number of the Raman spectroscopy experiment
	%  existsProp - checks whether property exists/error
	%  existsTag - checks whether tag exists/error
	%  getPropProp - returns the property number of a property
	%  getPropTag - returns the tag of a property
	%  getPropCategory - returns the category of a property
	%  getPropFormat - returns the format of a property
	%  getPropDescription - returns the description of a property
	%  getPropSettings - returns the settings of a property
	%  getPropDefault - returns the default value of a property
	%  getPropDefaultConditioned - returns the conditioned default value of a property
	%  checkProp - checks whether a value has the correct format/error
	%
	% RamanExperiment methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% RamanExperiment methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% RamanExperiment methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% RamanExperiment methods (format, Static):
	%  getFormats - returns the list of formats
	%  getFormatNumber - returns the number of formats
	%  existsFormat - returns whether a format exists/error
	%  getFormatTag - returns the tag of a format
	%  getFormatName - returns the name of a format
	%  getFormatDescription - returns the description of a format
	%  getFormatSettings - returns the settings for a format
	%  getFormatDefault - returns the default value for a format
	%  checkFormat - returns whether a value format is correct/error
	%
	% To print full list of constants, click here <a href="matlab:metaclass = ?RamanExperiment; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">RamanExperiment constants</a>.
	%
	
	properties (Constant) % properties
		SP_DICT = 9; %CET: Computational Efficiency Trick
		SP_DICT_TAG = 'SP_DICT';
		SP_DICT_CATEGORY = 4;
		SP_DICT_FORMAT = 10;
		
		RESEARCHER = 10; %CET: Computational Efficiency Trick
		RESEARCHER_TAG = 'RESEARCHER';
		RESEARCHER_CATEGORY = 4;
		RESEARCHER_FORMAT = 5;
		
		DATE = 11; %CET: Computational Efficiency Trick
		DATE_TAG = 'DATE';
		DATE_CATEGORY = 4;
		DATE_FORMAT = 12;
		
		PLANT_NAME = 12; %CET: Computational Efficiency Trick
		PLANT_NAME_TAG = 'PLANT_NAME';
		PLANT_NAME_CATEGORY = 4;
		PLANT_NAME_FORMAT = 5;
		
		PLANT_TYPE = 13; %CET: Computational Efficiency Trick
		PLANT_TYPE_TAG = 'PLANT_TYPE';
		PLANT_TYPE_CATEGORY = 4;
		PLANT_TYPE_FORMAT = 5;
		
		PLANT_TYPE_COMMENT = 14; %CET: Computational Efficiency Trick
		PLANT_TYPE_COMMENT_TAG = 'PLANT_TYPE_COMMENT';
		PLANT_TYPE_COMMENT_CATEGORY = 4;
		PLANT_TYPE_COMMENT_FORMAT = 2;
		
		PLANT_AGE = 15; %CET: Computational Efficiency Trick
		PLANT_AGE_TAG = 'PLANT_AGE';
		PLANT_AGE_CATEGORY = 4;
		PLANT_AGE_FORMAT = 11;
		
		LEAF_NUMBER = 16; %CET: Computational Efficiency Trick
		LEAF_NUMBER_TAG = 'LEAF_NUMBER';
		LEAF_NUMBER_CATEGORY = 4;
		LEAF_NUMBER_FORMAT = 11;
		
		GROWTH_MEDIUM = 17; %CET: Computational Efficiency Trick
		GROWTH_MEDIUM_TAG = 'GROWTH_MEDIUM';
		GROWTH_MEDIUM_CATEGORY = 4;
		GROWTH_MEDIUM_FORMAT = 5;
		
		STRESS_TYPE = 18; %CET: Computational Efficiency Trick
		STRESS_TYPE_TAG = 'STRESS_TYPE';
		STRESS_TYPE_CATEGORY = 4;
		STRESS_TYPE_FORMAT = 5;
		
		SETUP = 19; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 4;
		SETUP_FORMAT = 5;
		
		LASER_WAVELENGTH = 20; %CET: Computational Efficiency Trick
		LASER_WAVELENGTH_TAG = 'LASER_WAVELENGTH';
		LASER_WAVELENGTH_CATEGORY = 4;
		LASER_WAVELENGTH_FORMAT = 5;
		
		LASER_POWER = 21; %CET: Computational Efficiency Trick
		LASER_POWER_TAG = 'LASER_POWER';
		LASER_POWER_CATEGORY = 4;
		LASER_POWER_FORMAT = 11;
		
		ACQUISITION_TIME = 22; %CET: Computational Efficiency Trick
		ACQUISITION_TIME_TAG = 'ACQUISITION_TIME';
		ACQUISITION_TIME_CATEGORY = 4;
		ACQUISITION_TIME_FORMAT = 11;
	end
	methods % constructor
		function re = RamanExperiment(varargin)
			%RamanExperiment() creates a Raman spectroscopy experiment.
			%
			% RamanExperiment(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% RamanExperiment(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of RamanExperiment properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Raman spectroscopy experiment.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Raman spectroscopy experiment.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the Raman spectroscopy experiment.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Raman spectroscopy experiment.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Raman spectroscopy experiment.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Raman spectroscopy experiment.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the Raman spectroscopy experiment.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>SP_DICT</strong> 	SP_DICT (data, idict) contains the aquired Raman spectra.
			%  <strong>10</strong> <strong>RESEARCHER</strong> 	RESEARCHER (data, option) is the researcher name.
			%  <strong>11</strong> <strong>DATE</strong> 	DATE (data, rvector) is the experiment date.
			%  <strong>12</strong> <strong>PLANT_NAME</strong> 	PLANT_NAME (data, option) is the plant name.
			%  <strong>13</strong> <strong>PLANT_TYPE</strong> 	PLANT_TYPE (data, option) is the plant type
			%  <strong>14</strong> <strong>PLANT_TYPE_COMMENT</strong> 	PLANT_TYPE_COMMENT (data, string) is the mutant type (when mutant is selected).
			%  <strong>15</strong> <strong>PLANT_AGE</strong> 	PLANT_AGE (data, scalar) is the plant age (in weeks).
			%  <strong>16</strong> <strong>LEAF_NUMBER</strong> 	LEAF_NUMBER (data, scalar) is the leaf number.
			%  <strong>17</strong> <strong>GROWTH_MEDIUM</strong> 	GROWTH_MEDIUM (data, option) is the growth medium.
			%  <strong>18</strong> <strong>STRESS_TYPE</strong> 	STRESS_TYPE (data, option) is the lant stress type.
			%  <strong>19</strong> <strong>SETUP</strong> 	SETUP (data, option) is the kind of setup employed.
			%  <strong>20</strong> <strong>LASER_WAVELENGTH</strong> 	LASER_WAVELENGTH (data, option) is the laser wavelength.
			%  <strong>21</strong> <strong>LASER_POWER</strong> 	LASER_POWER (data, scalar) is the laser power.
			%  <strong>22</strong> <strong>ACQUISITION_TIME</strong> 	ACQUISITION_TIME (data, scalar) is the Raman spectral acquisition time.
			%
			% See also Category, Format.
			
			re = re@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function re_class = getClass()
			%GETCLASS returns the class of the Raman spectroscopy experiment.
			%
			% CLASS = RamanExperiment.GETCLASS() returns the class 'RamanExperiment'.
			%
			% Alternative forms to call this method are:
			%  CLASS = RE.GETCLASS() returns the class of the Raman spectroscopy experiment RE.
			%  CLASS = Element.GETCLASS(RE) returns the class of 'RE'.
			%  CLASS = Element.GETCLASS('RamanExperiment') returns 'RamanExperiment'.
			%
			% Note that the Element.GETCLASS(RE) and Element.GETCLASS('RamanExperiment')
			%  are less computationally efficient.
			
			re_class = 'RamanExperiment';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Raman spectroscopy experiment.
			%
			% LIST = RamanExperiment.GETSUBCLASSES() returns all subclasses of 'RamanExperiment'.
			%
			% Alternative forms to call this method are:
			%  LIST = RE.GETSUBCLASSES() returns all subclasses of the Raman spectroscopy experiment RE.
			%  LIST = Element.GETSUBCLASSES(RE) returns all subclasses of 'RE'.
			%  LIST = Element.GETSUBCLASSES('RamanExperiment') returns all subclasses of 'RamanExperiment'.
			%
			% Note that the Element.GETSUBCLASSES(RE) and Element.GETSUBCLASSES('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'RamanExperiment' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Raman spectroscopy experiment.
			%
			% PROPS = RamanExperiment.GETPROPS() returns the property list of Raman spectroscopy experiment
			%  as a row vector.
			%
			% PROPS = RamanExperiment.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = RE.GETPROPS([CATEGORY]) returns the property list of the Raman spectroscopy experiment RE.
			%  PROPS = Element.GETPROPS(RE[, CATEGORY]) returns the property list of 'RE'.
			%  PROPS = Element.GETPROPS('RamanExperiment'[, CATEGORY]) returns the property list of 'RamanExperiment'.
			%
			% Note that the Element.GETPROPS(RE) and Element.GETPROPS('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 9 10 11 12 13 14 15 16 17 18 19 20 21 22];
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of Raman spectroscopy experiment.
			%
			% N = RamanExperiment.GETPROPNUMBER() returns the property number of Raman spectroscopy experiment.
			%
			% N = RamanExperiment.GETPROPNUMBER(CATEGORY) returns the property number of Raman spectroscopy experiment
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = RE.GETPROPNUMBER([CATEGORY]) returns the property number of the Raman spectroscopy experiment RE.
			%  N = Element.GETPROPNUMBER(RE) returns the property number of 'RE'.
			%  N = Element.GETPROPNUMBER('RamanExperiment') returns the property number of 'RamanExperiment'.
			%
			% Note that the Element.GETPROPNUMBER(RE) and Element.GETPROPNUMBER('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 22;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 15;
				case 6 % Category.QUERY
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in Raman spectroscopy experiment/error.
			%
			% CHECK = RamanExperiment.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = RE.EXISTSPROP(PROP) checks whether PROP exists for RE.
			%  CHECK = Element.EXISTSPROP(RE, PROP) checks whether PROP exists for RE.
			%  CHECK = Element.EXISTSPROP(RamanExperiment, PROP) checks whether PROP exists for RamanExperiment.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:RamanExperiment:WrongInput]
			%
			% Alternative forms to call this method are:
			%  RE.EXISTSPROP(PROP) throws error if PROP does NOT exist for RE.
			%   Error id: [BRAPH2:RamanExperiment:WrongInput]
			%  Element.EXISTSPROP(RE, PROP) throws error if PROP does NOT exist for RE.
			%   Error id: [BRAPH2:RamanExperiment:WrongInput]
			%  Element.EXISTSPROP(RamanExperiment, PROP) throws error if PROP does NOT exist for RamanExperiment.
			%   Error id: [BRAPH2:RamanExperiment:WrongInput]
			%
			% Note that the Element.EXISTSPROP(RE) and Element.EXISTSPROP('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 22 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RamanExperiment:' 'WrongInput'], ...
					['BRAPH2' ':RamanExperiment:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for RamanExperiment.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Raman spectroscopy experiment/error.
			%
			% CHECK = RamanExperiment.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = RE.EXISTSTAG(TAG) checks whether TAG exists for RE.
			%  CHECK = Element.EXISTSTAG(RE, TAG) checks whether TAG exists for RE.
			%  CHECK = Element.EXISTSTAG(RamanExperiment, TAG) checks whether TAG exists for RamanExperiment.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:RamanExperiment:WrongInput]
			%
			% Alternative forms to call this method are:
			%  RE.EXISTSTAG(TAG) throws error if TAG does NOT exist for RE.
			%   Error id: [BRAPH2:RamanExperiment:WrongInput]
			%  Element.EXISTSTAG(RE, TAG) throws error if TAG does NOT exist for RE.
			%   Error id: [BRAPH2:RamanExperiment:WrongInput]
			%  Element.EXISTSTAG(RamanExperiment, TAG) throws error if TAG does NOT exist for RamanExperiment.
			%   Error id: [BRAPH2:RamanExperiment:WrongInput]
			%
			% Note that the Element.EXISTSTAG(RE) and Element.EXISTSTAG('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SP_DICT'  'RESEARCHER'  'DATE'  'PLANT_NAME'  'PLANT_TYPE'  'PLANT_TYPE_COMMENT'  'PLANT_AGE'  'LEAF_NUMBER'  'GROWTH_MEDIUM'  'STRESS_TYPE'  'SETUP'  'LASER_WAVELENGTH'  'LASER_POWER'  'ACQUISITION_TIME' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RamanExperiment:' 'WrongInput'], ...
					['BRAPH2' ':RamanExperiment:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for RamanExperiment.'] ...
					)
			end
		end
		function prop = getPropProp(pointer)
			%GETPROPPROP returns the property number of a property.
			%
			% PROP = Element.GETPROPPROP(PROP) returns PROP, i.e., the 
			%  property number of the property PROP.
			%
			% PROP = Element.GETPROPPROP(TAG) returns the property number 
			%  of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PROPERTY = RE.GETPROPPROP(POINTER) returns property number of POINTER of RE.
			%  PROPERTY = Element.GETPROPPROP(RamanExperiment, POINTER) returns property number of POINTER of RamanExperiment.
			%  PROPERTY = RE.GETPROPPROP(RamanExperiment, POINTER) returns property number of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPPROP(RE) and Element.GETPROPPROP('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SP_DICT'  'RESEARCHER'  'DATE'  'PLANT_NAME'  'PLANT_TYPE'  'PLANT_TYPE_COMMENT'  'PLANT_AGE'  'LEAF_NUMBER'  'GROWTH_MEDIUM'  'STRESS_TYPE'  'SETUP'  'LASER_WAVELENGTH'  'LASER_POWER'  'ACQUISITION_TIME' })); % tag = pointer %CET: Computational Efficiency Trick
			else % numeric
				prop = pointer;
			end
		end
		function tag = getPropTag(pointer)
			%GETPROPTAG returns the tag of a property.
			%
			% TAG = Element.GETPROPTAG(PROP) returns the tag TAG of the 
			%  property PROP.
			%
			% TAG = Element.GETPROPTAG(TAG) returns TAG, i.e. the tag of 
			%  the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  TAG = RE.GETPROPTAG(POINTER) returns tag of POINTER of RE.
			%  TAG = Element.GETPROPTAG(RamanExperiment, POINTER) returns tag of POINTER of RamanExperiment.
			%  TAG = RE.GETPROPTAG(RamanExperiment, POINTER) returns tag of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPTAG(RE) and Element.GETPROPTAG('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				ramanexperiment_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'SP_DICT'  'RESEARCHER'  'DATE'  'PLANT_NAME'  'PLANT_TYPE'  'PLANT_TYPE_COMMENT'  'PLANT_AGE'  'LEAF_NUMBER'  'GROWTH_MEDIUM'  'STRESS_TYPE'  'SETUP'  'LASER_WAVELENGTH'  'LASER_POWER'  'ACQUISITION_TIME' };
				tag = ramanexperiment_tag_list{pointer}; % prop = pointer
			end
		end
		function prop_category = getPropCategory(pointer)
			%GETPROPCATEGORY returns the category of a property.
			%
			% CATEGORY = Element.GETPROPCATEGORY(PROP) returns the category of the
			%  property PROP.
			%
			% CATEGORY = Element.GETPROPCATEGORY(TAG) returns the category of the
			%  property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CATEGORY = RE.GETPROPCATEGORY(POINTER) returns category of POINTER of RE.
			%  CATEGORY = Element.GETPROPCATEGORY(RamanExperiment, POINTER) returns category of POINTER of RamanExperiment.
			%  CATEGORY = RE.GETPROPCATEGORY(RamanExperiment, POINTER) returns category of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPCATEGORY(RE) and Element.GETPROPCATEGORY('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = RamanExperiment.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ramanexperiment_category_list = { 1  1  1  3  4  2  2  6  4  4  4  4  4  4  4  4  4  4  4  4  4  4 };
			prop_category = ramanexperiment_category_list{prop};
		end
		function prop_format = getPropFormat(pointer)
			%GETPROPFORMAT returns the format of a property.
			%
			% FORMAT = Element.GETPROPFORMAT(PROP) returns the
			%  format of the property PROP.
			%
			% FORMAT = Element.GETPROPFORMAT(TAG) returns the
			%  format of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  FORMAT = RE.GETPROPFORMAT(POINTER) returns format of POINTER of RE.
			%  FORMAT = Element.GETPROPFORMAT(RamanExperiment, POINTER) returns format of POINTER of RamanExperiment.
			%  FORMAT = RE.GETPROPFORMAT(RamanExperiment, POINTER) returns format of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPFORMAT(RE) and Element.GETPROPFORMAT('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = RamanExperiment.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ramanexperiment_format_list = { 2  2  2  8  2  2  2  2  10  5  12  5  5  2  11  11  5  5  5  5  11  11 };
			prop_format = ramanexperiment_format_list{prop};
		end
		function prop_description = getPropDescription(pointer)
			%GETPROPDESCRIPTION returns the description of a property.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(PROP) returns the
			%  description of the property PROP.
			%
			% DESCRIPTION = Element.GETPROPDESCRIPTION(TAG) returns the
			%  description of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DESCRIPTION = RE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of RE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(RamanExperiment, POINTER) returns description of POINTER of RamanExperiment.
			%  DESCRIPTION = RE.GETPROPDESCRIPTION(RamanExperiment, POINTER) returns description of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPDESCRIPTION(RE) and Element.GETPROPDESCRIPTION('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = RamanExperiment.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ramanexperiment_description_list = { 'ELCLASS (constant, string) is the class of the Raman spectroscopy experiment.'  'NAME (constant, string) is the name of the Raman spectroscopy experiment.'  'DESCRIPTION (constant, string) is the description of the Raman spectroscopy experiment.'  'TEMPLATE (parameter, item) is the template of the Raman spectroscopy experiment.'  'ID (data, string) is a few-letter code for the Raman spectroscopy experiment.'  'LABEL (metadata, string) is an extended label of the Raman spectroscopy experiment.'  'NOTES (metadata, string) are some specific notes about the Raman spectroscopy experiment.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'SP_DICT (data, idict) contains the aquired Raman spectra.'  'RESEARCHER (data, option) is the researcher name.'  'DATE (data, rvector) is the experiment date.'  'PLANT_NAME (data, option) is the plant name.'  'PLANT_TYPE (data, option) is the plant type'  'PLANT_TYPE_COMMENT (data, string) is the mutant type (when mutant is selected).'  'PLANT_AGE (data, scalar) is the plant age (in weeks).'  'LEAF_NUMBER (data, scalar) is the leaf number.'  'GROWTH_MEDIUM (data, option) is the growth medium.'  'STRESS_TYPE (data, option) is the lant stress type.'  'SETUP (data, option) is the kind of setup employed.'  'LASER_WAVELENGTH (data, option) is the laser wavelength.'  'LASER_POWER (data, scalar) is the laser power.'  'ACQUISITION_TIME (data, scalar) is the Raman spectral acquisition time.' };
			prop_description = ramanexperiment_description_list{prop};
		end
		function prop_settings = getPropSettings(pointer)
			%GETPROPSETTINGS returns the settings of a property.
			%
			% SETTINGS = Element.GETPROPSETTINGS(PROP) returns the
			%  settings of the property PROP.
			%
			% SETTINGS = Element.GETPROPSETTINGS(TAG) returns the
			%  settings of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SETTINGS = RE.GETPROPSETTINGS(POINTER) returns settings of POINTER of RE.
			%  SETTINGS = Element.GETPROPSETTINGS(RamanExperiment, POINTER) returns settings of POINTER of RamanExperiment.
			%  SETTINGS = RE.GETPROPSETTINGS(RamanExperiment, POINTER) returns settings of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPSETTINGS(RE) and Element.GETPROPSETTINGS('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = RamanExperiment.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % RamanExperiment.SP_DICT
					prop_settings = 'Spectrum';
				case 10 % RamanExperiment.RESEARCHER
					prop_settings = {'--', 'Alice', 'Benny', 'Chung Hao', 'Ekta', 'Gajendra', 'Ganga', 'Javier', 'Mervin', 'Michelle', 'Monika', 'Niha', 'Nivedita', 'Pil Joong', 'Praveen', 'Raju', 'Sally', 'Savita', 'Sayuj', 'Sayyid', 'Shilpi', 'Song Yi', 'Thinh', 'Yangyang', 'Zheng Yong'};
				case 11 % RamanExperiment.DATE
					prop_settings = Format.getFormatSettings(12);
				case 12 % RamanExperiment.PLANT_NAME
					prop_settings = {'--', 'Algae', 'Amaranth', 'Arabidopsis', 'Bell Pepper', 'Choy Sum', 'Lettuce', 'Kale', 'Pak Choi', 'Tobacco'};
				case 13 % RamanExperiment.PLANT_TYPE
					prop_settings = {'--', 'wild type', 'mutant', 'transgenic'};
				case 14 % RamanExperiment.PLANT_TYPE_COMMENT
					prop_settings = Format.getFormatSettings(2);
				case 15 % RamanExperiment.PLANT_AGE
					prop_settings = Format.getFormatSettings(11);
				case 16 % RamanExperiment.LEAF_NUMBER
					prop_settings = Format.getFormatSettings(11);
				case 17 % RamanExperiment.GROWTH_MEDIUM
					prop_settings = {'--', 'soil', 'hydroponics'};
				case 18 % RamanExperiment.STRESS_TYPE
					prop_settings = {'--', 'bacterial', 'drought', 'fungal', 'high light', 'mechanical damage', 'nutrient', 'salt', 'SAS', 'spraying', 'water-logged'};
				case 19 % RamanExperiment.SETUP
					prop_settings = {'--', 'Raman microscope', 'benchtop', 'portable', 'hand-held'};
				case 20 % RamanExperiment.LASER_WAVELENGTH
					prop_settings = {'--', '532 nm', '785 nm', '830 nm', '1064 nm'};
				case 21 % RamanExperiment.LASER_POWER
					prop_settings = Format.getFormatSettings(11);
				case 22 % RamanExperiment.ACQUISITION_TIME
					prop_settings = Format.getFormatSettings(11);
				case 4 % RamanExperiment.TEMPLATE
					prop_settings = 'RamanExperiment';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = RamanExperiment.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = RamanExperiment.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = RE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of RE.
			%  DEFAULT = Element.GETPROPDEFAULT(RamanExperiment, POINTER) returns the default value of POINTER of RamanExperiment.
			%  DEFAULT = RE.GETPROPDEFAULT(RamanExperiment, POINTER) returns the default value of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPDEFAULT(RE) and Element.GETPROPDEFAULT('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = RamanExperiment.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % RamanExperiment.SP_DICT
					prop_default = Format.getFormatDefault(10, RamanExperiment.getPropSettings(prop));
				case 10 % RamanExperiment.RESEARCHER
					prop_default = Format.getFormatDefault(5, RamanExperiment.getPropSettings(prop));
				case 11 % RamanExperiment.DATE
					prop_default = [2000 1 1];
				case 12 % RamanExperiment.PLANT_NAME
					prop_default = Format.getFormatDefault(5, RamanExperiment.getPropSettings(prop));
				case 13 % RamanExperiment.PLANT_TYPE
					prop_default = Format.getFormatDefault(5, RamanExperiment.getPropSettings(prop));
				case 14 % RamanExperiment.PLANT_TYPE_COMMENT
					prop_default = Format.getFormatDefault(2, RamanExperiment.getPropSettings(prop));
				case 15 % RamanExperiment.PLANT_AGE
					prop_default = Format.getFormatDefault(11, RamanExperiment.getPropSettings(prop));
				case 16 % RamanExperiment.LEAF_NUMBER
					prop_default = Format.getFormatDefault(11, RamanExperiment.getPropSettings(prop));
				case 17 % RamanExperiment.GROWTH_MEDIUM
					prop_default = Format.getFormatDefault(5, RamanExperiment.getPropSettings(prop));
				case 18 % RamanExperiment.STRESS_TYPE
					prop_default = Format.getFormatDefault(5, RamanExperiment.getPropSettings(prop));
				case 19 % RamanExperiment.SETUP
					prop_default = Format.getFormatDefault(5, RamanExperiment.getPropSettings(prop));
				case 20 % RamanExperiment.LASER_WAVELENGTH
					prop_default = Format.getFormatDefault(5, RamanExperiment.getPropSettings(prop));
				case 21 % RamanExperiment.LASER_POWER
					prop_default = Format.getFormatDefault(11, RamanExperiment.getPropSettings(prop));
				case 22 % RamanExperiment.ACQUISITION_TIME
					prop_default = Format.getFormatDefault(11, RamanExperiment.getPropSettings(prop));
				case 1 % RamanExperiment.ELCLASS
					prop_default = 'RamanExperiment';
				case 2 % RamanExperiment.NAME
					prop_default = 'Raman spectroscopy experiment';
				case 3 % RamanExperiment.DESCRIPTION
					prop_default = 'RamanExperiment is a Raman spectroscopy experiment.';
				case 4 % RamanExperiment.TEMPLATE
					prop_default = Format.getFormatDefault(8, RamanExperiment.getPropSettings(prop));
				case 5 % RamanExperiment.ID
					prop_default = 'RamanExperiment ID';
				case 6 % RamanExperiment.LABEL
					prop_default = 'RamanExperiment label';
				case 7 % RamanExperiment.NOTES
					prop_default = 'RamanExperiment notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = RamanExperiment.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = RamanExperiment.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = RE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of RE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(RamanExperiment, POINTER) returns the conditioned default value of POINTER of RamanExperiment.
			%  DEFAULT = RE.GETPROPDEFAULTCONDITIONED(RamanExperiment, POINTER) returns the conditioned default value of POINTER of RamanExperiment.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(RE) and Element.GETPROPDEFAULTCONDITIONED('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = RamanExperiment.getPropProp(pointer);
			
			prop_default = RamanExperiment.conditioning(prop, RamanExperiment.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = RE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = RE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of RE.
			%  CHECK = Element.CHECKPROP(RamanExperiment, PROP, VALUE) checks VALUE format for PROP of RamanExperiment.
			%  CHECK = RE.CHECKPROP(RamanExperiment, PROP, VALUE) checks VALUE format for PROP of RamanExperiment.
			% 
			% RE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:RamanExperiment:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  RE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of RE.
			%   Error id: BRAPH2:RamanExperiment:WrongInput
			%  Element.CHECKPROP(RamanExperiment, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RamanExperiment.
			%   Error id: BRAPH2:RamanExperiment:WrongInput
			%  RE.CHECKPROP(RamanExperiment, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RamanExperiment.
			%   Error id: BRAPH2:RamanExperiment:WrongInput]
			% 
			% Note that the Element.CHECKPROP(RE) and Element.CHECKPROP('RamanExperiment')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = RamanExperiment.getPropProp(pointer);
			
			switch prop
				case 9 % RamanExperiment.SP_DICT
					check = Format.checkFormat(10, value, RamanExperiment.getPropSettings(prop));
				case 10 % RamanExperiment.RESEARCHER
					check = Format.checkFormat(5, value, RamanExperiment.getPropSettings(prop));
				case 11 % RamanExperiment.DATE
					check = Format.checkFormat(12, value, RamanExperiment.getPropSettings(prop));
				case 12 % RamanExperiment.PLANT_NAME
					check = Format.checkFormat(5, value, RamanExperiment.getPropSettings(prop));
				case 13 % RamanExperiment.PLANT_TYPE
					check = Format.checkFormat(5, value, RamanExperiment.getPropSettings(prop));
				case 14 % RamanExperiment.PLANT_TYPE_COMMENT
					check = Format.checkFormat(2, value, RamanExperiment.getPropSettings(prop));
				case 15 % RamanExperiment.PLANT_AGE
					check = Format.checkFormat(11, value, RamanExperiment.getPropSettings(prop));
				case 16 % RamanExperiment.LEAF_NUMBER
					check = Format.checkFormat(11, value, RamanExperiment.getPropSettings(prop));
				case 17 % RamanExperiment.GROWTH_MEDIUM
					check = Format.checkFormat(5, value, RamanExperiment.getPropSettings(prop));
				case 18 % RamanExperiment.STRESS_TYPE
					check = Format.checkFormat(5, value, RamanExperiment.getPropSettings(prop));
				case 19 % RamanExperiment.SETUP
					check = Format.checkFormat(5, value, RamanExperiment.getPropSettings(prop));
				case 20 % RamanExperiment.LASER_WAVELENGTH
					check = Format.checkFormat(5, value, RamanExperiment.getPropSettings(prop));
				case 21 % RamanExperiment.LASER_POWER
					check = Format.checkFormat(11, value, RamanExperiment.getPropSettings(prop));
				case 22 % RamanExperiment.ACQUISITION_TIME
					check = Format.checkFormat(11, value, RamanExperiment.getPropSettings(prop));
				case 4 % RamanExperiment.TEMPLATE
					check = Format.checkFormat(8, value, RamanExperiment.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RamanExperiment:' 'WrongInput'], ...
					['BRAPH2' ':RamanExperiment:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' RamanExperiment.getPropTag(prop) ' (' RamanExperiment.getFormatTag(RamanExperiment.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(re, prop, varargin)
			%GETPANELPROP returns a prop panel.
			%
			% PR = GETPANELPROP(EL, PROP) returns the panel of prop PROP.
			%
			% PR = GETPANELPROP(EL, PROP, 'Name', Value, ...) sets the properties 
			%  of the panel prop.
			%
			% See also PanelProp, PanelPropAlpha, PanelPropCell, PanelPropClass,
			%  PanelPropClassList, PanelPropColor, PanelPropHandle,
			%  PanelPropHandleList, PanelPropIDict, PanelPropItem, PanelPropLine,
			%  PanelPropItemList, PanelPropLogical, PanelPropMarker, PanelPropMatrix,
			%  PanelPropNet, PanelPropOption, PanelPropScalar, PanelPropSize,
			%  PanelPropString, PanelPropStringList.
			
			switch prop
				case 9 % RamanExperiment.SP_DICT
					pr = PanelPropIDictTable('EL', re, 'PROP', 9, ... 
					    'COLS', [-1 9 5 6 10 12 7], ... 
					    'ROWNAME', 'numbered', ...
					    'MENU_OPEN_ITEMS', true, ...
						varargin{:});
					
				case 11 % RamanExperiment.DATE
					pr = PanelPropRVectorDate('EL', re, 'PROP', 11);
					
				case 5 % RamanExperiment.ID
					pr = DistapPP_ID('EL', re, 'PROP', 5);
					
				otherwise
					pr = getPanelProp@ConcreteElement(re, prop, varargin{:});
					
			end
		end
	end
end
