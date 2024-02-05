classdef BaselinedRamanGenerator < REAnalysisModule
	%BaselinedRamanGenerator is an REAnalysisModule that reads smooth Raman spectra and outputs baselines.
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Baselined Raman Generator Module (BaselinedRamanGenerator) is an REAnalysisModule
	% that reads the smooth Raman spectra (from SmoothingFilter) and evaluates 
	% the baselined Raman spectra (smooth spectra with baselines removed). 
	% It also provides basic functionalities to view and plot the baselined spectra.
	%
	% The list of BaselinedRamanGenerator properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Baselined Raman Generator.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Baselined Raman Generator.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Baselined Raman Generator.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Baselined Raman Generator.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Baselined Raman Generator.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Baselined Raman Generator.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Baselined Raman Generator.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baselined Raman Generator.
	%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
	%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
	%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
	%
	% BaselinedRamanGenerator methods (constructor):
	%  BaselinedRamanGenerator - constructor
	%
	% BaselinedRamanGenerator methods:
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
	% BaselinedRamanGenerator methods (display):
	%  tostring - string with information about the Baselined Raman Generator
	%  disp - displays information about the Baselined Raman Generator
	%  tree - displays the tree of the Baselined Raman Generator
	%
	% BaselinedRamanGenerator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Baselined Raman Generator are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Baselined Raman Generator
	%
	% BaselinedRamanGenerator methods (save/load, Static):
	%  save - saves BRAPH2 Baselined Raman Generator as b2 file
	%  load - loads a BRAPH2 Baselined Raman Generator from a b2 file
	%
	% BaselinedRamanGenerator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Baselined Raman Generator
	%
	% BaselinedRamanGenerator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Baselined Raman Generator
	%
	% BaselinedRamanGenerator methods (inspection, Static):
	%  getClass - returns the class of the Baselined Raman Generator
	%  getSubclasses - returns all subclasses of BaselinedRamanGenerator
	%  getProps - returns the property list of the Baselined Raman Generator
	%  getPropNumber - returns the property number of the Baselined Raman Generator
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
	% BaselinedRamanGenerator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BaselinedRamanGenerator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BaselinedRamanGenerator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BaselinedRamanGenerator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BaselinedRamanGenerator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BaselinedRamanGenerator constants</a>.
	%
	%
	% See also REAnalysisModule, CosmicRayNoiseRemover, SmoothingFilter, BaselineEstimator, RamanExperiment, Spectrum.
	
	methods % constructor
		function brgen = BaselinedRamanGenerator(varargin)
			%BaselinedRamanGenerator() creates a Baselined Raman Generator.
			%
			% BaselinedRamanGenerator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BaselinedRamanGenerator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BaselinedRamanGenerator properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Baselined Raman Generator.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Baselined Raman Generator.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Baselined Raman Generator.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Baselined Raman Generator.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Baselined Raman Generator.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Baselined Raman Generator.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Baselined Raman Generator.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baselined Raman Generator.
			%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
			%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
			%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
			%
			% See also Category, Format.
			
			brgen = brgen@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function brgen_class = getClass()
			%GETCLASS returns the class of the Baselined Raman Generator.
			%
			% CLASS = BaselinedRamanGenerator.GETCLASS() returns the class 'BaselinedRamanGenerator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BRGEN.GETCLASS() returns the class of the Baselined Raman Generator BRGEN.
			%  CLASS = Element.GETCLASS(BRGEN) returns the class of 'BRGEN'.
			%  CLASS = Element.GETCLASS('BaselinedRamanGenerator') returns 'BaselinedRamanGenerator'.
			%
			% Note that the Element.GETCLASS(BRGEN) and Element.GETCLASS('BaselinedRamanGenerator')
			%  are less computationally efficient.
			
			brgen_class = 'BaselinedRamanGenerator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Baselined Raman Generator.
			%
			% LIST = BaselinedRamanGenerator.GETSUBCLASSES() returns all subclasses of 'BaselinedRamanGenerator'.
			%
			% Alternative forms to call this method are:
			%  LIST = BRGEN.GETSUBCLASSES() returns all subclasses of the Baselined Raman Generator BRGEN.
			%  LIST = Element.GETSUBCLASSES(BRGEN) returns all subclasses of 'BRGEN'.
			%  LIST = Element.GETSUBCLASSES('BaselinedRamanGenerator') returns all subclasses of 'BaselinedRamanGenerator'.
			%
			% Note that the Element.GETSUBCLASSES(BRGEN) and Element.GETSUBCLASSES('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'BaselinedRamanGenerator' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Baselined Raman Generator.
			%
			% PROPS = BaselinedRamanGenerator.GETPROPS() returns the property list of Baselined Raman Generator
			%  as a row vector.
			%
			% PROPS = BaselinedRamanGenerator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BRGEN.GETPROPS([CATEGORY]) returns the property list of the Baselined Raman Generator BRGEN.
			%  PROPS = Element.GETPROPS(BRGEN[, CATEGORY]) returns the property list of 'BRGEN'.
			%  PROPS = Element.GETPROPS('BaselinedRamanGenerator'[, CATEGORY]) returns the property list of 'BaselinedRamanGenerator'.
			%
			% Note that the Element.GETPROPS(BRGEN) and Element.GETPROPS('BaselinedRamanGenerator')
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
			%GETPROPNUMBER returns the property number of Baselined Raman Generator.
			%
			% N = BaselinedRamanGenerator.GETPROPNUMBER() returns the property number of Baselined Raman Generator.
			%
			% N = BaselinedRamanGenerator.GETPROPNUMBER(CATEGORY) returns the property number of Baselined Raman Generator
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BRGEN.GETPROPNUMBER([CATEGORY]) returns the property number of the Baselined Raman Generator BRGEN.
			%  N = Element.GETPROPNUMBER(BRGEN) returns the property number of 'BRGEN'.
			%  N = Element.GETPROPNUMBER('BaselinedRamanGenerator') returns the property number of 'BaselinedRamanGenerator'.
			%
			% Note that the Element.GETPROPNUMBER(BRGEN) and Element.GETPROPNUMBER('BaselinedRamanGenerator')
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
			%EXISTSPROP checks whether property exists in Baselined Raman Generator/error.
			%
			% CHECK = BaselinedRamanGenerator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BRGEN.EXISTSPROP(PROP) checks whether PROP exists for BRGEN.
			%  CHECK = Element.EXISTSPROP(BRGEN, PROP) checks whether PROP exists for BRGEN.
			%  CHECK = Element.EXISTSPROP(BaselinedRamanGenerator, PROP) checks whether PROP exists for BaselinedRamanGenerator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BRGEN.EXISTSPROP(PROP) throws error if PROP does NOT exist for BRGEN.
			%   Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%  Element.EXISTSPROP(BRGEN, PROP) throws error if PROP does NOT exist for BRGEN.
			%   Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%  Element.EXISTSPROP(BaselinedRamanGenerator, PROP) throws error if PROP does NOT exist for BaselinedRamanGenerator.
			%   Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BRGEN) and Element.EXISTSPROP('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselinedRamanGenerator:' 'WrongInput'], ...
					['BRAPH2' ':BaselinedRamanGenerator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BaselinedRamanGenerator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Baselined Raman Generator/error.
			%
			% CHECK = BaselinedRamanGenerator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BRGEN.EXISTSTAG(TAG) checks whether TAG exists for BRGEN.
			%  CHECK = Element.EXISTSTAG(BRGEN, TAG) checks whether TAG exists for BRGEN.
			%  CHECK = Element.EXISTSTAG(BaselinedRamanGenerator, TAG) checks whether TAG exists for BaselinedRamanGenerator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BRGEN.EXISTSTAG(TAG) throws error if TAG does NOT exist for BRGEN.
			%   Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%  Element.EXISTSTAG(BRGEN, TAG) throws error if TAG does NOT exist for BRGEN.
			%   Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%  Element.EXISTSTAG(BaselinedRamanGenerator, TAG) throws error if TAG does NOT exist for BaselinedRamanGenerator.
			%   Error id: [BRAPH2:BaselinedRamanGenerator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BRGEN) and Element.EXISTSTAG('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselinedRamanGenerator:' 'WrongInput'], ...
					['BRAPH2' ':BaselinedRamanGenerator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for BaselinedRamanGenerator.'] ...
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
			%  PROPERTY = BRGEN.GETPROPPROP(POINTER) returns property number of POINTER of BRGEN.
			%  PROPERTY = Element.GETPROPPROP(BaselinedRamanGenerator, POINTER) returns property number of POINTER of BaselinedRamanGenerator.
			%  PROPERTY = BRGEN.GETPROPPROP(BaselinedRamanGenerator, POINTER) returns property number of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPPROP(BRGEN) and Element.GETPROPPROP('BaselinedRamanGenerator')
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
			%  TAG = BRGEN.GETPROPTAG(POINTER) returns tag of POINTER of BRGEN.
			%  TAG = Element.GETPROPTAG(BaselinedRamanGenerator, POINTER) returns tag of POINTER of BaselinedRamanGenerator.
			%  TAG = BRGEN.GETPROPTAG(BaselinedRamanGenerator, POINTER) returns tag of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPTAG(BRGEN) and Element.GETPROPTAG('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				baselinedramangenerator_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF' };
				tag = baselinedramangenerator_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = BRGEN.GETPROPCATEGORY(POINTER) returns category of POINTER of BRGEN.
			%  CATEGORY = Element.GETPROPCATEGORY(BaselinedRamanGenerator, POINTER) returns category of POINTER of BaselinedRamanGenerator.
			%  CATEGORY = BRGEN.GETPROPCATEGORY(BaselinedRamanGenerator, POINTER) returns category of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPCATEGORY(BRGEN) and Element.GETPROPCATEGORY('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BaselinedRamanGenerator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselinedramangenerator_category_list = { 1  1  1  3  4  2  2  6  4  6  5  5  9 };
			prop_category = baselinedramangenerator_category_list{prop};
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
			%  FORMAT = BRGEN.GETPROPFORMAT(POINTER) returns format of POINTER of BRGEN.
			%  FORMAT = Element.GETPROPFORMAT(BaselinedRamanGenerator, POINTER) returns format of POINTER of BaselinedRamanGenerator.
			%  FORMAT = BRGEN.GETPROPFORMAT(BaselinedRamanGenerator, POINTER) returns format of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPFORMAT(BRGEN) and Element.GETPROPFORMAT('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BaselinedRamanGenerator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselinedramangenerator_format_list = { 2  2  2  8  2  2  2  2  8  8  10  8  8 };
			prop_format = baselinedramangenerator_format_list{prop};
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
			%  DESCRIPTION = BRGEN.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BRGEN.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BaselinedRamanGenerator, POINTER) returns description of POINTER of BaselinedRamanGenerator.
			%  DESCRIPTION = BRGEN.GETPROPDESCRIPTION(BaselinedRamanGenerator, POINTER) returns description of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPDESCRIPTION(BRGEN) and Element.GETPROPDESCRIPTION('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BaselinedRamanGenerator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselinedramangenerator_description_list = { 'ELCLASS (constant, string) is the class of the Baselined Raman Generator.'  'NAME (constant, string) is the name of the Baselined Raman Generator.'  'DESCRIPTION (constant, string) is the description of Baselined Raman Generator.'  'TEMPLATE (parameter, item) is the template of the Baselined Raman Generator.'  'ID (data, string) is a few-letter code for the Baselined Raman Generator.'  'LABEL (metadata, string) is an extended label of the Baselined Raman Generator.'  'NOTES (metadata, string) are some specific notes about Baselined Raman Generator.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baselined Raman Generator.'  'SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. '  'RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the REAnalysisModule.' };
			prop_description = baselinedramangenerator_description_list{prop};
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
			%  SETTINGS = BRGEN.GETPROPSETTINGS(POINTER) returns settings of POINTER of BRGEN.
			%  SETTINGS = Element.GETPROPSETTINGS(BaselinedRamanGenerator, POINTER) returns settings of POINTER of BaselinedRamanGenerator.
			%  SETTINGS = BRGEN.GETPROPSETTINGS(BaselinedRamanGenerator, POINTER) returns settings of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPSETTINGS(BRGEN) and Element.GETPROPSETTINGS('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BaselinedRamanGenerator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % BaselinedRamanGenerator.TEMPLATE
					prop_settings = 'BaselinedRamanGenerator';
				case 10 % BaselinedRamanGenerator.SP_OUT
					prop_settings = 'Spectrum';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BaselinedRamanGenerator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BaselinedRamanGenerator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BRGEN.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BRGEN.
			%  DEFAULT = Element.GETPROPDEFAULT(BaselinedRamanGenerator, POINTER) returns the default value of POINTER of BaselinedRamanGenerator.
			%  DEFAULT = BRGEN.GETPROPDEFAULT(BaselinedRamanGenerator, POINTER) returns the default value of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPDEFAULT(BRGEN) and Element.GETPROPDEFAULT('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BaselinedRamanGenerator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % BaselinedRamanGenerator.ELCLASS
					prop_default = 'BaselinedRamanGenerator';
				case 2 % BaselinedRamanGenerator.NAME
					prop_default = 'BaselinedRamanGenerator';
				case 3 % BaselinedRamanGenerator.DESCRIPTION
					prop_default = 'BaselinedRamanGenerator reads and analyzes smooth Raman spectra and evaluates and plots the baselined Raman spectra.';
				case 4 % BaselinedRamanGenerator.TEMPLATE
					prop_default = Format.getFormatDefault(8, BaselinedRamanGenerator.getPropSettings(prop));
				case 5 % BaselinedRamanGenerator.ID
					prop_default = 'BaselinedRamanGenerator ID';
				case 6 % BaselinedRamanGenerator.LABEL
					prop_default = 'BaselinedRamanGenerator label';
				case 7 % BaselinedRamanGenerator.NOTES
					prop_default = 'BaselinedRamanGenerator notes';
				case 10 % BaselinedRamanGenerator.SP_OUT
					prop_default = Format.getFormatDefault(8, BaselinedRamanGenerator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BaselinedRamanGenerator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BaselinedRamanGenerator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BRGEN.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BRGEN.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BaselinedRamanGenerator, POINTER) returns the conditioned default value of POINTER of BaselinedRamanGenerator.
			%  DEFAULT = BRGEN.GETPROPDEFAULTCONDITIONED(BaselinedRamanGenerator, POINTER) returns the conditioned default value of POINTER of BaselinedRamanGenerator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BRGEN) and Element.GETPROPDEFAULTCONDITIONED('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BaselinedRamanGenerator.getPropProp(pointer);
			
			prop_default = BaselinedRamanGenerator.conditioning(prop, BaselinedRamanGenerator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BRGEN.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BRGEN.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BRGEN.
			%  CHECK = Element.CHECKPROP(BaselinedRamanGenerator, PROP, VALUE) checks VALUE format for PROP of BaselinedRamanGenerator.
			%  CHECK = BRGEN.CHECKPROP(BaselinedRamanGenerator, PROP, VALUE) checks VALUE format for PROP of BaselinedRamanGenerator.
			% 
			% BRGEN.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:BaselinedRamanGenerator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BRGEN.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BRGEN.
			%   Error id: BRAPH2:BaselinedRamanGenerator:WrongInput
			%  Element.CHECKPROP(BaselinedRamanGenerator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BaselinedRamanGenerator.
			%   Error id: BRAPH2:BaselinedRamanGenerator:WrongInput
			%  BRGEN.CHECKPROP(BaselinedRamanGenerator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BaselinedRamanGenerator.
			%   Error id: BRAPH2:BaselinedRamanGenerator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BRGEN) and Element.CHECKPROP('BaselinedRamanGenerator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BaselinedRamanGenerator.getPropProp(pointer);
			
			switch prop
				case 4 % BaselinedRamanGenerator.TEMPLATE
					check = Format.checkFormat(8, value, BaselinedRamanGenerator.getPropSettings(prop));
				case 10 % BaselinedRamanGenerator.SP_OUT
					check = Format.checkFormat(8, value, BaselinedRamanGenerator.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselinedRamanGenerator:' 'WrongInput'], ...
					['BRAPH2' ':BaselinedRamanGenerator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BaselinedRamanGenerator.getPropTag(prop) ' (' BaselinedRamanGenerator.getFormatTag(BaselinedRamanGenerator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(brgen, prop, varargin)
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
				case 10 % BaselinedRamanGenerator.SP_OUT
					rng_settings_ = rng(); rng(brgen.getPropSeed(10), 'twister')
					
					% sp_out = brgen.get('SP_OUT', SP_IN) returns the baselined intensities of 
					% the N-th spectrum in SP_DICT of RE_IN of BaselinedRamanGenerator. 
					if isempty(varargin)
					    value = Spectrum();
					    return
					end
					% Read the input spectrum
					sp_in = varargin{1};
					
					% Read the intensities of the smooth Raman spectrum
					% smooth intensities
					smooth_intensities = sp_in.get('INTENSITIES');
					
					% Baselined intensities using Lieberfit function
					% Set the order of the polynomial for Lieberfit function
					LFIT_POLYORDER = 5;
					% Set the number of odd points in the window for Lieberfit function
					LFIT_ITER = 100;
					% Apply Lieberfit function to smooth intensities from
					% SmoothingFilter
					[baselines, baselined_intensities] = lieberfit(smooth_intensities', ...
					                                               LFIT_POLYORDER, ...
					                                               LFIT_ITER); 
					
					% Create unlocked copy of the spectrum being processed
					% Set the baselined intensities to the INTENSITIES of the spectrum 
					sp_out = Spectrum(...
					         'INTENSITIES', baselined_intensities, ...
					         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
					         'ID', sp_in.get('ID'), ...
					         'LABEL', sp_in.get('LABEL'), ...
					         'NOTES', sp_in.get('NOTES'));
					
					% Set the updated sp_out to SP_OUT
					value = sp_out;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 13
						value = calculateValue@REAnalysisModule(brgen, prop, varargin{:});
					else
						value = calculateValue@Element(brgen, prop, varargin{:});
					end
			end
			
		end
	end
end
