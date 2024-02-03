classdef BaselineEstimator < REAnalysisModule
	%BaselineEstimator is an REAnalysisModule that reads smooth Raman spectra and outputs baselines.
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Baseline Estimator Module (BaselineEstimator) is an REAnalysisModule that 
	% reads the smooth Raman spectra (from SmoothingFilter) and evaluates 
	% the baselines. It also provides basic functionalities to view and 
	% plot the baselines.
	%
	% The list of BaselineEstimator properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Baseline Estimator.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Baseline Estimator.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Baseline Estimator.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Baseline Estimator.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Baseline Estimator.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Baseline Estimator.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Baseline Estimator.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>RE_OUT</strong> 	RE_OUT (query, item) is the output Raman Experiment with baselines as a result.
	%  <strong>11</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
	%
	% BaselineEstimator methods (constructor):
	%  BaselineEstimator - constructor
	%
	% BaselineEstimator methods:
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
	% BaselineEstimator methods (display):
	%  tostring - string with information about the Baseline Estimator
	%  disp - displays information about the Baseline Estimator
	%  tree - displays the tree of the Baseline Estimator
	%
	% BaselineEstimator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Baseline Estimator are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Baseline Estimator
	%
	% BaselineEstimator methods (save/load, Static):
	%  save - saves BRAPH2 Baseline Estimator as b2 file
	%  load - loads a BRAPH2 Baseline Estimator from a b2 file
	%
	% BaselineEstimator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Baseline Estimator
	%
	% BaselineEstimator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Baseline Estimator
	%
	% BaselineEstimator methods (inspection, Static):
	%  getClass - returns the class of the Baseline Estimator
	%  getSubclasses - returns all subclasses of BaselineEstimator
	%  getProps - returns the property list of the Baseline Estimator
	%  getPropNumber - returns the property number of the Baseline Estimator
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
	% BaselineEstimator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BaselineEstimator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BaselineEstimator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BaselineEstimator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BaselineEstimator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BaselineEstimator constants</a>.
	%
	%
	% See also REAnalysisModule, CosmicRayNoiseRemover, SmoothingFilter, RamanExperiment, Spectrum.
	
	methods % constructor
		function be = BaselineEstimator(varargin)
			%BaselineEstimator() creates a Baseline Estimator.
			%
			% BaselineEstimator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BaselineEstimator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BaselineEstimator properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Baseline Estimator.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Baseline Estimator.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Baseline Estimator.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Baseline Estimator.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Baseline Estimator.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Baseline Estimator.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Baseline Estimator.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>RE_OUT</strong> 	RE_OUT (query, item) is the output Raman Experiment with baselines as a result.
			%  <strong>11</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
			%
			% See also Category, Format.
			
			be = be@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function be_class = getClass()
			%GETCLASS returns the class of the Baseline Estimator.
			%
			% CLASS = BaselineEstimator.GETCLASS() returns the class 'BaselineEstimator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BE.GETCLASS() returns the class of the Baseline Estimator BE.
			%  CLASS = Element.GETCLASS(BE) returns the class of 'BE'.
			%  CLASS = Element.GETCLASS('BaselineEstimator') returns 'BaselineEstimator'.
			%
			% Note that the Element.GETCLASS(BE) and Element.GETCLASS('BaselineEstimator')
			%  are less computationally efficient.
			
			be_class = 'BaselineEstimator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Baseline Estimator.
			%
			% LIST = BaselineEstimator.GETSUBCLASSES() returns all subclasses of 'BaselineEstimator'.
			%
			% Alternative forms to call this method are:
			%  LIST = BE.GETSUBCLASSES() returns all subclasses of the Baseline Estimator BE.
			%  LIST = Element.GETSUBCLASSES(BE) returns all subclasses of 'BE'.
			%  LIST = Element.GETSUBCLASSES('BaselineEstimator') returns all subclasses of 'BaselineEstimator'.
			%
			% Note that the Element.GETSUBCLASSES(BE) and Element.GETSUBCLASSES('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'BaselineEstimator' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Baseline Estimator.
			%
			% PROPS = BaselineEstimator.GETPROPS() returns the property list of Baseline Estimator
			%  as a row vector.
			%
			% PROPS = BaselineEstimator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BE.GETPROPS([CATEGORY]) returns the property list of the Baseline Estimator BE.
			%  PROPS = Element.GETPROPS(BE[, CATEGORY]) returns the property list of 'BE'.
			%  PROPS = Element.GETPROPS('BaselineEstimator'[, CATEGORY]) returns the property list of 'BaselineEstimator'.
			%
			% Note that the Element.GETPROPS(BE) and Element.GETPROPS('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11];
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
				case 6 % Category.QUERY
					prop_list = [8 10];
				case 9 % Category.GUI
					prop_list = 11;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of Baseline Estimator.
			%
			% N = BaselineEstimator.GETPROPNUMBER() returns the property number of Baseline Estimator.
			%
			% N = BaselineEstimator.GETPROPNUMBER(CATEGORY) returns the property number of Baseline Estimator
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BE.GETPROPNUMBER([CATEGORY]) returns the property number of the Baseline Estimator BE.
			%  N = Element.GETPROPNUMBER(BE) returns the property number of 'BE'.
			%  N = Element.GETPROPNUMBER('BaselineEstimator') returns the property number of 'BaselineEstimator'.
			%
			% Note that the Element.GETPROPNUMBER(BE) and Element.GETPROPNUMBER('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 11;
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
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in Baseline Estimator/error.
			%
			% CHECK = BaselineEstimator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BE.EXISTSPROP(PROP) checks whether PROP exists for BE.
			%  CHECK = Element.EXISTSPROP(BE, PROP) checks whether PROP exists for BE.
			%  CHECK = Element.EXISTSPROP(BaselineEstimator, PROP) checks whether PROP exists for BaselineEstimator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BE.EXISTSPROP(PROP) throws error if PROP does NOT exist for BE.
			%   Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%  Element.EXISTSPROP(BE, PROP) throws error if PROP does NOT exist for BE.
			%   Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%  Element.EXISTSPROP(BaselineEstimator, PROP) throws error if PROP does NOT exist for BaselineEstimator.
			%   Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BE) and Element.EXISTSPROP('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselineEstimator:' 'WrongInput'], ...
					['BRAPH2' ':BaselineEstimator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BaselineEstimator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Baseline Estimator/error.
			%
			% CHECK = BaselineEstimator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BE.EXISTSTAG(TAG) checks whether TAG exists for BE.
			%  CHECK = Element.EXISTSTAG(BE, TAG) checks whether TAG exists for BE.
			%  CHECK = Element.EXISTSTAG(BaselineEstimator, TAG) checks whether TAG exists for BaselineEstimator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BE.EXISTSTAG(TAG) throws error if TAG does NOT exist for BE.
			%   Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%  Element.EXISTSTAG(BE, TAG) throws error if TAG does NOT exist for BE.
			%   Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%  Element.EXISTSTAG(BaselineEstimator, TAG) throws error if TAG does NOT exist for BaselineEstimator.
			%   Error id: [BRAPH2:BaselineEstimator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BE) and Element.EXISTSTAG('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT'  'REPF' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselineEstimator:' 'WrongInput'], ...
					['BRAPH2' ':BaselineEstimator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for BaselineEstimator.'] ...
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
			%  PROPERTY = BE.GETPROPPROP(POINTER) returns property number of POINTER of BE.
			%  PROPERTY = Element.GETPROPPROP(BaselineEstimator, POINTER) returns property number of POINTER of BaselineEstimator.
			%  PROPERTY = BE.GETPROPPROP(BaselineEstimator, POINTER) returns property number of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPPROP(BE) and Element.GETPROPPROP('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT'  'REPF' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = BE.GETPROPTAG(POINTER) returns tag of POINTER of BE.
			%  TAG = Element.GETPROPTAG(BaselineEstimator, POINTER) returns tag of POINTER of BaselineEstimator.
			%  TAG = BE.GETPROPTAG(BaselineEstimator, POINTER) returns tag of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPTAG(BE) and Element.GETPROPTAG('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				baselineestimator_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT'  'REPF' };
				tag = baselineestimator_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = BE.GETPROPCATEGORY(POINTER) returns category of POINTER of BE.
			%  CATEGORY = Element.GETPROPCATEGORY(BaselineEstimator, POINTER) returns category of POINTER of BaselineEstimator.
			%  CATEGORY = BE.GETPROPCATEGORY(BaselineEstimator, POINTER) returns category of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPCATEGORY(BE) and Element.GETPROPCATEGORY('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BaselineEstimator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselineestimator_category_list = { 1  1  1  3  4  2  2  6  4  6  9 };
			prop_category = baselineestimator_category_list{prop};
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
			%  FORMAT = BE.GETPROPFORMAT(POINTER) returns format of POINTER of BE.
			%  FORMAT = Element.GETPROPFORMAT(BaselineEstimator, POINTER) returns format of POINTER of BaselineEstimator.
			%  FORMAT = BE.GETPROPFORMAT(BaselineEstimator, POINTER) returns format of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPFORMAT(BE) and Element.GETPROPFORMAT('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BaselineEstimator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselineestimator_format_list = { 2  2  2  8  2  2  2  2  8  8  8 };
			prop_format = baselineestimator_format_list{prop};
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
			%  DESCRIPTION = BE.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BE.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BaselineEstimator, POINTER) returns description of POINTER of BaselineEstimator.
			%  DESCRIPTION = BE.GETPROPDESCRIPTION(BaselineEstimator, POINTER) returns description of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPDESCRIPTION(BE) and Element.GETPROPDESCRIPTION('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BaselineEstimator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselineestimator_description_list = { 'ELCLASS (constant, string) is the class of the Baseline Estimator.'  'NAME (constant, string) is the name of the Baseline Estimator.'  'DESCRIPTION (constant, string) is the description of Baseline Estimator.'  'TEMPLATE (parameter, item) is the template of the Baseline Estimator.'  'ID (data, string) is a few-letter code for the Baseline Estimator.'  'LABEL (metadata, string) is an extended label of the Baseline Estimator.'  'NOTES (metadata, string) are some specific notes about Baseline Estimator.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'RE_OUT (query, item) is the output Raman Experiment with baselines as a result.'  'REPF (gui, item) is a container of the panel figure for the REAnalysisModule.' };
			prop_description = baselineestimator_description_list{prop};
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
			%  SETTINGS = BE.GETPROPSETTINGS(POINTER) returns settings of POINTER of BE.
			%  SETTINGS = Element.GETPROPSETTINGS(BaselineEstimator, POINTER) returns settings of POINTER of BaselineEstimator.
			%  SETTINGS = BE.GETPROPSETTINGS(BaselineEstimator, POINTER) returns settings of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPSETTINGS(BE) and Element.GETPROPSETTINGS('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BaselineEstimator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % BaselineEstimator.TEMPLATE
					prop_settings = 'BaselineEstimator';
				case 10 % BaselineEstimator.RE_OUT
					prop_settings = 'RamanExperiment';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BaselineEstimator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BaselineEstimator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BE.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BE.
			%  DEFAULT = Element.GETPROPDEFAULT(BaselineEstimator, POINTER) returns the default value of POINTER of BaselineEstimator.
			%  DEFAULT = BE.GETPROPDEFAULT(BaselineEstimator, POINTER) returns the default value of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPDEFAULT(BE) and Element.GETPROPDEFAULT('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BaselineEstimator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % BaselineEstimator.ELCLASS
					prop_default = 'BaselineEstimator';
				case 2 % BaselineEstimator.NAME
					prop_default = 'BaselineEstimator';
				case 3 % BaselineEstimator.DESCRIPTION
					prop_default = 'BaselineEstimator reads and analyzes smooth Raman spectra and evaluates and plots the baselines.';
				case 4 % BaselineEstimator.TEMPLATE
					prop_default = Format.getFormatDefault(8, BaselineEstimator.getPropSettings(prop));
				case 5 % BaselineEstimator.ID
					prop_default = 'BaselineEstimator ID';
				case 6 % BaselineEstimator.LABEL
					prop_default = 'BaselineEstimator label';
				case 7 % BaselineEstimator.NOTES
					prop_default = 'BaselineEstimator notes';
				case 10 % BaselineEstimator.RE_OUT
					prop_default = Format.getFormatDefault(8, BaselineEstimator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BaselineEstimator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BaselineEstimator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BE.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BE.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BaselineEstimator, POINTER) returns the conditioned default value of POINTER of BaselineEstimator.
			%  DEFAULT = BE.GETPROPDEFAULTCONDITIONED(BaselineEstimator, POINTER) returns the conditioned default value of POINTER of BaselineEstimator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BE) and Element.GETPROPDEFAULTCONDITIONED('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BaselineEstimator.getPropProp(pointer);
			
			prop_default = BaselineEstimator.conditioning(prop, BaselineEstimator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BE.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BE.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BE.
			%  CHECK = Element.CHECKPROP(BaselineEstimator, PROP, VALUE) checks VALUE format for PROP of BaselineEstimator.
			%  CHECK = BE.CHECKPROP(BaselineEstimator, PROP, VALUE) checks VALUE format for PROP of BaselineEstimator.
			% 
			% BE.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:BaselineEstimator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BE.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BE.
			%   Error id: BRAPH2:BaselineEstimator:WrongInput
			%  Element.CHECKPROP(BaselineEstimator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BaselineEstimator.
			%   Error id: BRAPH2:BaselineEstimator:WrongInput
			%  BE.CHECKPROP(BaselineEstimator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BaselineEstimator.
			%   Error id: BRAPH2:BaselineEstimator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BE) and Element.CHECKPROP('BaselineEstimator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BaselineEstimator.getPropProp(pointer);
			
			switch prop
				case 4 % BaselineEstimator.TEMPLATE
					check = Format.checkFormat(8, value, BaselineEstimator.getPropSettings(prop));
				case 10 % BaselineEstimator.RE_OUT
					check = Format.checkFormat(8, value, BaselineEstimator.getPropSettings(prop));
				otherwise
					if prop <= 11
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselineEstimator:' 'WrongInput'], ...
					['BRAPH2' ':BaselineEstimator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BaselineEstimator.getPropTag(prop) ' (' BaselineEstimator.getFormatTag(BaselineEstimator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(be, prop, varargin)
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
				case 10 % BaselineEstimator.RE_OUT
					% calculateValue using REAnalysisModule with parameters be and 'RE_OUT'; 
					% returns the query, which is assigned to the variable re_out
					re_out = calculateValue@REAnalysisModule(be, prop);
					
					% Create a copy of REAnalysisModule 'RE_OUT' 
					be_re_out = re_out;
					
					% Get the 'RE_OUT' from SmoothingFilter
					% 1. Pass 'RE_OUT' of REAnalysisModule to 'RE_IN' of CosmicRayNoiseRemover
					% 2. Pass 'RE_OUT' of CosmicRayNoiseRemover to 'RE_IN' of SmoothingFilter
					% 3. Read 'RE_OUT' of SmoothingFilter   
					crnr = CosmicRayNoiseRemover('RE_IN', re_out)
					sf = SmoothingFilter('RE_IN', crnr.get('RE_OUT'))
					sf_re_out = sf.get('RE_OUT')
					
					% Get the number of items in the indexed dictionary SP_DICT of
					% SmoothingFilter 'RE_OUT'
					dict_length = sf_re_out.get('SP_DICT').get('LENGTH')
					
					for n = 1:1:dict_length
					     % Read smooth intensities from the SmoothingFilter 'RE_OUT'
					     smooth_intensities = sf_re_out.get('SP_DICT').get('IT', n).get('INTENSITIES');
					
					     % Baseline estimation using Lieberfit function
					     % Set the order of the polynomial for Lieberfit function
					     LFIT_POLYORDER = 5;
					     % Set the number of odd points in the window for Lieberfit function
					     LFIT_ITER = 100;
					     % Apply Lieberfit function to smooth intensities from
					     % SmoothingFilter
					     [baselines, baselined_intensities] = ...
					         lieberfit(smooth_intensities', LFIT_POLYORDER, LFIT_ITER);
					
					     % Set the intensities of the nth spectrum in the 'SP_DICT' of be_re_out 
					     % to baselines evaluated using the nth smooth spectrum of 
					     % SmoothingFilter
					     be_re_out.get('SP_DICT').get('IT', n).set('INTENSITIES', baselines)
					end
					
					% Memorize the updated 'SP_DICT' of BaselineEstimator
					be_re_out.memorize('SP_DICT');
					
					% Set the be_re_out to 'RE_OUT' of BaselineEstimator
					value = be_re_out;
					
				otherwise
					if prop <= 11
						value = calculateValue@REAnalysisModule(be, prop, varargin{:});
					else
						value = calculateValue@Element(be, prop, varargin{:});
					end
			end
			
		end
	end
end
