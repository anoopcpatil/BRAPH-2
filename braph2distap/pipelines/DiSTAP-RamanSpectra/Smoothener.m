classdef Smoothener < REAnalysisModule
	%Smoothener is an REAnalysisModule that reads fixed Raman spectra (with cosmic ray noise removed) and outputs smooth spectra.
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Smoothener Module (Smoothener) is an REAnalysisModule that 
	% reads the fixed Raman spectra (with cosmic ray noise removed) and evaluates 
	% the smooth spectra. It also provides basic functionalities to view and 
	% plot the smooth spectra.
	%
	% The list of Smoothener properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Smoothener.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Smoothener.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Smoothener.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Smoothener.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Smoothener.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Smoothener.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Smoothener.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothener.
	%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
	%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
	%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the Smoothener.
	%  <strong>14</strong> <strong>SGOLAY_POLYORDER</strong> 	SGOLAY_POLYORDER (parameter, scalar) is the order of the polynomial for Savitzky-Golay smoothing.
	%  <strong>15</strong> <strong>SGOLAY_WINDOW</strong> 	SGOLAY_WINDOW (parameter, scalar) is odd number of points in the window for Savitzky-Golay smoothing.
	%
	% Smoothener methods (constructor):
	%  Smoothener - constructor
	%
	% Smoothener methods:
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
	% Smoothener methods (display):
	%  tostring - string with information about the Smoothener
	%  disp - displays information about the Smoothener
	%  tree - displays the tree of the Smoothener
	%
	% Smoothener methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Smoothener are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Smoothener
	%
	% Smoothener methods (save/load, Static):
	%  save - saves BRAPH2 Smoothener as b2 file
	%  load - loads a BRAPH2 Smoothener from a b2 file
	%
	% Smoothener method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Smoothener
	%
	% Smoothener method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Smoothener
	%
	% Smoothener methods (inspection, Static):
	%  getClass - returns the class of the Smoothener
	%  getSubclasses - returns all subclasses of Smoothener
	%  getProps - returns the property list of the Smoothener
	%  getPropNumber - returns the property number of the Smoothener
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
	% Smoothener methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Smoothener methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Smoothener methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Smoothener methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Smoothener; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Smoothener constants</a>.
	%
	%
	% See also REAnalysisModule, RamanExperiment, Spectrum.
	
	properties (Constant) % properties
		SGOLAY_POLYORDER = 14; %CET: Computational Efficiency Trick
		SGOLAY_POLYORDER_TAG = 'SGOLAY_POLYORDER';
		SGOLAY_POLYORDER_CATEGORY = 3;
		SGOLAY_POLYORDER_FORMAT = 11;
		
		SGOLAY_WINDOW = 15; %CET: Computational Efficiency Trick
		SGOLAY_WINDOW_TAG = 'SGOLAY_WINDOW';
		SGOLAY_WINDOW_CATEGORY = 3;
		SGOLAY_WINDOW_FORMAT = 11;
	end
	methods % constructor
		function sm = Smoothener(varargin)
			%Smoothener() creates a Smoothener.
			%
			% Smoothener(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Smoothener(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Smoothener properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Smoothener.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Smoothener.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Smoothener.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Smoothener.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Smoothener.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Smoothener.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Smoothener.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothener.
			%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
			%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
			%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the Smoothener.
			%  <strong>14</strong> <strong>SGOLAY_POLYORDER</strong> 	SGOLAY_POLYORDER (parameter, scalar) is the order of the polynomial for Savitzky-Golay smoothing.
			%  <strong>15</strong> <strong>SGOLAY_WINDOW</strong> 	SGOLAY_WINDOW (parameter, scalar) is odd number of points in the window for Savitzky-Golay smoothing.
			%
			% See also Category, Format.
			
			sm = sm@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function sm_class = getClass()
			%GETCLASS returns the class of the Smoothener.
			%
			% CLASS = Smoothener.GETCLASS() returns the class 'Smoothener'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SM.GETCLASS() returns the class of the Smoothener SM.
			%  CLASS = Element.GETCLASS(SM) returns the class of 'SM'.
			%  CLASS = Element.GETCLASS('Smoothener') returns 'Smoothener'.
			%
			% Note that the Element.GETCLASS(SM) and Element.GETCLASS('Smoothener')
			%  are less computationally efficient.
			
			sm_class = 'Smoothener';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Smoothener.
			%
			% LIST = Smoothener.GETSUBCLASSES() returns all subclasses of 'Smoothener'.
			%
			% Alternative forms to call this method are:
			%  LIST = SM.GETSUBCLASSES() returns all subclasses of the Smoothener SM.
			%  LIST = Element.GETSUBCLASSES(SM) returns all subclasses of 'SM'.
			%  LIST = Element.GETSUBCLASSES('Smoothener') returns all subclasses of 'Smoothener'.
			%
			% Note that the Element.GETSUBCLASSES(SM) and Element.GETSUBCLASSES('Smoothener')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Smoothener' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Smoothener.
			%
			% PROPS = Smoothener.GETPROPS() returns the property list of Smoothener
			%  as a row vector.
			%
			% PROPS = Smoothener.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SM.GETPROPS([CATEGORY]) returns the property list of the Smoothener SM.
			%  PROPS = Element.GETPROPS(SM[, CATEGORY]) returns the property list of 'SM'.
			%  PROPS = Element.GETPROPS('Smoothener'[, CATEGORY]) returns the property list of 'Smoothener'.
			%
			% Note that the Element.GETPROPS(SM) and Element.GETPROPS('Smoothener')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 14 15];
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
			%GETPROPNUMBER returns the property number of Smoothener.
			%
			% N = Smoothener.GETPROPNUMBER() returns the property number of Smoothener.
			%
			% N = Smoothener.GETPROPNUMBER(CATEGORY) returns the property number of Smoothener
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SM.GETPROPNUMBER([CATEGORY]) returns the property number of the Smoothener SM.
			%  N = Element.GETPROPNUMBER(SM) returns the property number of 'SM'.
			%  N = Element.GETPROPNUMBER('Smoothener') returns the property number of 'Smoothener'.
			%
			% Note that the Element.GETPROPNUMBER(SM) and Element.GETPROPNUMBER('Smoothener')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 15;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 3;
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
			%EXISTSPROP checks whether property exists in Smoothener/error.
			%
			% CHECK = Smoothener.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SM.EXISTSPROP(PROP) checks whether PROP exists for SM.
			%  CHECK = Element.EXISTSPROP(SM, PROP) checks whether PROP exists for SM.
			%  CHECK = Element.EXISTSPROP(Smoothener, PROP) checks whether PROP exists for Smoothener.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Smoothener:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SM.EXISTSPROP(PROP) throws error if PROP does NOT exist for SM.
			%   Error id: [BRAPH2:Smoothener:WrongInput]
			%  Element.EXISTSPROP(SM, PROP) throws error if PROP does NOT exist for SM.
			%   Error id: [BRAPH2:Smoothener:WrongInput]
			%  Element.EXISTSPROP(Smoothener, PROP) throws error if PROP does NOT exist for Smoothener.
			%   Error id: [BRAPH2:Smoothener:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SM) and Element.EXISTSPROP('Smoothener')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Smoothener:' 'WrongInput'], ...
					['BRAPH2' ':Smoothener:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Smoothener.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Smoothener/error.
			%
			% CHECK = Smoothener.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SM.EXISTSTAG(TAG) checks whether TAG exists for SM.
			%  CHECK = Element.EXISTSTAG(SM, TAG) checks whether TAG exists for SM.
			%  CHECK = Element.EXISTSTAG(Smoothener, TAG) checks whether TAG exists for Smoothener.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Smoothener:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SM.EXISTSTAG(TAG) throws error if TAG does NOT exist for SM.
			%   Error id: [BRAPH2:Smoothener:WrongInput]
			%  Element.EXISTSTAG(SM, TAG) throws error if TAG does NOT exist for SM.
			%   Error id: [BRAPH2:Smoothener:WrongInput]
			%  Element.EXISTSTAG(Smoothener, TAG) throws error if TAG does NOT exist for Smoothener.
			%   Error id: [BRAPH2:Smoothener:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SM) and Element.EXISTSTAG('Smoothener')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'SGOLAY_POLYORDER'  'SGOLAY_WINDOW' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Smoothener:' 'WrongInput'], ...
					['BRAPH2' ':Smoothener:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Smoothener.'] ...
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
			%  PROPERTY = SM.GETPROPPROP(POINTER) returns property number of POINTER of SM.
			%  PROPERTY = Element.GETPROPPROP(Smoothener, POINTER) returns property number of POINTER of Smoothener.
			%  PROPERTY = SM.GETPROPPROP(Smoothener, POINTER) returns property number of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPPROP(SM) and Element.GETPROPPROP('Smoothener')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'SGOLAY_POLYORDER'  'SGOLAY_WINDOW' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = SM.GETPROPTAG(POINTER) returns tag of POINTER of SM.
			%  TAG = Element.GETPROPTAG(Smoothener, POINTER) returns tag of POINTER of Smoothener.
			%  TAG = SM.GETPROPTAG(Smoothener, POINTER) returns tag of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPTAG(SM) and Element.GETPROPTAG('Smoothener')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				smoothener_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'SGOLAY_POLYORDER'  'SGOLAY_WINDOW' };
				tag = smoothener_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = SM.GETPROPCATEGORY(POINTER) returns category of POINTER of SM.
			%  CATEGORY = Element.GETPROPCATEGORY(Smoothener, POINTER) returns category of POINTER of Smoothener.
			%  CATEGORY = SM.GETPROPCATEGORY(Smoothener, POINTER) returns category of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPCATEGORY(SM) and Element.GETPROPCATEGORY('Smoothener')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Smoothener.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smoothener_category_list = { 1  1  1  3  4  2  2  6  4  6  5  5  9  3  3 };
			prop_category = smoothener_category_list{prop};
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
			%  FORMAT = SM.GETPROPFORMAT(POINTER) returns format of POINTER of SM.
			%  FORMAT = Element.GETPROPFORMAT(Smoothener, POINTER) returns format of POINTER of Smoothener.
			%  FORMAT = SM.GETPROPFORMAT(Smoothener, POINTER) returns format of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPFORMAT(SM) and Element.GETPROPFORMAT('Smoothener')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Smoothener.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smoothener_format_list = { 2  2  2  8  2  2  2  2  8  8  10  8  8  11  11 };
			prop_format = smoothener_format_list{prop};
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
			%  DESCRIPTION = SM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Smoothener, POINTER) returns description of POINTER of Smoothener.
			%  DESCRIPTION = SM.GETPROPDESCRIPTION(Smoothener, POINTER) returns description of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPDESCRIPTION(SM) and Element.GETPROPDESCRIPTION('Smoothener')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Smoothener.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			smoothener_description_list = { 'ELCLASS (constant, string) is the class of the Smoothener.'  'NAME (constant, string) is the name of the Smoothener.'  'DESCRIPTION (constant, string) is the description of Smoothener.'  'TEMPLATE (parameter, item) is the template of the Smoothener.'  'ID (data, string) is a few-letter code for the Smoothener.'  'LABEL (metadata, string) is an extended label of the Smoothener.'  'NOTES (metadata, string) are some specific notes about Smoothener.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothener.'  'SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. '  'RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the Smoothener.'  'SGOLAY_POLYORDER (parameter, scalar) is the order of the polynomial for Savitzky-Golay smoothing.'  'SGOLAY_WINDOW (parameter, scalar) is odd number of points in the window for Savitzky-Golay smoothing.' };
			prop_description = smoothener_description_list{prop};
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
			%  SETTINGS = SM.GETPROPSETTINGS(POINTER) returns settings of POINTER of SM.
			%  SETTINGS = Element.GETPROPSETTINGS(Smoothener, POINTER) returns settings of POINTER of Smoothener.
			%  SETTINGS = SM.GETPROPSETTINGS(Smoothener, POINTER) returns settings of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPSETTINGS(SM) and Element.GETPROPSETTINGS('Smoothener')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Smoothener.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % Smoothener.SGOLAY_POLYORDER
					prop_settings = Format.getFormatSettings(11);
				case 15 % Smoothener.SGOLAY_WINDOW
					prop_settings = Format.getFormatSettings(11);
				case 4 % Smoothener.TEMPLATE
					prop_settings = 'Smoothener';
				case 10 % Smoothener.SP_OUT
					prop_settings = 'Spectrum';
				case 13 % Smoothener.REPF
					prop_settings = 'RamanExperimentPF';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Smoothener.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Smoothener.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SM.
			%  DEFAULT = Element.GETPROPDEFAULT(Smoothener, POINTER) returns the default value of POINTER of Smoothener.
			%  DEFAULT = SM.GETPROPDEFAULT(Smoothener, POINTER) returns the default value of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPDEFAULT(SM) and Element.GETPROPDEFAULT('Smoothener')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Smoothener.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % Smoothener.SGOLAY_POLYORDER
					prop_default = 3;
				case 15 % Smoothener.SGOLAY_WINDOW
					prop_default = 9;
				case 1 % Smoothener.ELCLASS
					prop_default = 'Smoothener';
				case 2 % Smoothener.NAME
					prop_default = 'Smoothener';
				case 3 % Smoothener.DESCRIPTION
					prop_default = 'Smoothener reads and analyzes fixed Raman spectra and evaluates and plots the resulting smooth spectra.';
				case 4 % Smoothener.TEMPLATE
					prop_default = Format.getFormatDefault(8, Smoothener.getPropSettings(prop));
				case 5 % Smoothener.ID
					prop_default = 'Smoothener ID';
				case 6 % Smoothener.LABEL
					prop_default = 'Smoothener label';
				case 7 % Smoothener.NOTES
					prop_default = 'Smoothener notes';
				case 10 % Smoothener.SP_OUT
					prop_default = Format.getFormatDefault(8, Smoothener.getPropSettings(prop));
				case 13 % Smoothener.REPF
					prop_default = Format.getFormatDefault(8, Smoothener.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Smoothener.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Smoothener.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Smoothener, POINTER) returns the conditioned default value of POINTER of Smoothener.
			%  DEFAULT = SM.GETPROPDEFAULTCONDITIONED(Smoothener, POINTER) returns the conditioned default value of POINTER of Smoothener.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SM) and Element.GETPROPDEFAULTCONDITIONED('Smoothener')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Smoothener.getPropProp(pointer);
			
			prop_default = Smoothener.conditioning(prop, Smoothener.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SM.
			%  CHECK = Element.CHECKPROP(Smoothener, PROP, VALUE) checks VALUE format for PROP of Smoothener.
			%  CHECK = SM.CHECKPROP(Smoothener, PROP, VALUE) checks VALUE format for PROP of Smoothener.
			% 
			% SM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Smoothener:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SM.
			%   Error id: BRAPH2:Smoothener:WrongInput
			%  Element.CHECKPROP(Smoothener, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Smoothener.
			%   Error id: BRAPH2:Smoothener:WrongInput
			%  SM.CHECKPROP(Smoothener, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Smoothener.
			%   Error id: BRAPH2:Smoothener:WrongInput]
			% 
			% Note that the Element.CHECKPROP(SM) and Element.CHECKPROP('Smoothener')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Smoothener.getPropProp(pointer);
			
			switch prop
				case 14 % Smoothener.SGOLAY_POLYORDER
					check = Format.checkFormat(11, value, Smoothener.getPropSettings(prop));
				case 15 % Smoothener.SGOLAY_WINDOW
					check = Format.checkFormat(11, value, Smoothener.getPropSettings(prop));
				case 4 % Smoothener.TEMPLATE
					check = Format.checkFormat(8, value, Smoothener.getPropSettings(prop));
				case 10 % Smoothener.SP_OUT
					check = Format.checkFormat(8, value, Smoothener.getPropSettings(prop));
				case 13 % Smoothener.REPF
					check = Format.checkFormat(8, value, Smoothener.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Smoothener:' 'WrongInput'], ...
					['BRAPH2' ':Smoothener:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Smoothener.getPropTag(prop) ' (' Smoothener.getFormatTag(Smoothener.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(sm, prop, varargin)
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
				case 10 % Smoothener.SP_OUT
					rng_settings_ = rng(); rng(sm.getPropSeed(10), 'twister')
					
					% sp_out = sm.get('SP_OUT', SP_IN) returns the smooth N-th spectrum
					% in SP_DICT of RE_IN of Smoothener. 
					if isempty(varargin)
					    value = Spectrum();
					    return
					end
					% Read the input spectrum
					sp_in = varargin{1};
					
					% Read the intensities of the raw Raman spectrum
					% raw intensities
					fixed_intensities = sp_in.get('INTENSITIES');
					
					% % Apply Savitzky-Golay smoothing to fixed intensities
					% % Set the order of the polynomial for Savitzky-Golay smoothing
					% SGOLAY_POLYORDER = 3;
					% % Consider odd number of points in the window for Savitzky-Golay smoothing
					% SGOLAY_WINDOW = 9;
					% Apply Savitzky-Golay filter to fixed intensities from
					% CosmicRayNoiseRemover
					smooth_intensities = sgolayfilt(fixed_intensities, ...
					                                sm.get('SGOLAY_POLYORDER'), ... 
					                                sm.get('SGOLAY_WINDOW'));  
					
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
						value = calculateValue@REAnalysisModule(sm, prop, varargin{:});
					else
						value = calculateValue@Element(sm, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(sm, prop, varargin)
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
				case 3 % Smoothener.DESCRIPTION
					pr = PanelPropStringTextArea('EL', sm, 'PROP', sm.DESCRIPTION, varargin{:});
					
				case 13 % Smoothener.REPF
					pr = PanelPropItem('EL', sm, 'PROP', 13, ...
					    'WAITBAR', true, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Smoothened spectra', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@REAnalysisModule(sm, prop, varargin{:});
					
			end
		end
	end
end
