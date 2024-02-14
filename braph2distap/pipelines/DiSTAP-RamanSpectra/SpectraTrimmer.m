classdef SpectraTrimmer < REAnalysisModule
	%SpectraTrimmer is an REAnalysisModule that reads and trims the raw Raman spectra.
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Spectra Trimmer Module (SpectraTrimmer) is an REAnalysisModule that 
	% reads and trims the raw Raman spectra. This is used in all the instances 
	% of REAnalysisModule.
	%
	% The list of SpectraTrimmer properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Spectra Trimmer.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Spectra Trimmer.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Spectra Trimmer.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Spectra Trimmer.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Spectra Trimmer.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Spectra Trimmer.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Spectra Trimmer.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the trimmed spectrum for SP_DICT_OUT and RE_OUT of SpectraTrimmer.
	%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
	%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
	%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the SpectraTrimmer.
	%  <strong>14</strong> <strong>START_WAVELENGTH</strong> 	START_WAVELENGTH (parameter, scalar) is the wavelength below which the spectral portion is removed.
	%  <strong>15</strong> <strong>STOP_WAVELENGTH</strong> 	STOP_WAVELENGTH (parameter, scalar) is wavelength above which the spectral portion is removed.
	%
	% SpectraTrimmer methods (constructor):
	%  SpectraTrimmer - constructor
	%
	% SpectraTrimmer methods:
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
	% SpectraTrimmer methods (display):
	%  tostring - string with information about the Spectra Trimmer
	%  disp - displays information about the Spectra Trimmer
	%  tree - displays the tree of the Spectra Trimmer
	%
	% SpectraTrimmer methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Spectra Trimmer are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Spectra Trimmer
	%
	% SpectraTrimmer methods (save/load, Static):
	%  save - saves BRAPH2 Spectra Trimmer as b2 file
	%  load - loads a BRAPH2 Spectra Trimmer from a b2 file
	%
	% SpectraTrimmer method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Spectra Trimmer
	%
	% SpectraTrimmer method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Spectra Trimmer
	%
	% SpectraTrimmer methods (inspection, Static):
	%  getClass - returns the class of the Spectra Trimmer
	%  getSubclasses - returns all subclasses of SpectraTrimmer
	%  getProps - returns the property list of the Spectra Trimmer
	%  getPropNumber - returns the property number of the Spectra Trimmer
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
	% SpectraTrimmer methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% SpectraTrimmer methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% SpectraTrimmer methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% SpectraTrimmer methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?SpectraTrimmer; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">SpectraTrimmer constants</a>.
	%
	%
	% See also REAnalysisModule, RamanExperiment, Spectrum.
	
	properties (Constant) % properties
		START_WAVELENGTH = 14; %CET: Computational Efficiency Trick
		START_WAVELENGTH_TAG = 'START_WAVELENGTH';
		START_WAVELENGTH_CATEGORY = 3;
		START_WAVELENGTH_FORMAT = 11;
		
		STOP_WAVELENGTH = 15; %CET: Computational Efficiency Trick
		STOP_WAVELENGTH_TAG = 'STOP_WAVELENGTH';
		STOP_WAVELENGTH_CATEGORY = 3;
		STOP_WAVELENGTH_FORMAT = 11;
	end
	methods % constructor
		function st = SpectraTrimmer(varargin)
			%SpectraTrimmer() creates a Spectra Trimmer.
			%
			% SpectraTrimmer(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% SpectraTrimmer(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of SpectraTrimmer properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Spectra Trimmer.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Spectra Trimmer.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Spectra Trimmer.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Spectra Trimmer.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Spectra Trimmer.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Spectra Trimmer.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Spectra Trimmer.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the trimmed spectrum for SP_DICT_OUT and RE_OUT of SpectraTrimmer.
			%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
			%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
			%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the SpectraTrimmer.
			%  <strong>14</strong> <strong>START_WAVELENGTH</strong> 	START_WAVELENGTH (parameter, scalar) is the wavelength below which the spectral portion is removed.
			%  <strong>15</strong> <strong>STOP_WAVELENGTH</strong> 	STOP_WAVELENGTH (parameter, scalar) is wavelength above which the spectral portion is removed.
			%
			% See also Category, Format.
			
			st = st@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function st_class = getClass()
			%GETCLASS returns the class of the Spectra Trimmer.
			%
			% CLASS = SpectraTrimmer.GETCLASS() returns the class 'SpectraTrimmer'.
			%
			% Alternative forms to call this method are:
			%  CLASS = ST.GETCLASS() returns the class of the Spectra Trimmer ST.
			%  CLASS = Element.GETCLASS(ST) returns the class of 'ST'.
			%  CLASS = Element.GETCLASS('SpectraTrimmer') returns 'SpectraTrimmer'.
			%
			% Note that the Element.GETCLASS(ST) and Element.GETCLASS('SpectraTrimmer')
			%  are less computationally efficient.
			
			st_class = 'SpectraTrimmer';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Spectra Trimmer.
			%
			% LIST = SpectraTrimmer.GETSUBCLASSES() returns all subclasses of 'SpectraTrimmer'.
			%
			% Alternative forms to call this method are:
			%  LIST = ST.GETSUBCLASSES() returns all subclasses of the Spectra Trimmer ST.
			%  LIST = Element.GETSUBCLASSES(ST) returns all subclasses of 'ST'.
			%  LIST = Element.GETSUBCLASSES('SpectraTrimmer') returns all subclasses of 'SpectraTrimmer'.
			%
			% Note that the Element.GETSUBCLASSES(ST) and Element.GETSUBCLASSES('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'SpectraTrimmer' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Spectra Trimmer.
			%
			% PROPS = SpectraTrimmer.GETPROPS() returns the property list of Spectra Trimmer
			%  as a row vector.
			%
			% PROPS = SpectraTrimmer.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = ST.GETPROPS([CATEGORY]) returns the property list of the Spectra Trimmer ST.
			%  PROPS = Element.GETPROPS(ST[, CATEGORY]) returns the property list of 'ST'.
			%  PROPS = Element.GETPROPS('SpectraTrimmer'[, CATEGORY]) returns the property list of 'SpectraTrimmer'.
			%
			% Note that the Element.GETPROPS(ST) and Element.GETPROPS('SpectraTrimmer')
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
			%GETPROPNUMBER returns the property number of Spectra Trimmer.
			%
			% N = SpectraTrimmer.GETPROPNUMBER() returns the property number of Spectra Trimmer.
			%
			% N = SpectraTrimmer.GETPROPNUMBER(CATEGORY) returns the property number of Spectra Trimmer
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = ST.GETPROPNUMBER([CATEGORY]) returns the property number of the Spectra Trimmer ST.
			%  N = Element.GETPROPNUMBER(ST) returns the property number of 'ST'.
			%  N = Element.GETPROPNUMBER('SpectraTrimmer') returns the property number of 'SpectraTrimmer'.
			%
			% Note that the Element.GETPROPNUMBER(ST) and Element.GETPROPNUMBER('SpectraTrimmer')
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
			%EXISTSPROP checks whether property exists in Spectra Trimmer/error.
			%
			% CHECK = SpectraTrimmer.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSPROP(PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(ST, PROP) checks whether PROP exists for ST.
			%  CHECK = Element.EXISTSPROP(SpectraTrimmer, PROP) checks whether PROP exists for SpectraTrimmer.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSPROP(PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%  Element.EXISTSPROP(ST, PROP) throws error if PROP does NOT exist for ST.
			%   Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%  Element.EXISTSPROP(SpectraTrimmer, PROP) throws error if PROP does NOT exist for SpectraTrimmer.
			%   Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%
			% Note that the Element.EXISTSPROP(ST) and Element.EXISTSPROP('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SpectraTrimmer:' 'WrongInput'], ...
					['BRAPH2' ':SpectraTrimmer:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for SpectraTrimmer.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Spectra Trimmer/error.
			%
			% CHECK = SpectraTrimmer.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = ST.EXISTSTAG(TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(ST, TAG) checks whether TAG exists for ST.
			%  CHECK = Element.EXISTSTAG(SpectraTrimmer, TAG) checks whether TAG exists for SpectraTrimmer.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%
			% Alternative forms to call this method are:
			%  ST.EXISTSTAG(TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%  Element.EXISTSTAG(ST, TAG) throws error if TAG does NOT exist for ST.
			%   Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%  Element.EXISTSTAG(SpectraTrimmer, TAG) throws error if TAG does NOT exist for SpectraTrimmer.
			%   Error id: [BRAPH2:SpectraTrimmer:WrongInput]
			%
			% Note that the Element.EXISTSTAG(ST) and Element.EXISTSTAG('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'START_WAVELENGTH'  'STOP_WAVELENGTH' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SpectraTrimmer:' 'WrongInput'], ...
					['BRAPH2' ':SpectraTrimmer:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for SpectraTrimmer.'] ...
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
			%  PROPERTY = ST.GETPROPPROP(POINTER) returns property number of POINTER of ST.
			%  PROPERTY = Element.GETPROPPROP(SpectraTrimmer, POINTER) returns property number of POINTER of SpectraTrimmer.
			%  PROPERTY = ST.GETPROPPROP(SpectraTrimmer, POINTER) returns property number of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPPROP(ST) and Element.GETPROPPROP('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'START_WAVELENGTH'  'STOP_WAVELENGTH' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = ST.GETPROPTAG(POINTER) returns tag of POINTER of ST.
			%  TAG = Element.GETPROPTAG(SpectraTrimmer, POINTER) returns tag of POINTER of SpectraTrimmer.
			%  TAG = ST.GETPROPTAG(SpectraTrimmer, POINTER) returns tag of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPTAG(ST) and Element.GETPROPTAG('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				spectratrimmer_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'START_WAVELENGTH'  'STOP_WAVELENGTH' };
				tag = spectratrimmer_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = ST.GETPROPCATEGORY(POINTER) returns category of POINTER of ST.
			%  CATEGORY = Element.GETPROPCATEGORY(SpectraTrimmer, POINTER) returns category of POINTER of SpectraTrimmer.
			%  CATEGORY = ST.GETPROPCATEGORY(SpectraTrimmer, POINTER) returns category of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPCATEGORY(ST) and Element.GETPROPCATEGORY('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = SpectraTrimmer.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			spectratrimmer_category_list = { 1  1  1  3  4  2  2  6  4  6  5  5  9  3  3 };
			prop_category = spectratrimmer_category_list{prop};
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
			%  FORMAT = ST.GETPROPFORMAT(POINTER) returns format of POINTER of ST.
			%  FORMAT = Element.GETPROPFORMAT(SpectraTrimmer, POINTER) returns format of POINTER of SpectraTrimmer.
			%  FORMAT = ST.GETPROPFORMAT(SpectraTrimmer, POINTER) returns format of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPFORMAT(ST) and Element.GETPROPFORMAT('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = SpectraTrimmer.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			spectratrimmer_format_list = { 2  2  2  8  2  2  2  2  8  8  10  8  8  11  11 };
			prop_format = spectratrimmer_format_list{prop};
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
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(POINTER) returns description of POINTER of ST.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(SpectraTrimmer, POINTER) returns description of POINTER of SpectraTrimmer.
			%  DESCRIPTION = ST.GETPROPDESCRIPTION(SpectraTrimmer, POINTER) returns description of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPDESCRIPTION(ST) and Element.GETPROPDESCRIPTION('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = SpectraTrimmer.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			spectratrimmer_description_list = { 'ELCLASS (constant, string) is the class of the Spectra Trimmer.'  'NAME (constant, string) is the name of the Spectra Trimmer.'  'DESCRIPTION (constant, string) is the description of Spectra Trimmer.'  'TEMPLATE (parameter, item) is the template of the Spectra Trimmer.'  'ID (data, string) is a few-letter code for the Spectra Trimmer.'  'LABEL (metadata, string) is an extended label of the Spectra Trimmer.'  'NOTES (metadata, string) are some specific notes about Spectra Trimmer.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'SP_OUT (result, item) is the trimmed spectrum for SP_DICT_OUT and RE_OUT of SpectraTrimmer.'  'SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. '  'RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the SpectraTrimmer.'  'START_WAVELENGTH (parameter, scalar) is the wavelength below which the spectral portion is removed.'  'STOP_WAVELENGTH (parameter, scalar) is wavelength above which the spectral portion is removed.' };
			prop_description = spectratrimmer_description_list{prop};
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
			%  SETTINGS = ST.GETPROPSETTINGS(POINTER) returns settings of POINTER of ST.
			%  SETTINGS = Element.GETPROPSETTINGS(SpectraTrimmer, POINTER) returns settings of POINTER of SpectraTrimmer.
			%  SETTINGS = ST.GETPROPSETTINGS(SpectraTrimmer, POINTER) returns settings of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPSETTINGS(ST) and Element.GETPROPSETTINGS('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = SpectraTrimmer.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % SpectraTrimmer.START_WAVELENGTH
					prop_settings = Format.getFormatSettings(11);
				case 15 % SpectraTrimmer.STOP_WAVELENGTH
					prop_settings = Format.getFormatSettings(11);
				case 4 % SpectraTrimmer.TEMPLATE
					prop_settings = 'SpectraTrimmer';
				case 10 % SpectraTrimmer.SP_OUT
					prop_settings = 'Spectrum';
				case 13 % SpectraTrimmer.REPF
					prop_settings = 'RamanExperimentPF';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = SpectraTrimmer.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = SpectraTrimmer.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULT(POINTER) returns the default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULT(SpectraTrimmer, POINTER) returns the default value of POINTER of SpectraTrimmer.
			%  DEFAULT = ST.GETPROPDEFAULT(SpectraTrimmer, POINTER) returns the default value of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPDEFAULT(ST) and Element.GETPROPDEFAULT('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = SpectraTrimmer.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % SpectraTrimmer.START_WAVELENGTH
					prop_default = 400;
				case 15 % SpectraTrimmer.STOP_WAVELENGTH
					prop_default = 1750;
				case 1 % SpectraTrimmer.ELCLASS
					prop_default = 'SpectraTrimmer';
				case 2 % SpectraTrimmer.NAME
					prop_default = 'SpectraTrimmer';
				case 3 % SpectraTrimmer.DESCRIPTION
					prop_default = 'SpectraTrimmer reads reads and trims the raw Raman spectra for further pre-processing.';
				case 4 % SpectraTrimmer.TEMPLATE
					prop_default = Format.getFormatDefault(8, SpectraTrimmer.getPropSettings(prop));
				case 5 % SpectraTrimmer.ID
					prop_default = 'SpectraTrimmer ID';
				case 6 % SpectraTrimmer.LABEL
					prop_default = 'SpectraTrimmer label';
				case 7 % SpectraTrimmer.NOTES
					prop_default = 'SpectraTrimmer notes';
				case 10 % SpectraTrimmer.SP_OUT
					prop_default = Format.getFormatDefault(8, SpectraTrimmer.getPropSettings(prop));
				case 13 % SpectraTrimmer.REPF
					prop_default = Format.getFormatDefault(8, SpectraTrimmer.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = SpectraTrimmer.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = SpectraTrimmer.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of ST.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(SpectraTrimmer, POINTER) returns the conditioned default value of POINTER of SpectraTrimmer.
			%  DEFAULT = ST.GETPROPDEFAULTCONDITIONED(SpectraTrimmer, POINTER) returns the conditioned default value of POINTER of SpectraTrimmer.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(ST) and Element.GETPROPDEFAULTCONDITIONED('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = SpectraTrimmer.getPropProp(pointer);
			
			prop_default = SpectraTrimmer.conditioning(prop, SpectraTrimmer.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = ST.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = ST.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of ST.
			%  CHECK = Element.CHECKPROP(SpectraTrimmer, PROP, VALUE) checks VALUE format for PROP of SpectraTrimmer.
			%  CHECK = ST.CHECKPROP(SpectraTrimmer, PROP, VALUE) checks VALUE format for PROP of SpectraTrimmer.
			% 
			% ST.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:SpectraTrimmer:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  ST.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of ST.
			%   Error id: BRAPH2:SpectraTrimmer:WrongInput
			%  Element.CHECKPROP(SpectraTrimmer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SpectraTrimmer.
			%   Error id: BRAPH2:SpectraTrimmer:WrongInput
			%  ST.CHECKPROP(SpectraTrimmer, PROP, VALUE) throws error if VALUE has not a valid format for PROP of SpectraTrimmer.
			%   Error id: BRAPH2:SpectraTrimmer:WrongInput]
			% 
			% Note that the Element.CHECKPROP(ST) and Element.CHECKPROP('SpectraTrimmer')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = SpectraTrimmer.getPropProp(pointer);
			
			switch prop
				case 14 % SpectraTrimmer.START_WAVELENGTH
					check = Format.checkFormat(11, value, SpectraTrimmer.getPropSettings(prop));
				case 15 % SpectraTrimmer.STOP_WAVELENGTH
					check = Format.checkFormat(11, value, SpectraTrimmer.getPropSettings(prop));
				case 4 % SpectraTrimmer.TEMPLATE
					check = Format.checkFormat(8, value, SpectraTrimmer.getPropSettings(prop));
				case 10 % SpectraTrimmer.SP_OUT
					check = Format.checkFormat(8, value, SpectraTrimmer.getPropSettings(prop));
				case 13 % SpectraTrimmer.REPF
					check = Format.checkFormat(8, value, SpectraTrimmer.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':SpectraTrimmer:' 'WrongInput'], ...
					['BRAPH2' ':SpectraTrimmer:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' SpectraTrimmer.getPropTag(prop) ' (' SpectraTrimmer.getFormatTag(SpectraTrimmer.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(st, prop, varargin)
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
				case 10 % SpectraTrimmer.SP_OUT
					rng_settings_ = rng(); rng(st.getPropSeed(10), 'twister')
					
					% sp_out = st.get('SP_OUT', SP_IN) returns the trimmed N-th spectrum
					% in SP_DICT of RE_IN of SpectraTrimmer. 
					if isempty(varargin)
					    value = Spectrum();
					    return
					end
					% Read the input spectrum
					sp_in = varargin{1};
					
					% Read the raw Raman spectra
					% raw wavelengths
					raw_wavelengths = sp_in.get('WAVELENGTH');
					% raw intensities
					raw_intensities = sp_in.get('INTENSITIES');
					
					
					% Apply trimming to the wavelengths and intensities
					trimmed_rows = (find(raw_wavelengths(:,1) > st.get('START_WAVELENGTH') & raw_wavelengths(:,1) < st.get('STOP_WAVELENGTH')));
					trimmed_wavelengths = raw_wavelengths(trimmed_rows,:);
					trimmed_intensities = raw_intensities(trimmed_rows,:);
					
					% Create unlocked copy of the spectrum being processed
					% Set the trimmed wavelengths and intensities to the 
					% WAVELENGTH and INTENSITIES of the spectrum 
					sp_out = Spectrum(...
					         'INTENSITIES', trimmed_intensities, ...
					         'WAVELENGTH', trimmed_wavelengths, ...
					         'ID', sp_in.get('ID'), ...
					         'LABEL', sp_in.get('LABEL'), ...
					         'NOTES', sp_in.get('NOTES'));
					
					% Set the updated sp_out to SP_OUT
					value = sp_out;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 13
						value = calculateValue@REAnalysisModule(st, prop, varargin{:});
					else
						value = calculateValue@Element(st, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(st, prop, varargin)
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
				case 3 % SpectraTrimmer.DESCRIPTION
					pr = PanelPropStringTextArea('EL', st, 'PROP', st.DESCRIPTION, varargin{:});
					
				case 13 % SpectraTrimmer.REPF
					pr = PanelPropItem('EL', st, 'PROP', 13, ...
					    'WAITBAR', true, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot trimmed spectra', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@REAnalysisModule(st, prop, varargin{:});
					
			end
		end
	end
end
