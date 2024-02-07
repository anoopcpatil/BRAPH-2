classdef ImporterRamanExperiment_B2 < Importer
	%ImporterRamanExperiment_B2 imports a Raman experiment from a .
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% Raman experiment importer from B2 file (ImporterRamanExperiment_B2) imports a set of Raman spectra acquired in a Raman Experiment stored in a B2 file.
	%
	% The list of ImporterRamanExperiment_B2 properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the importer of Raman experiment from B2.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the importer of Raman experiment from B2.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the importer of Raman experiment from B2.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importer of Raman experiment from B2.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the importer of Raman experiment from B2.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the importer of Raman experiment from B2.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the importer of Raman experiment from B2.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the loaded B2 file.
	%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to get the B2 file from which the Raman Experiment can be loaded.
	%  <strong>12</strong> <strong>RE</strong> 	RE (result, item) is a Raman Experiment.
	%
	% ImporterRamanExperiment_B2 methods (constructor):
	%  ImporterRamanExperiment_B2 - constructor
	%
	% ImporterRamanExperiment_B2 methods:
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
	% ImporterRamanExperiment_B2 methods (display):
	%  tostring - string with information about the importer of Raman experiment from B2
	%  disp - displays information about the importer of Raman experiment from B2
	%  tree - displays the tree of the importer of Raman experiment from B2
	%
	% ImporterRamanExperiment_B2 methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of Raman experiment from B2 are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of Raman experiment from B2
	%
	% ImporterRamanExperiment_B2 methods (save/load, Static):
	%  save - saves BRAPH2 importer of Raman experiment from B2 as b2 file
	%  load - loads a BRAPH2 importer of Raman experiment from B2 from a b2 file
	%
	% ImporterRamanExperiment_B2 method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of Raman experiment from B2
	%
	% ImporterRamanExperiment_B2 method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of Raman experiment from B2
	%
	% ImporterRamanExperiment_B2 methods (inspection, Static):
	%  getClass - returns the class of the importer of Raman experiment from B2
	%  getSubclasses - returns all subclasses of ImporterRamanExperiment_B2
	%  getProps - returns the property list of the importer of Raman experiment from B2
	%  getPropNumber - returns the property number of the importer of Raman experiment from B2
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
	% ImporterRamanExperiment_B2 methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterRamanExperiment_B2 methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterRamanExperiment_B2 methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterRamanExperiment_B2 methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterRamanExperiment_B2; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterRamanExperiment_B2 constants</a>.
	%
	%
	% See also RamanExperiment, Spectrum.
	
	properties (Constant) % properties
		FILE = 10; %CET: Computational Efficiency Trick
		FILE_TAG = 'FILE';
		FILE_CATEGORY = 4;
		FILE_FORMAT = 2;
		
		GET_FILE = 11; %CET: Computational Efficiency Trick
		GET_FILE_TAG = 'GET_FILE';
		GET_FILE_CATEGORY = 6;
		GET_FILE_FORMAT = 8;
		
		RE = 12; %CET: Computational Efficiency Trick
		RE_TAG = 'RE';
		RE_CATEGORY = 5;
		RE_FORMAT = 8;
	end
	methods % constructor
		function im = ImporterRamanExperiment_B2(varargin)
			%ImporterRamanExperiment_B2() creates a importer of Raman experiment from B2.
			%
			% ImporterRamanExperiment_B2(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterRamanExperiment_B2(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterRamanExperiment_B2 properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the importer of Raman experiment from B2.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the importer of Raman experiment from B2.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the importer of Raman experiment from B2.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importer of Raman experiment from B2.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the importer of Raman experiment from B2.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the importer of Raman experiment from B2.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the importer of Raman experiment from B2.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>FILE</strong> 	FILE (data, string) is the loaded B2 file.
			%  <strong>11</strong> <strong>GET_FILE</strong> 	GET_FILE (query, item) opens a dialog box to get the B2 file from which the Raman Experiment can be loaded.
			%  <strong>12</strong> <strong>RE</strong> 	RE (result, item) is a Raman Experiment.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function im_class = getClass()
			%GETCLASS returns the class of the importer of Raman experiment from B2.
			%
			% CLASS = ImporterRamanExperiment_B2.GETCLASS() returns the class 'ImporterRamanExperiment_B2'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of Raman experiment from B2 IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterRamanExperiment_B2') returns 'ImporterRamanExperiment_B2'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			
			im_class = 'ImporterRamanExperiment_B2';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of Raman experiment from B2.
			%
			% LIST = ImporterRamanExperiment_B2.GETSUBCLASSES() returns all subclasses of 'ImporterRamanExperiment_B2'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of Raman experiment from B2 IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterRamanExperiment_B2') returns all subclasses of 'ImporterRamanExperiment_B2'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterRamanExperiment_B2' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of Raman experiment from B2.
			%
			% PROPS = ImporterRamanExperiment_B2.GETPROPS() returns the property list of importer of Raman experiment from B2
			%  as a row vector.
			%
			% PROPS = ImporterRamanExperiment_B2.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of Raman experiment from B2 IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterRamanExperiment_B2'[, CATEGORY]) returns the property list of 'ImporterRamanExperiment_B2'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12];
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
					prop_list = [5 10];
				case 5 % Category.RESULT
					prop_list = 12;
				case 6 % Category.QUERY
					prop_list = [8 11];
				case 9 % Category.GUI
					prop_list = 9;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of importer of Raman experiment from B2.
			%
			% N = ImporterRamanExperiment_B2.GETPROPNUMBER() returns the property number of importer of Raman experiment from B2.
			%
			% N = ImporterRamanExperiment_B2.GETPROPNUMBER(CATEGORY) returns the property number of importer of Raman experiment from B2
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of Raman experiment from B2 IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterRamanExperiment_B2') returns the property number of 'ImporterRamanExperiment_B2'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 12;
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
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in importer of Raman experiment from B2/error.
			%
			% CHECK = ImporterRamanExperiment_B2.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterRamanExperiment_B2, PROP) checks whether PROP exists for ImporterRamanExperiment_B2.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%  Element.EXISTSPROP(ImporterRamanExperiment_B2, PROP) throws error if PROP does NOT exist for ImporterRamanExperiment_B2.
			%   Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterRamanExperiment_B2:' 'WrongInput'], ...
					['BRAPH2' ':ImporterRamanExperiment_B2:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterRamanExperiment_B2.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of Raman experiment from B2/error.
			%
			% CHECK = ImporterRamanExperiment_B2.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterRamanExperiment_B2, TAG) checks whether TAG exists for ImporterRamanExperiment_B2.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%  Element.EXISTSTAG(ImporterRamanExperiment_B2, TAG) throws error if TAG does NOT exist for ImporterRamanExperiment_B2.
			%   Error id: [BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'RE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterRamanExperiment_B2:' 'WrongInput'], ...
					['BRAPH2' ':ImporterRamanExperiment_B2:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterRamanExperiment_B2.'] ...
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
			%  PROPERTY = IM.GETPROPPROP(POINTER) returns property number of POINTER of IM.
			%  PROPERTY = Element.GETPROPPROP(ImporterRamanExperiment_B2, POINTER) returns property number of POINTER of ImporterRamanExperiment_B2.
			%  PROPERTY = IM.GETPROPPROP(ImporterRamanExperiment_B2, POINTER) returns property number of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'RE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = IM.GETPROPTAG(POINTER) returns tag of POINTER of IM.
			%  TAG = Element.GETPROPTAG(ImporterRamanExperiment_B2, POINTER) returns tag of POINTER of ImporterRamanExperiment_B2.
			%  TAG = IM.GETPROPTAG(ImporterRamanExperiment_B2, POINTER) returns tag of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importerramanexperiment_b2_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'FILE'  'GET_FILE'  'RE' };
				tag = importerramanexperiment_b2_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = IM.GETPROPCATEGORY(POINTER) returns category of POINTER of IM.
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterRamanExperiment_B2, POINTER) returns category of POINTER of ImporterRamanExperiment_B2.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterRamanExperiment_B2, POINTER) returns category of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_B2.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerramanexperiment_b2_category_list = { 1  1  1  3  4  2  2  6  9  4  6  5 };
			prop_category = importerramanexperiment_b2_category_list{prop};
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
			%  FORMAT = IM.GETPROPFORMAT(POINTER) returns format of POINTER of IM.
			%  FORMAT = Element.GETPROPFORMAT(ImporterRamanExperiment_B2, POINTER) returns format of POINTER of ImporterRamanExperiment_B2.
			%  FORMAT = IM.GETPROPFORMAT(ImporterRamanExperiment_B2, POINTER) returns format of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_B2.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerramanexperiment_b2_format_list = { 2  2  2  8  2  2  2  2  4  2  8  8 };
			prop_format = importerramanexperiment_b2_format_list{prop};
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
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(POINTER) returns description of POINTER of IM.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterRamanExperiment_B2, POINTER) returns description of POINTER of ImporterRamanExperiment_B2.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterRamanExperiment_B2, POINTER) returns description of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_B2.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerramanexperiment_b2_description_list = { 'ELCLASS (constant, string) is the class of the importer of Raman experiment from B2.'  'NAME (constant, string) is the name of the importer of Raman experiment from B2.'  'DESCRIPTION (constant, string) is the description of the importer of Raman experiment from B2.'  'TEMPLATE (parameter, item) is the template of the importer of Raman experiment from B2.'  'ID (data, string) is a few-letter code for the importer of Raman experiment from B2.'  'LABEL (metadata, string) is an extended label of the importer of Raman experiment from B2.'  'NOTES (metadata, string) are some specific notes about the importer of Raman experiment from B2.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'FILE (data, string) is the loaded B2 file.'  'GET_FILE (query, item) opens a dialog box to get the B2 file from which the Raman Experiment can be loaded.'  'RE (result, item) is a Raman Experiment.' };
			prop_description = importerramanexperiment_b2_description_list{prop};
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
			%  SETTINGS = IM.GETPROPSETTINGS(POINTER) returns settings of POINTER of IM.
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterRamanExperiment_B2, POINTER) returns settings of POINTER of ImporterRamanExperiment_B2.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterRamanExperiment_B2, POINTER) returns settings of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_B2.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterRamanExperiment_B2.FILE
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterRamanExperiment_B2.GET_FILE
					prop_settings = 'ImporterRamanExperiment_B2';
				case 12 % ImporterRamanExperiment_B2.RE
					prop_settings = 'RamanExperiment';
				case 4 % ImporterRamanExperiment_B2.TEMPLATE
					prop_settings = 'ImporterRamanExperiment_B2';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterRamanExperiment_B2.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterRamanExperiment_B2.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterRamanExperiment_B2, POINTER) returns the default value of POINTER of ImporterRamanExperiment_B2.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterRamanExperiment_B2, POINTER) returns the default value of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterRamanExperiment_B2.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterRamanExperiment_B2.FILE
					prop_default = 'test.b2';
				case 11 % ImporterRamanExperiment_B2.GET_FILE
					prop_default = Format.getFormatDefault(8, ImporterRamanExperiment_B2.getPropSettings(prop));
				case 12 % ImporterRamanExperiment_B2.RE
					prop_default = RamanExperiment();
				case 1 % ImporterRamanExperiment_B2.ELCLASS
					prop_default = 'ImporterRamanExperiment_B2';
				case 2 % ImporterRamanExperiment_B2.NAME
					prop_default = 'Importer of Raman experiment from B2';
				case 3 % ImporterRamanExperiment_B2.DESCRIPTION
					prop_default = 'Raman experiment importer from B2 file (ImporterRamanExperiment_B2) imports a set of Raman spectra acquired in a Raman Experiment stored in a B2 file.';
				case 4 % ImporterRamanExperiment_B2.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterRamanExperiment_B2.getPropSettings(prop));
				case 5 % ImporterRamanExperiment_B2.ID
					prop_default = 'ImporterRamanExperiment_B2 ID';
				case 6 % ImporterRamanExperiment_B2.LABEL
					prop_default = 'ImporterRamanExperiment_B2 label';
				case 7 % ImporterRamanExperiment_B2.NOTES
					prop_default = 'ImporterRamanExperiment_B2 notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterRamanExperiment_B2.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterRamanExperiment_B2.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterRamanExperiment_B2, POINTER) returns the conditioned default value of POINTER of ImporterRamanExperiment_B2.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterRamanExperiment_B2, POINTER) returns the conditioned default value of POINTER of ImporterRamanExperiment_B2.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterRamanExperiment_B2.getPropProp(pointer);
			
			prop_default = ImporterRamanExperiment_B2.conditioning(prop, ImporterRamanExperiment_B2.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = IM.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = IM.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of IM.
			%  CHECK = Element.CHECKPROP(ImporterRamanExperiment_B2, PROP, VALUE) checks VALUE format for PROP of ImporterRamanExperiment_B2.
			%  CHECK = IM.CHECKPROP(ImporterRamanExperiment_B2, PROP, VALUE) checks VALUE format for PROP of ImporterRamanExperiment_B2.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterRamanExperiment_B2:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterRamanExperiment_B2:WrongInput
			%  Element.CHECKPROP(ImporterRamanExperiment_B2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterRamanExperiment_B2.
			%   Error id: BRAPH2:ImporterRamanExperiment_B2:WrongInput
			%  IM.CHECKPROP(ImporterRamanExperiment_B2, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterRamanExperiment_B2.
			%   Error id: BRAPH2:ImporterRamanExperiment_B2:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterRamanExperiment_B2')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterRamanExperiment_B2.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterRamanExperiment_B2.FILE
					check = Format.checkFormat(2, value, ImporterRamanExperiment_B2.getPropSettings(prop));
				case 11 % ImporterRamanExperiment_B2.GET_FILE
					check = Format.checkFormat(8, value, ImporterRamanExperiment_B2.getPropSettings(prop));
				case 12 % ImporterRamanExperiment_B2.RE
					check = Format.checkFormat(8, value, ImporterRamanExperiment_B2.getPropSettings(prop));
				case 4 % ImporterRamanExperiment_B2.TEMPLATE
					check = Format.checkFormat(8, value, ImporterRamanExperiment_B2.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterRamanExperiment_B2:' 'WrongInput'], ...
					['BRAPH2' ':ImporterRamanExperiment_B2:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterRamanExperiment_B2.getPropTag(prop) ' (' ImporterRamanExperiment_B2.getFormatTag(ImporterRamanExperiment_B2.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(im, prop, varargin)
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
				case 11 % ImporterRamanExperiment_B2.GET_FILE
					[filename, filepath, filterindex] = uigetfile({'*.b2'}, 'Select B2 file');
					if filterindex
					    file = [filepath filename];
					    im.set('FILE', file);
					end
					value = im;
					
				case 12 % ImporterRamanExperiment_B2.RE
					rng_settings_ = rng(); rng(im.getPropSeed(12), 'twister')
					
					% creates empty RamanExperiment
					re = RamanExperiment();
					
					% analyzes file
					file = im.get('FILE');
					
					if isfile(file)
						wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading File ...');
					
					    try
					        % loads the element EL from the b2 file
					        % also loads the BRAPH2 BUILD, the MatLab
					        % version number, and the details of the MatLab version
					        [el, build, v, vd] = Element.load(file);
					        re = el;
					       
					        braph2waitbar(wb, .15, 'Loading Raman Experiment ...');
					    catch e
					        braph2waitbar(wb, 'close')
					        rethrow(e)
					    end
					    
						braph2waitbar(wb, 'close')
					else
					    error(['BRAPH2' ':ImporterRamanExperiment_B2:' 'ErrorIO'], ...
					        ['BRAPH2' ':ImporterRamanExperiment_B2:' 'ErrorIO' '\n' ...
					        'The prop DIRECTORY must be an existing directory, but it is ''' directory '''.'] ...
					        );
					end
					
					value = re;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 9
						value = calculateValue@Importer(im, prop, varargin{:});
					else
						value = calculateValue@Element(im, prop, varargin{:});
					end
			end
			
		end
	end
end
