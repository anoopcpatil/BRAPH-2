classdef REAnalysisModule < ConcreteElement
	%REAnalysisModule is a Raman Experiment analysis element.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A RE Analysis Module (REAnalysisModule) is the base module that 
	% copies the RamanExperiment to read and process the Raman spectra 
	% and plots the processed spectra.
	%
	% The list of REAnalysisModule properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the RE Analysis Module.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the RE Analysis Module.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of RE Analysis Module.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the RE Analysis Module.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the RE Analysis Module.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the RE Analysis Module.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about RE Analysis Module.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (query, item) is the processed spectrum in SP_DICT of RE_IN for RE_OUT.
	%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
	%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
	%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
	%
	% REAnalysisModule methods (constructor):
	%  REAnalysisModule - constructor
	%
	% REAnalysisModule methods:
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
	% REAnalysisModule methods (display):
	%  tostring - string with information about the RE Analysis Module
	%  disp - displays information about the RE Analysis Module
	%  tree - displays the tree of the RE Analysis Module
	%
	% REAnalysisModule methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two RE Analysis Module are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the RE Analysis Module
	%
	% REAnalysisModule methods (save/load, Static):
	%  save - saves BRAPH2 RE Analysis Module as b2 file
	%  load - loads a BRAPH2 RE Analysis Module from a b2 file
	%
	% REAnalysisModule method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the RE Analysis Module
	%
	% REAnalysisModule method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the RE Analysis Module
	%
	% REAnalysisModule methods (inspection, Static):
	%  getClass - returns the class of the RE Analysis Module
	%  getSubclasses - returns all subclasses of REAnalysisModule
	%  getProps - returns the property list of the RE Analysis Module
	%  getPropNumber - returns the property number of the RE Analysis Module
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
	% REAnalysisModule methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% REAnalysisModule methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% REAnalysisModule methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% REAnalysisModule methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?REAnalysisModule; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">REAnalysisModule constants</a>.
	%
	%
	% See also RamanExperiment, Spectrum.
	
	properties (Constant) % properties
		RE_IN = 9; %CET: Computational Efficiency Trick
		RE_IN_TAG = 'RE_IN';
		RE_IN_CATEGORY = 4;
		RE_IN_FORMAT = 8;
		
		SP_OUT = 10; %CET: Computational Efficiency Trick
		SP_OUT_TAG = 'SP_OUT';
		SP_OUT_CATEGORY = 6;
		SP_OUT_FORMAT = 8;
		
		SP_DICT_OUT = 11; %CET: Computational Efficiency Trick
		SP_DICT_OUT_TAG = 'SP_DICT_OUT';
		SP_DICT_OUT_CATEGORY = 5;
		SP_DICT_OUT_FORMAT = 10;
		
		RE_OUT = 12; %CET: Computational Efficiency Trick
		RE_OUT_TAG = 'RE_OUT';
		RE_OUT_CATEGORY = 5;
		RE_OUT_FORMAT = 8;
		
		REPF = 13; %CET: Computational Efficiency Trick
		REPF_TAG = 'REPF';
		REPF_CATEGORY = 9;
		REPF_FORMAT = 8;
	end
	methods % constructor
		function ream = REAnalysisModule(varargin)
			%REAnalysisModule() creates a RE Analysis Module.
			%
			% REAnalysisModule(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% REAnalysisModule(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of REAnalysisModule properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the RE Analysis Module.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the RE Analysis Module.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of RE Analysis Module.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the RE Analysis Module.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the RE Analysis Module.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the RE Analysis Module.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about RE Analysis Module.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (query, item) is the processed spectrum in SP_DICT of RE_IN for RE_OUT.
			%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
			%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
			%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
			%
			% See also Category, Format.
			
			ream = ream@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function ream_class = getClass()
			%GETCLASS returns the class of the RE Analysis Module.
			%
			% CLASS = REAnalysisModule.GETCLASS() returns the class 'REAnalysisModule'.
			%
			% Alternative forms to call this method are:
			%  CLASS = REAM.GETCLASS() returns the class of the RE Analysis Module REAM.
			%  CLASS = Element.GETCLASS(REAM) returns the class of 'REAM'.
			%  CLASS = Element.GETCLASS('REAnalysisModule') returns 'REAnalysisModule'.
			%
			% Note that the Element.GETCLASS(REAM) and Element.GETCLASS('REAnalysisModule')
			%  are less computationally efficient.
			
			ream_class = 'REAnalysisModule';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the RE Analysis Module.
			%
			% LIST = REAnalysisModule.GETSUBCLASSES() returns all subclasses of 'REAnalysisModule'.
			%
			% Alternative forms to call this method are:
			%  LIST = REAM.GETSUBCLASSES() returns all subclasses of the RE Analysis Module REAM.
			%  LIST = Element.GETSUBCLASSES(REAM) returns all subclasses of 'REAM'.
			%  LIST = Element.GETSUBCLASSES('REAnalysisModule') returns all subclasses of 'REAnalysisModule'.
			%
			% Note that the Element.GETSUBCLASSES(REAM) and Element.GETSUBCLASSES('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'REAnalysisModule'  'BaselineEstimator'  'BaselinedRamanGenerator'  'CosmicRayNoiseRemover'  'SmoothingFilter' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of RE Analysis Module.
			%
			% PROPS = REAnalysisModule.GETPROPS() returns the property list of RE Analysis Module
			%  as a row vector.
			%
			% PROPS = REAnalysisModule.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = REAM.GETPROPS([CATEGORY]) returns the property list of the RE Analysis Module REAM.
			%  PROPS = Element.GETPROPS(REAM[, CATEGORY]) returns the property list of 'REAM'.
			%  PROPS = Element.GETPROPS('REAnalysisModule'[, CATEGORY]) returns the property list of 'REAnalysisModule'.
			%
			% Note that the Element.GETPROPS(REAM) and Element.GETPROPS('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13];
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
					prop_list = [5 9];
				case 5 % Category.RESULT
					prop_list = [11 12];
				case 6 % Category.QUERY
					prop_list = [8 10];
				case 9 % Category.GUI
					prop_list = 13;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of RE Analysis Module.
			%
			% N = REAnalysisModule.GETPROPNUMBER() returns the property number of RE Analysis Module.
			%
			% N = REAnalysisModule.GETPROPNUMBER(CATEGORY) returns the property number of RE Analysis Module
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = REAM.GETPROPNUMBER([CATEGORY]) returns the property number of the RE Analysis Module REAM.
			%  N = Element.GETPROPNUMBER(REAM) returns the property number of 'REAM'.
			%  N = Element.GETPROPNUMBER('REAnalysisModule') returns the property number of 'REAnalysisModule'.
			%
			% Note that the Element.GETPROPNUMBER(REAM) and Element.GETPROPNUMBER('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 13;
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
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 2;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in RE Analysis Module/error.
			%
			% CHECK = REAnalysisModule.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = REAM.EXISTSPROP(PROP) checks whether PROP exists for REAM.
			%  CHECK = Element.EXISTSPROP(REAM, PROP) checks whether PROP exists for REAM.
			%  CHECK = Element.EXISTSPROP(REAnalysisModule, PROP) checks whether PROP exists for REAnalysisModule.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%
			% Alternative forms to call this method are:
			%  REAM.EXISTSPROP(PROP) throws error if PROP does NOT exist for REAM.
			%   Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%  Element.EXISTSPROP(REAM, PROP) throws error if PROP does NOT exist for REAM.
			%   Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%  Element.EXISTSPROP(REAnalysisModule, PROP) throws error if PROP does NOT exist for REAnalysisModule.
			%   Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%
			% Note that the Element.EXISTSPROP(REAM) and Element.EXISTSPROP('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':REAnalysisModule:' 'WrongInput'], ...
					['BRAPH2' ':REAnalysisModule:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for REAnalysisModule.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in RE Analysis Module/error.
			%
			% CHECK = REAnalysisModule.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = REAM.EXISTSTAG(TAG) checks whether TAG exists for REAM.
			%  CHECK = Element.EXISTSTAG(REAM, TAG) checks whether TAG exists for REAM.
			%  CHECK = Element.EXISTSTAG(REAnalysisModule, TAG) checks whether TAG exists for REAnalysisModule.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%
			% Alternative forms to call this method are:
			%  REAM.EXISTSTAG(TAG) throws error if TAG does NOT exist for REAM.
			%   Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%  Element.EXISTSTAG(REAM, TAG) throws error if TAG does NOT exist for REAM.
			%   Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%  Element.EXISTSTAG(REAnalysisModule, TAG) throws error if TAG does NOT exist for REAnalysisModule.
			%   Error id: [BRAPH2:REAnalysisModule:WrongInput]
			%
			% Note that the Element.EXISTSTAG(REAM) and Element.EXISTSTAG('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':REAnalysisModule:' 'WrongInput'], ...
					['BRAPH2' ':REAnalysisModule:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for REAnalysisModule.'] ...
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
			%  PROPERTY = REAM.GETPROPPROP(POINTER) returns property number of POINTER of REAM.
			%  PROPERTY = Element.GETPROPPROP(REAnalysisModule, POINTER) returns property number of POINTER of REAnalysisModule.
			%  PROPERTY = REAM.GETPROPPROP(REAnalysisModule, POINTER) returns property number of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPPROP(REAM) and Element.GETPROPPROP('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = REAM.GETPROPTAG(POINTER) returns tag of POINTER of REAM.
			%  TAG = Element.GETPROPTAG(REAnalysisModule, POINTER) returns tag of POINTER of REAnalysisModule.
			%  TAG = REAM.GETPROPTAG(REAnalysisModule, POINTER) returns tag of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPTAG(REAM) and Element.GETPROPTAG('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				reanalysismodule_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF' };
				tag = reanalysismodule_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = REAM.GETPROPCATEGORY(POINTER) returns category of POINTER of REAM.
			%  CATEGORY = Element.GETPROPCATEGORY(REAnalysisModule, POINTER) returns category of POINTER of REAnalysisModule.
			%  CATEGORY = REAM.GETPROPCATEGORY(REAnalysisModule, POINTER) returns category of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPCATEGORY(REAM) and Element.GETPROPCATEGORY('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = REAnalysisModule.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			reanalysismodule_category_list = { 1  1  1  3  4  2  2  6  4  6  5  5  9 };
			prop_category = reanalysismodule_category_list{prop};
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
			%  FORMAT = REAM.GETPROPFORMAT(POINTER) returns format of POINTER of REAM.
			%  FORMAT = Element.GETPROPFORMAT(REAnalysisModule, POINTER) returns format of POINTER of REAnalysisModule.
			%  FORMAT = REAM.GETPROPFORMAT(REAnalysisModule, POINTER) returns format of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPFORMAT(REAM) and Element.GETPROPFORMAT('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = REAnalysisModule.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			reanalysismodule_format_list = { 2  2  2  8  2  2  2  2  8  8  10  8  8 };
			prop_format = reanalysismodule_format_list{prop};
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
			%  DESCRIPTION = REAM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of REAM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(REAnalysisModule, POINTER) returns description of POINTER of REAnalysisModule.
			%  DESCRIPTION = REAM.GETPROPDESCRIPTION(REAnalysisModule, POINTER) returns description of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPDESCRIPTION(REAM) and Element.GETPROPDESCRIPTION('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = REAnalysisModule.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			reanalysismodule_description_list = { 'ELCLASS (constant, string) is the class of the RE Analysis Module.'  'NAME (constant, string) is the name of the RE Analysis Module.'  'DESCRIPTION (constant, string) is the description of RE Analysis Module.'  'TEMPLATE (parameter, item) is the template of the RE Analysis Module.'  'ID (data, string) is a few-letter code for the RE Analysis Module.'  'LABEL (metadata, string) is an extended label of the RE Analysis Module.'  'NOTES (metadata, string) are some specific notes about RE Analysis Module.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'SP_OUT (query, item) is the processed spectrum in SP_DICT of RE_IN for RE_OUT.'  'SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. '  'RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the REAnalysisModule.' };
			prop_description = reanalysismodule_description_list{prop};
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
			%  SETTINGS = REAM.GETPROPSETTINGS(POINTER) returns settings of POINTER of REAM.
			%  SETTINGS = Element.GETPROPSETTINGS(REAnalysisModule, POINTER) returns settings of POINTER of REAnalysisModule.
			%  SETTINGS = REAM.GETPROPSETTINGS(REAnalysisModule, POINTER) returns settings of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPSETTINGS(REAM) and Element.GETPROPSETTINGS('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = REAnalysisModule.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % REAnalysisModule.RE_IN
					prop_settings = 'RamanExperiment';
				case 10 % REAnalysisModule.SP_OUT
					prop_settings = 'Spectrum';
				case 11 % REAnalysisModule.SP_DICT_OUT
					prop_settings = Format.getFormatSettings(10);
				case 12 % REAnalysisModule.RE_OUT
					prop_settings = 'RamanExperiment';
				case 13 % REAnalysisModule.REPF
					prop_settings = 'RamanExperimentPF';
				case 4 % REAnalysisModule.TEMPLATE
					prop_settings = 'REAnalysisModule';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = REAnalysisModule.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = REAnalysisModule.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = REAM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of REAM.
			%  DEFAULT = Element.GETPROPDEFAULT(REAnalysisModule, POINTER) returns the default value of POINTER of REAnalysisModule.
			%  DEFAULT = REAM.GETPROPDEFAULT(REAnalysisModule, POINTER) returns the default value of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPDEFAULT(REAM) and Element.GETPROPDEFAULT('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = REAnalysisModule.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % REAnalysisModule.RE_IN
					prop_default = Format.getFormatDefault(8, REAnalysisModule.getPropSettings(prop));
				case 10 % REAnalysisModule.SP_OUT
					prop_default = Format.getFormatDefault(8, REAnalysisModule.getPropSettings(prop));
				case 11 % REAnalysisModule.SP_DICT_OUT
					prop_default = Format.getFormatDefault(10, REAnalysisModule.getPropSettings(prop));
				case 12 % REAnalysisModule.RE_OUT
					prop_default = Format.getFormatDefault(8, REAnalysisModule.getPropSettings(prop));
				case 13 % REAnalysisModule.REPF
					prop_default = Format.getFormatDefault(8, REAnalysisModule.getPropSettings(prop));
				case 1 % REAnalysisModule.ELCLASS
					prop_default = 'REAnalysisModule';
				case 2 % REAnalysisModule.NAME
					prop_default = 'REAnalysisModule';
				case 3 % REAnalysisModule.DESCRIPTION
					prop_default = 'REAnalysisModule copies the RamanExperiment element and analyzes and plots the resulting spectra.';
				case 4 % REAnalysisModule.TEMPLATE
					prop_default = Format.getFormatDefault(8, REAnalysisModule.getPropSettings(prop));
				case 5 % REAnalysisModule.ID
					prop_default = 'REAnalysisModule ID';
				case 6 % REAnalysisModule.LABEL
					prop_default = 'REAnalysisModule label';
				case 7 % REAnalysisModule.NOTES
					prop_default = 'REAnalysisModule notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = REAnalysisModule.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = REAnalysisModule.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = REAM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of REAM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(REAnalysisModule, POINTER) returns the conditioned default value of POINTER of REAnalysisModule.
			%  DEFAULT = REAM.GETPROPDEFAULTCONDITIONED(REAnalysisModule, POINTER) returns the conditioned default value of POINTER of REAnalysisModule.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(REAM) and Element.GETPROPDEFAULTCONDITIONED('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = REAnalysisModule.getPropProp(pointer);
			
			prop_default = REAnalysisModule.conditioning(prop, REAnalysisModule.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = REAM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = REAM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of REAM.
			%  CHECK = Element.CHECKPROP(REAnalysisModule, PROP, VALUE) checks VALUE format for PROP of REAnalysisModule.
			%  CHECK = REAM.CHECKPROP(REAnalysisModule, PROP, VALUE) checks VALUE format for PROP of REAnalysisModule.
			% 
			% REAM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:REAnalysisModule:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  REAM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of REAM.
			%   Error id: BRAPH2:REAnalysisModule:WrongInput
			%  Element.CHECKPROP(REAnalysisModule, PROP, VALUE) throws error if VALUE has not a valid format for PROP of REAnalysisModule.
			%   Error id: BRAPH2:REAnalysisModule:WrongInput
			%  REAM.CHECKPROP(REAnalysisModule, PROP, VALUE) throws error if VALUE has not a valid format for PROP of REAnalysisModule.
			%   Error id: BRAPH2:REAnalysisModule:WrongInput]
			% 
			% Note that the Element.CHECKPROP(REAM) and Element.CHECKPROP('REAnalysisModule')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = REAnalysisModule.getPropProp(pointer);
			
			switch prop
				case 9 % REAnalysisModule.RE_IN
					check = Format.checkFormat(8, value, REAnalysisModule.getPropSettings(prop));
				case 10 % REAnalysisModule.SP_OUT
					check = Format.checkFormat(8, value, REAnalysisModule.getPropSettings(prop));
				case 11 % REAnalysisModule.SP_DICT_OUT
					check = Format.checkFormat(10, value, REAnalysisModule.getPropSettings(prop));
				case 12 % REAnalysisModule.RE_OUT
					check = Format.checkFormat(8, value, REAnalysisModule.getPropSettings(prop));
				case 13 % REAnalysisModule.REPF
					check = Format.checkFormat(8, value, REAnalysisModule.getPropSettings(prop));
				case 4 % REAnalysisModule.TEMPLATE
					check = Format.checkFormat(8, value, REAnalysisModule.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':REAnalysisModule:' 'WrongInput'], ...
					['BRAPH2' ':REAnalysisModule:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' REAnalysisModule.getPropTag(prop) ' (' REAnalysisModule.getFormatTag(REAnalysisModule.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(ream, prop, varargin)
			%CALCULATEVALUE calculates the value of a property.
			%
			% VALUE = CALCULATEVALUE(EL, PROP) calculates the value of the property
			%  PROP. It works only with properties with 5,
			%  6, and 7. By default this function
			%  returns the default value for the prop and should be implemented in the
			%  subclasses of Element when needed.
			%
			% VALUE = CALCULATEVALUE(EL, PROP, VARARGIN) works with properties with
			%  6.
			%
			% See also getPropDefaultConditioned, conditioning, preset, checkProp,
			%  postset, postprocessing, checkValue.
			
			switch prop
				case 10 % REAnalysisModule.SP_OUT
					% sp_out = ream.get('SP_OUT', SP_IN) returns the processed N-th spectrum in 
					% SP_DICT of input Raman Experiment RE_IN
					if isempty(varargin)
					    value = Spectrum();
					    return
					end
					sp_in = varargin{1};
					% Create unlocked copy of the input spectrum
					sp_out = Spectrum(...
					         'INTENSITIES', sp_in.get('INTENSITIES'), ...
					         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
					         'ID', sp_in.get('ID'), ...
					         'LABEL', sp_in.get('LABEL'), ...
					         'NOTES', sp_in.get('NOTES'));
					value = sp_out;
					
				case 11 % REAnalysisModule.SP_DICT_OUT
					rng_settings_ = rng(); rng(ream.getPropSeed(11), 'twister')
					
					% sp_dict_out = ream.get('SP_DICT_OUT') returns the
					% processed SP_DICT for input Raman Experiment RE_IN
					% Create a new IndexedDictionary
					sp_dict_out = IndexedDictionary('IT_CLASS', ream.get('RE_IN').get('SP_DICT').get('IT_CLASS'));
					
					% Get the length of SP_DICT of RE_IN. 
					dict_length = ream.get('RE_IN').get('SP_DICT').get('LENGTH');
					
					% Update sp_dict_out with processed spectra
					for n = 1:1:dict_length
					    sp_in = ream.get('RE_IN').get('SP_DICT').get('IT', n);
					    sp_out = ream.get('SP_OUT', sp_in);
					    sp_dict_out.get('ADD', sp_out);
					end 
					% Set the updated value of sp_dict_out to SP_DICT_OUT
					value = sp_dict_out;
					
					rng(rng_settings_)
					
				case 12 % REAnalysisModule.RE_OUT
					rng_settings_ = rng(); rng(ream.getPropSeed(12), 'twister')
					
					% Read input Raman experiment
					re_in = ream.get('RE_IN');
					
					% Copy the data_props of input Raman experiment
					data_props = re_in.getProps(4);
					varargin = cell(1, 2 * length(data_props));
					for i = 1:1:length(data_props)
					    data_prop = data_props(i);
					    varargin{2 * i - 1} = data_prop;
					    varargin{2 * i} = re_in.getCallback(data_prop);    
					end
					
					% Create an output Raman experiment with metadata and data props info
					re_out = RamanExperiment('LABEL', re_in.get('LABEL'), ...
					                         'NOTES', re_in.get('NOTES'), ...
					                         varargin{:});
					
					% Copy the processed SP_DICT of RE_IN to 
					% the SP_DICT of RE_OUT
					re_out.set('SP_DICT', ream.get('SP_DICT_OUT'))
					
					% Set the re_out to RE_OUT of REAnalysisModule
					value = re_out;
					
					% Set re_out to RE and memorize for GUI output of REAnalysisModule
					ream.memorize('REPF').set('RE', re_out)
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(ream, prop, varargin{:});
					else
						value = calculateValue@Element(ream, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(ream, prop, varargin)
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
				case 13 % REAnalysisModule.REPF
					pr = PanelPropItem('EL', ream, 'PROP', 13, ...
					    'WAITBAR', true, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Raman Experiment', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@ConcreteElement(ream, prop, varargin{:});
					
			end
		end
	end
end
