classdef SmoothingFilter < REAnalysisModule
	%SmoothingFilter is an REAnalysisModule that reads fixed Raman spectra (with cosmic ray noise removed) and outputs smooth spectra.
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Smoothing Filter Module (SmoothingFilter) is an REAnalysisModule that 
	% reads the fixed Raman spectra (with cosmic ray noise removed) and evaluates 
	% the smooth spectra. It also provides basic functionalities to view and 
	% plot the smooth spectra.
	%
	% The list of SmoothingFilter properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Smoothing Filter.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Smoothing Filter.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Smoothing Filter.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Smoothing Filter.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Smoothing Filter.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Smoothing Filter.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Smoothing Filter.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothing Filter.
	%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
	%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
	%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
	%
	% SmoothingFilter methods (constructor):
	%  SmoothingFilter - constructor
	%
	% SmoothingFilter methods:
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
	% SmoothingFilter methods (display):
	%  tostring - string with information about the Smoothing Filter
	%  disp - displays information about the Smoothing Filter
	%  tree - displays the tree of the Smoothing Filter
	%
	% SmoothingFilter methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Smoothing Filter are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Smoothing Filter
	%
	% SmoothingFilter methods (save/load, Static):
	%  save - saves BRAPH2 Smoothing Filter as b2 file
	%  load - loads a BRAPH2 Smoothing Filter from a b2 file
	%
	% SmoothingFilter method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Smoothing Filter
	%
	% SmoothingFilter method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Smoothing Filter
	%
	% SmoothingFilter methods (inspection, Static):
	%  getClass - returns the class of the Smoothing Filter
	%  getSubclasses - returns all subclasses of SmoothingFilter
	%  getProps - returns the property list of the Smoothing Filter
	%  getPropNumber - returns the property number of the Smoothing Filter
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
	% SmoothingFilter methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SmoothingFilter methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SmoothingFilter methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SmoothingFilter methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SmoothingFilter; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SmoothingFilter constants</a>.
	%
	%
	% See also REAnalysisModule, RamanExperiment, Spectrum.
	
	methods % constructor
		function sf = SmoothingFilter(varargin)
			%SmoothingFilter() creates a Smoothing Filter.
			%
			% SmoothingFilter(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SmoothingFilter(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SmoothingFilter properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Smoothing Filter.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Smoothing Filter.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Smoothing Filter.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Smoothing Filter.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Smoothing Filter.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Smoothing Filter.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Smoothing Filter.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothing Filter.
			%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
			%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
			%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
			%
			% See also Category, Format.
			
			sf = sf@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function sf_class = getClass()
			%GETCLASS returns the class of the Smoothing Filter.
			%
			% CLASS = SmoothingFilter.GETCLASS() returns the class 'SmoothingFilter'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SF.GETCLASS() returns the class of the Smoothing Filter SF.
			%  CLASS = Element.GETCLASS(SF) returns the class of 'SF'.
			%  CLASS = Element.GETCLASS('SmoothingFilter') returns 'SmoothingFilter'.
			%
			% Note that the Element.GETCLASS(SF) and Element.GETCLASS('SmoothingFilter')
			%  are less computationally efficient.
			
			sf_class = 'SmoothingFilter';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Smoothing Filter.
			%
			% LIST = SmoothingFilter.GETSUBCLASSES() returns all subclasses of 'SmoothingFilter'.
			%
			% Alternative forms to call this method are:
			%  LIST = SF.GETSUBCLASSES() returns all subclasses of the Smoothing Filter SF.
			%  LIST = Element.GETSUBCLASSES(SF) returns all subclasses of 'SF'.
			%  LIST = Element.GETSUBCLASSES('SmoothingFilter') returns all subclasses of 'SmoothingFilter'.
			%
			% Note that the Element.GETSUBCLASSES(SF) and Element.GETSUBCLASSES('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SmoothingFilter' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Smoothing Filter.
			%
			% PROPS = SmoothingFilter.GETPROPS() returns the property list of Smoothing Filter
			%  as a row vector.
			%
			% PROPS = SmoothingFilter.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SF.GETPROPS([CATEGORY]) returns the property list of the Smoothing Filter SF.
			%  PROPS = Element.GETPROPS(SF[, CATEGORY]) returns the property list of 'SF'.
			%  PROPS = Element.GETPROPS('SmoothingFilter'[, CATEGORY]) returns the property list of 'SmoothingFilter'.
			%
			% Note that the Element.GETPROPS(SF) and Element.GETPROPS('SmoothingFilter')
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
			%GETPROPNUMBER returns the property number of Smoothing Filter.
			%
			% N = SmoothingFilter.GETPROPNUMBER() returns the property number of Smoothing Filter.
			%
			% N = SmoothingFilter.GETPROPNUMBER(CATEGORY) returns the property number of Smoothing Filter
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SF.GETPROPNUMBER([CATEGORY]) returns the property number of the Smoothing Filter SF.
			%  N = Element.GETPROPNUMBER(SF) returns the property number of 'SF'.
			%  N = Element.GETPROPNUMBER('SmoothingFilter') returns the property number of 'SmoothingFilter'.
			%
			% Note that the Element.GETPROPNUMBER(SF) and Element.GETPROPNUMBER('SmoothingFilter')
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
			%EXISTSPROP checks whether property exists in Smoothing Filter/error.
			%
			% CHECK = SmoothingFilter.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SF.EXISTSPROP(PROP) checks whether PROP exists for SF.
			%  CHECK = Element.EXISTSPROP(SF, PROP) checks whether PROP exists for SF.
			%  CHECK = Element.EXISTSPROP(SmoothingFilter, PROP) checks whether PROP exists for SmoothingFilter.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SF.EXISTSPROP(PROP) throws error if PROP does NOT exist for SF.
			%   Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%  Element.EXISTSPROP(SF, PROP) throws error if PROP does NOT exist for SF.
			%   Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%  Element.EXISTSPROP(SmoothingFilter, PROP) throws error if PROP does NOT exist for SmoothingFilter.
			%   Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SF) and Element.EXISTSPROP('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 13 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SmoothingFilter:' 'WrongInput'], ...
					['BRAPH2' ':SmoothingFilter:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SmoothingFilter.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Smoothing Filter/error.
			%
			% CHECK = SmoothingFilter.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SF.EXISTSTAG(TAG) checks whether TAG exists for SF.
			%  CHECK = Element.EXISTSTAG(SF, TAG) checks whether TAG exists for SF.
			%  CHECK = Element.EXISTSTAG(SmoothingFilter, TAG) checks whether TAG exists for SmoothingFilter.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SF.EXISTSTAG(TAG) throws error if TAG does NOT exist for SF.
			%   Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%  Element.EXISTSTAG(SF, TAG) throws error if TAG does NOT exist for SF.
			%   Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%  Element.EXISTSTAG(SmoothingFilter, TAG) throws error if TAG does NOT exist for SmoothingFilter.
			%   Error id: [BRAPH2:SmoothingFilter:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SF) and Element.EXISTSTAG('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SmoothingFilter:' 'WrongInput'], ...
					['BRAPH2' ':SmoothingFilter:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SmoothingFilter.'] ...
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
			%  PROPERTY = SF.GETPROPPROP(POINTER) returns property number of POINTER of SF.
			%  PROPERTY = Element.GETPROPPROP(SmoothingFilter, POINTER) returns property number of POINTER of SmoothingFilter.
			%  PROPERTY = SF.GETPROPPROP(SmoothingFilter, POINTER) returns property number of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPPROP(SF) and Element.GETPROPPROP('SmoothingFilter')
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
			%  TAG = SF.GETPROPTAG(POINTER) returns tag of POINTER of SF.
			%  TAG = Element.GETPROPTAG(SmoothingFilter, POINTER) returns tag of POINTER of SmoothingFilter.
			%  TAG = SF.GETPROPTAG(SmoothingFilter, POINTER) returns tag of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPTAG(SF) and Element.GETPROPTAG('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				smoothingfilter_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF' };
				tag = smoothingfilter_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = SF.GETPROPCATEGORY(POINTER) returns category of POINTER of SF.
			%  CATEGORY = Element.GETPROPCATEGORY(SmoothingFilter, POINTER) returns category of POINTER of SmoothingFilter.
			%  CATEGORY = SF.GETPROPCATEGORY(SmoothingFilter, POINTER) returns category of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPCATEGORY(SF) and Element.GETPROPCATEGORY('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SmoothingFilter.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smoothingfilter_category_list = { 1  1  1  3  4  2  2  6  4  6  5  5  9 };
			prop_category = smoothingfilter_category_list{prop};
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
			%  FORMAT = SF.GETPROPFORMAT(POINTER) returns format of POINTER of SF.
			%  FORMAT = Element.GETPROPFORMAT(SmoothingFilter, POINTER) returns format of POINTER of SmoothingFilter.
			%  FORMAT = SF.GETPROPFORMAT(SmoothingFilter, POINTER) returns format of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPFORMAT(SF) and Element.GETPROPFORMAT('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SmoothingFilter.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smoothingfilter_format_list = { 2  2  2  8  2  2  2  2  8  8  10  8  8 };
			prop_format = smoothingfilter_format_list{prop};
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
			%  DESCRIPTION = SF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SmoothingFilter, POINTER) returns description of POINTER of SmoothingFilter.
			%  DESCRIPTION = SF.GETPROPDESCRIPTION(SmoothingFilter, POINTER) returns description of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPDESCRIPTION(SF) and Element.GETPROPDESCRIPTION('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SmoothingFilter.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smoothingfilter_description_list = { 'ELCLASS (constant, string) is the class of the Smoothing Filter.'  'NAME (constant, string) is the name of the Smoothing Filter.'  'DESCRIPTION (constant, string) is the description of Smoothing Filter.'  'TEMPLATE (parameter, item) is the template of the Smoothing Filter.'  'ID (data, string) is a few-letter code for the Smoothing Filter.'  'LABEL (metadata, string) is an extended label of the Smoothing Filter.'  'NOTES (metadata, string) are some specific notes about Smoothing Filter.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothing Filter.'  'SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. '  'RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the REAnalysisModule.' };
			prop_description = smoothingfilter_description_list{prop};
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
			%  SETTINGS = SF.GETPROPSETTINGS(POINTER) returns settings of POINTER of SF.
			%  SETTINGS = Element.GETPROPSETTINGS(SmoothingFilter, POINTER) returns settings of POINTER of SmoothingFilter.
			%  SETTINGS = SF.GETPROPSETTINGS(SmoothingFilter, POINTER) returns settings of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPSETTINGS(SF) and Element.GETPROPSETTINGS('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SmoothingFilter.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % SmoothingFilter.TEMPLATE
					prop_settings = 'SmoothingFilter';
				case 10 % SmoothingFilter.SP_OUT
					prop_settings = 'Spectrum';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SmoothingFilter.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SmoothingFilter.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SF.
			%  DEFAULT = Element.GETPROPDEFAULT(SmoothingFilter, POINTER) returns the default value of POINTER of SmoothingFilter.
			%  DEFAULT = SF.GETPROPDEFAULT(SmoothingFilter, POINTER) returns the default value of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPDEFAULT(SF) and Element.GETPROPDEFAULT('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SmoothingFilter.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % SmoothingFilter.ELCLASS
					prop_default = 'SmoothingFilter';
				case 2 % SmoothingFilter.NAME
					prop_default = 'SmoothingFilter';
				case 3 % SmoothingFilter.DESCRIPTION
					prop_default = 'SmoothingFilter reads and analyzes fixed Raman spectra and evaluates and plots the resulting smooth spectra.';
				case 4 % SmoothingFilter.TEMPLATE
					prop_default = Format.getFormatDefault(8, SmoothingFilter.getPropSettings(prop));
				case 5 % SmoothingFilter.ID
					prop_default = 'SmoothingFilter ID';
				case 6 % SmoothingFilter.LABEL
					prop_default = 'SmoothingFilter label';
				case 7 % SmoothingFilter.NOTES
					prop_default = 'SmoothingFilter notes';
				case 10 % SmoothingFilter.SP_OUT
					prop_default = Format.getFormatDefault(8, SmoothingFilter.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SmoothingFilter.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SmoothingFilter.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SmoothingFilter, POINTER) returns the conditioned default value of POINTER of SmoothingFilter.
			%  DEFAULT = SF.GETPROPDEFAULTCONDITIONED(SmoothingFilter, POINTER) returns the conditioned default value of POINTER of SmoothingFilter.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SF) and Element.GETPROPDEFAULTCONDITIONED('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SmoothingFilter.getPropProp(pointer);
			
			prop_default = SmoothingFilter.conditioning(prop, SmoothingFilter.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SF.
			%  CHECK = Element.CHECKPROP(SmoothingFilter, PROP, VALUE) checks VALUE format for PROP of SmoothingFilter.
			%  CHECK = SF.CHECKPROP(SmoothingFilter, PROP, VALUE) checks VALUE format for PROP of SmoothingFilter.
			% 
			% SF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SmoothingFilter:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SF.
			%   Error id: BRAPH2:SmoothingFilter:WrongInput
			%  Element.CHECKPROP(SmoothingFilter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SmoothingFilter.
			%   Error id: BRAPH2:SmoothingFilter:WrongInput
			%  SF.CHECKPROP(SmoothingFilter, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SmoothingFilter.
			%   Error id: BRAPH2:SmoothingFilter:WrongInput]
			% 
			% Note that the Element.CHECKPROP(SF) and Element.CHECKPROP('SmoothingFilter')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SmoothingFilter.getPropProp(pointer);
			
			switch prop
				case 4 % SmoothingFilter.TEMPLATE
					check = Format.checkFormat(8, value, SmoothingFilter.getPropSettings(prop));
				case 10 % SmoothingFilter.SP_OUT
					check = Format.checkFormat(8, value, SmoothingFilter.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SmoothingFilter:' 'WrongInput'], ...
					['BRAPH2' ':SmoothingFilter:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SmoothingFilter.getPropTag(prop) ' (' SmoothingFilter.getFormatTag(SmoothingFilter.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(sf, prop, varargin)
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
				case 10 % SmoothingFilter.SP_OUT
					rng_settings_ = rng(); rng(sf.getPropSeed(10), 'twister')
					
					% sp_out = sf.get('SP_OUT', SP_IN) returns the smooth N-th spectrum
					% in SP_DICT of RE_IN of SmoothingFilter. 
					if isempty(varargin)
					    value = Spectrum();
					    return
					end
					% Read the input spectrum
					sp_in = varargin{1};
					
					% Read the intensities of the raw Raman spectrum
					% raw intensities
					fixed_intensities = sp_in.get('INTENSITIES');
					
					% Apply Savitzky-Golay smoothing to fixed intensities
					% Set the order of the polynomial for Savitzky-Golay smoothing
					SGOLAY_POLYORDER = 3;
					% Consider odd number of points in the window for Savitzky-Golay smoothing
					SGOLAY_WINDOW = 9;
					% Apply Savitzky-Golay filter to fixed intensities from
					% CosmicRayNoiseRemover
					smooth_intensities = sgolayfilt(fixed_intensities, ...
					                                SGOLAY_POLYORDER, ... 
					                                SGOLAY_WINDOW);  
					
					% Create unlocked copy of the spectrum being processed
					% Set the smooth intensities to the INTENSITIES of the spectrum 
					sp_out = Spectrum(...
					         'INTENSITIES', smooth_intensities, ...
					         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
					         'ID', sp_in.get('ID'), ...
					         'LABEL', sp_in.get('LABEL'), ...
					         'NOTES', sp_in.get('NOTES'));
					
					% Set the updated sp_out to SP_OUT
					value = sp_out;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 13
						value = calculateValue@REAnalysisModule(sf, prop, varargin{:});
					else
						value = calculateValue@Element(sf, prop, varargin{:});
					end
			end
			
		end
	end
end
