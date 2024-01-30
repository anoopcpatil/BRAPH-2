classdef ImporterRamanExperiment_TXT < Importer
	%ImporterRamanExperiment_TXT imports a Raman experiment from a series of TXT files.
	% It is a subclass of <a href="matlab:help Importer">Importer</a>.
	%
	% Raman experiment importer from TXT files (ImporterRamanExperiment_TXT) imports a set of Raman spectra acquired in TXT files.
	% The first row is the wavelength in cm-1, the subsequent rows contain the acquired spectra.
	% The first three columns contain metadata that can be ignored.
	% The values are tab-separated.
	%
	% The list of ImporterRamanExperiment_TXT properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the .
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the importer of Raman experiment from TXT.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the importer of Raman experiment from TXT.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importer of Raman experiment from TXT.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the importer of Raman experiment from TXT.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the importer of Raman experiment from TXT.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the importer of Raman experiment from TXT.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory containing the spectra files from which to load the Raman experiment.
	%  <strong>11</strong> <strong>GET_DIR</strong> 	GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the spectra.
	%  <strong>12</strong> <strong>RE</strong> 	RE (result, item) is a Raman experiment.
	%
	% ImporterRamanExperiment_TXT methods (constructor):
	%  ImporterRamanExperiment_TXT - constructor
	%
	% ImporterRamanExperiment_TXT methods:
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
	% ImporterRamanExperiment_TXT methods (display):
	%  tostring - string with information about the importer of Raman experiment from TXT
	%  disp - displays information about the importer of Raman experiment from TXT
	%  tree - displays the tree of the importer of Raman experiment from TXT
	%
	% ImporterRamanExperiment_TXT methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two importer of Raman experiment from TXT are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the importer of Raman experiment from TXT
	%
	% ImporterRamanExperiment_TXT methods (save/load, Static):
	%  save - saves BRAPH2 importer of Raman experiment from TXT as b2 file
	%  load - loads a BRAPH2 importer of Raman experiment from TXT from a b2 file
	%
	% ImporterRamanExperiment_TXT method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the importer of Raman experiment from TXT
	%
	% ImporterRamanExperiment_TXT method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the importer of Raman experiment from TXT
	%
	% ImporterRamanExperiment_TXT methods (inspection, Static):
	%  getClass - returns the class of the importer of Raman experiment from TXT
	%  getSubclasses - returns all subclasses of ImporterRamanExperiment_TXT
	%  getProps - returns the property list of the importer of Raman experiment from TXT
	%  getPropNumber - returns the property number of the importer of Raman experiment from TXT
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
	% ImporterRamanExperiment_TXT methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% ImporterRamanExperiment_TXT methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% ImporterRamanExperiment_TXT methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% ImporterRamanExperiment_TXT methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?ImporterRamanExperiment_TXT; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">ImporterRamanExperiment_TXT constants</a>.
	%
	%
	% See also RamanExperiment, Spectrum.
	
	properties (Constant) % properties
		DIRECTORY = 10; %CET: Computational Efficiency Trick
		DIRECTORY_TAG = 'DIRECTORY';
		DIRECTORY_CATEGORY = 4;
		DIRECTORY_FORMAT = 2;
		
		GET_DIR = 11; %CET: Computational Efficiency Trick
		GET_DIR_TAG = 'GET_DIR';
		GET_DIR_CATEGORY = 6;
		GET_DIR_FORMAT = 8;
		
		RE = 12; %CET: Computational Efficiency Trick
		RE_TAG = 'RE';
		RE_CATEGORY = 5;
		RE_FORMAT = 8;
	end
	methods % constructor
		function im = ImporterRamanExperiment_TXT(varargin)
			%ImporterRamanExperiment_TXT() creates a importer of Raman experiment from TXT.
			%
			% ImporterRamanExperiment_TXT(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% ImporterRamanExperiment_TXT(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of ImporterRamanExperiment_TXT properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the .
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the importer of Raman experiment from TXT.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the importer of Raman experiment from TXT.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the importer of Raman experiment from TXT.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the importer of Raman experiment from TXT.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the importer of Raman experiment from TXT.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the importer of Raman experiment from TXT.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>DIRECTORY</strong> 	DIRECTORY (data, string) is the directory containing the spectra files from which to load the Raman experiment.
			%  <strong>11</strong> <strong>GET_DIR</strong> 	GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the spectra.
			%  <strong>12</strong> <strong>RE</strong> 	RE (result, item) is a Raman experiment.
			%
			% See also Category, Format.
			
			im = im@Importer(varargin{:});
		end
	end
	methods (Static) % inspection
		function im_class = getClass()
			%GETCLASS returns the class of the importer of Raman experiment from TXT.
			%
			% CLASS = ImporterRamanExperiment_TXT.GETCLASS() returns the class 'ImporterRamanExperiment_TXT'.
			%
			% Alternative forms to call this method are:
			%  CLASS = IM.GETCLASS() returns the class of the importer of Raman experiment from TXT IM.
			%  CLASS = Element.GETCLASS(IM) returns the class of 'IM'.
			%  CLASS = Element.GETCLASS('ImporterRamanExperiment_TXT') returns 'ImporterRamanExperiment_TXT'.
			%
			% Note that the Element.GETCLASS(IM) and Element.GETCLASS('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			
			im_class = 'ImporterRamanExperiment_TXT';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the importer of Raman experiment from TXT.
			%
			% LIST = ImporterRamanExperiment_TXT.GETSUBCLASSES() returns all subclasses of 'ImporterRamanExperiment_TXT'.
			%
			% Alternative forms to call this method are:
			%  LIST = IM.GETSUBCLASSES() returns all subclasses of the importer of Raman experiment from TXT IM.
			%  LIST = Element.GETSUBCLASSES(IM) returns all subclasses of 'IM'.
			%  LIST = Element.GETSUBCLASSES('ImporterRamanExperiment_TXT') returns all subclasses of 'ImporterRamanExperiment_TXT'.
			%
			% Note that the Element.GETSUBCLASSES(IM) and Element.GETSUBCLASSES('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'ImporterRamanExperiment_TXT' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of importer of Raman experiment from TXT.
			%
			% PROPS = ImporterRamanExperiment_TXT.GETPROPS() returns the property list of importer of Raman experiment from TXT
			%  as a row vector.
			%
			% PROPS = ImporterRamanExperiment_TXT.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = IM.GETPROPS([CATEGORY]) returns the property list of the importer of Raman experiment from TXT IM.
			%  PROPS = Element.GETPROPS(IM[, CATEGORY]) returns the property list of 'IM'.
			%  PROPS = Element.GETPROPS('ImporterRamanExperiment_TXT'[, CATEGORY]) returns the property list of 'ImporterRamanExperiment_TXT'.
			%
			% Note that the Element.GETPROPS(IM) and Element.GETPROPS('ImporterRamanExperiment_TXT')
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
			%GETPROPNUMBER returns the property number of importer of Raman experiment from TXT.
			%
			% N = ImporterRamanExperiment_TXT.GETPROPNUMBER() returns the property number of importer of Raman experiment from TXT.
			%
			% N = ImporterRamanExperiment_TXT.GETPROPNUMBER(CATEGORY) returns the property number of importer of Raman experiment from TXT
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = IM.GETPROPNUMBER([CATEGORY]) returns the property number of the importer of Raman experiment from TXT IM.
			%  N = Element.GETPROPNUMBER(IM) returns the property number of 'IM'.
			%  N = Element.GETPROPNUMBER('ImporterRamanExperiment_TXT') returns the property number of 'ImporterRamanExperiment_TXT'.
			%
			% Note that the Element.GETPROPNUMBER(IM) and Element.GETPROPNUMBER('ImporterRamanExperiment_TXT')
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
			%EXISTSPROP checks whether property exists in importer of Raman experiment from TXT/error.
			%
			% CHECK = ImporterRamanExperiment_TXT.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSPROP(PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(IM, PROP) checks whether PROP exists for IM.
			%  CHECK = Element.EXISTSPROP(ImporterRamanExperiment_TXT, PROP) checks whether PROP exists for ImporterRamanExperiment_TXT.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSPROP(PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%  Element.EXISTSPROP(IM, PROP) throws error if PROP does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%  Element.EXISTSPROP(ImporterRamanExperiment_TXT, PROP) throws error if PROP does NOT exist for ImporterRamanExperiment_TXT.
			%   Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%
			% Note that the Element.EXISTSPROP(IM) and Element.EXISTSPROP('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 12 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterRamanExperiment_TXT:' 'WrongInput'], ...
					['BRAPH2' ':ImporterRamanExperiment_TXT:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for ImporterRamanExperiment_TXT.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in importer of Raman experiment from TXT/error.
			%
			% CHECK = ImporterRamanExperiment_TXT.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = IM.EXISTSTAG(TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(IM, TAG) checks whether TAG exists for IM.
			%  CHECK = Element.EXISTSTAG(ImporterRamanExperiment_TXT, TAG) checks whether TAG exists for ImporterRamanExperiment_TXT.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%
			% Alternative forms to call this method are:
			%  IM.EXISTSTAG(TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%  Element.EXISTSTAG(IM, TAG) throws error if TAG does NOT exist for IM.
			%   Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%  Element.EXISTSTAG(ImporterRamanExperiment_TXT, TAG) throws error if TAG does NOT exist for ImporterRamanExperiment_TXT.
			%   Error id: [BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			%
			% Note that the Element.EXISTSTAG(IM) and Element.EXISTSTAG('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'GET_DIR'  'RE' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterRamanExperiment_TXT:' 'WrongInput'], ...
					['BRAPH2' ':ImporterRamanExperiment_TXT:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for ImporterRamanExperiment_TXT.'] ...
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
			%  PROPERTY = Element.GETPROPPROP(ImporterRamanExperiment_TXT, POINTER) returns property number of POINTER of ImporterRamanExperiment_TXT.
			%  PROPERTY = IM.GETPROPPROP(ImporterRamanExperiment_TXT, POINTER) returns property number of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPPROP(IM) and Element.GETPROPPROP('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'GET_DIR'  'RE' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = Element.GETPROPTAG(ImporterRamanExperiment_TXT, POINTER) returns tag of POINTER of ImporterRamanExperiment_TXT.
			%  TAG = IM.GETPROPTAG(ImporterRamanExperiment_TXT, POINTER) returns tag of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPTAG(IM) and Element.GETPROPTAG('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				importerramanexperiment_txt_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'DIRECTORY'  'GET_DIR'  'RE' };
				tag = importerramanexperiment_txt_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = Element.GETPROPCATEGORY(ImporterRamanExperiment_TXT, POINTER) returns category of POINTER of ImporterRamanExperiment_TXT.
			%  CATEGORY = IM.GETPROPCATEGORY(ImporterRamanExperiment_TXT, POINTER) returns category of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPCATEGORY(IM) and Element.GETPROPCATEGORY('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_TXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerramanexperiment_txt_category_list = { 1  1  1  3  4  2  2  6  9  4  6  5 };
			prop_category = importerramanexperiment_txt_category_list{prop};
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
			%  FORMAT = Element.GETPROPFORMAT(ImporterRamanExperiment_TXT, POINTER) returns format of POINTER of ImporterRamanExperiment_TXT.
			%  FORMAT = IM.GETPROPFORMAT(ImporterRamanExperiment_TXT, POINTER) returns format of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPFORMAT(IM) and Element.GETPROPFORMAT('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_TXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerramanexperiment_txt_format_list = { 2  2  2  8  2  2  2  2  4  2  8  8 };
			prop_format = importerramanexperiment_txt_format_list{prop};
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
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(ImporterRamanExperiment_TXT, POINTER) returns description of POINTER of ImporterRamanExperiment_TXT.
			%  DESCRIPTION = IM.GETPROPDESCRIPTION(ImporterRamanExperiment_TXT, POINTER) returns description of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPDESCRIPTION(IM) and Element.GETPROPDESCRIPTION('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_TXT.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			importerramanexperiment_txt_description_list = { 'ELCLASS (constant, string) is the class of the .'  'NAME (constant, string) is the name of the importer of Raman experiment from TXT.'  'DESCRIPTION (constant, string) is the description of the importer of Raman experiment from TXT.'  'TEMPLATE (parameter, item) is the template of the importer of Raman experiment from TXT.'  'ID (data, string) is a few-letter code for the importer of Raman experiment from TXT.'  'LABEL (metadata, string) is an extended label of the importer of Raman experiment from TXT.'  'NOTES (metadata, string) are some specific notes about the importer of Raman experiment from TXT.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'DIRECTORY (data, string) is the directory containing the spectra files from which to load the Raman experiment.'  'GET_DIR (query, item) opens a dialog box to set the directory from where to load the TXT files of the spectra.'  'RE (result, item) is a Raman experiment.' };
			prop_description = importerramanexperiment_txt_description_list{prop};
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
			%  SETTINGS = Element.GETPROPSETTINGS(ImporterRamanExperiment_TXT, POINTER) returns settings of POINTER of ImporterRamanExperiment_TXT.
			%  SETTINGS = IM.GETPROPSETTINGS(ImporterRamanExperiment_TXT, POINTER) returns settings of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPSETTINGS(IM) and Element.GETPROPSETTINGS('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = ImporterRamanExperiment_TXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterRamanExperiment_TXT.DIRECTORY
					prop_settings = Format.getFormatSettings(2);
				case 11 % ImporterRamanExperiment_TXT.GET_DIR
					prop_settings = 'ImporterRamanExperiment_TXT';
				case 12 % ImporterRamanExperiment_TXT.RE
					prop_settings = 'RamanExperiment';
				case 4 % ImporterRamanExperiment_TXT.TEMPLATE
					prop_settings = 'ImporterRamanExperiment_TXT';
				otherwise
					prop_settings = getPropSettings@Importer(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = ImporterRamanExperiment_TXT.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterRamanExperiment_TXT.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULT(POINTER) returns the default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULT(ImporterRamanExperiment_TXT, POINTER) returns the default value of POINTER of ImporterRamanExperiment_TXT.
			%  DEFAULT = IM.GETPROPDEFAULT(ImporterRamanExperiment_TXT, POINTER) returns the default value of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPDEFAULT(IM) and Element.GETPROPDEFAULT('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = ImporterRamanExperiment_TXT.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 10 % ImporterRamanExperiment_TXT.DIRECTORY
					prop_default = fileparts(which('test_braph2'));
				case 11 % ImporterRamanExperiment_TXT.GET_DIR
					prop_default = Format.getFormatDefault(8, ImporterRamanExperiment_TXT.getPropSettings(prop));
				case 12 % ImporterRamanExperiment_TXT.RE
					prop_default = Format.getFormatDefault(8, ImporterRamanExperiment_TXT.getPropSettings(prop));
				case 1 % ImporterRamanExperiment_TXT.ELCLASS
					prop_default = 'ImporterRamanExperiment_TXT';
				case 2 % ImporterRamanExperiment_TXT.NAME
					prop_default = 'Importer of Raman experiment from TXT';
				case 3 % ImporterRamanExperiment_TXT.DESCRIPTION
					prop_default = 'Raman experiment importer from TXT files (ImporterRamanExperiment_TXT) imports a set of Raman spectra acquired in TXT files. The first row is the wavelength in cm-1, the subsequent rows contain the acquired spectra. The first three columns contain metadata that can be ignored. The values are tab-separated.';
				case 4 % ImporterRamanExperiment_TXT.TEMPLATE
					prop_default = Format.getFormatDefault(8, ImporterRamanExperiment_TXT.getPropSettings(prop));
				case 5 % ImporterRamanExperiment_TXT.ID
					prop_default = 'ImporterRamanExperiment_TXT ID';
				case 6 % ImporterRamanExperiment_TXT.LABEL
					prop_default = 'ImporterRamanExperiment_TXT label';
				case 7 % ImporterRamanExperiment_TXT.NOTES
					prop_default = 'ImporterRamanExperiment_TXT notes';
				otherwise
					prop_default = getPropDefault@Importer(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = ImporterRamanExperiment_TXT.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = ImporterRamanExperiment_TXT.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of IM.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(ImporterRamanExperiment_TXT, POINTER) returns the conditioned default value of POINTER of ImporterRamanExperiment_TXT.
			%  DEFAULT = IM.GETPROPDEFAULTCONDITIONED(ImporterRamanExperiment_TXT, POINTER) returns the conditioned default value of POINTER of ImporterRamanExperiment_TXT.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(IM) and Element.GETPROPDEFAULTCONDITIONED('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = ImporterRamanExperiment_TXT.getPropProp(pointer);
			
			prop_default = ImporterRamanExperiment_TXT.conditioning(prop, ImporterRamanExperiment_TXT.getPropDefault(prop));
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
			%  CHECK = Element.CHECKPROP(ImporterRamanExperiment_TXT, PROP, VALUE) checks VALUE format for PROP of ImporterRamanExperiment_TXT.
			%  CHECK = IM.CHECKPROP(ImporterRamanExperiment_TXT, PROP, VALUE) checks VALUE format for PROP of ImporterRamanExperiment_TXT.
			% 
			% IM.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:ImporterRamanExperiment_TXT:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  IM.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of IM.
			%   Error id: BRAPH2:ImporterRamanExperiment_TXT:WrongInput
			%  Element.CHECKPROP(ImporterRamanExperiment_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterRamanExperiment_TXT.
			%   Error id: BRAPH2:ImporterRamanExperiment_TXT:WrongInput
			%  IM.CHECKPROP(ImporterRamanExperiment_TXT, PROP, VALUE) throws error if VALUE has not a valid format for PROP of ImporterRamanExperiment_TXT.
			%   Error id: BRAPH2:ImporterRamanExperiment_TXT:WrongInput]
			% 
			% Note that the Element.CHECKPROP(IM) and Element.CHECKPROP('ImporterRamanExperiment_TXT')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = ImporterRamanExperiment_TXT.getPropProp(pointer);
			
			switch prop
				case 10 % ImporterRamanExperiment_TXT.DIRECTORY
					check = Format.checkFormat(2, value, ImporterRamanExperiment_TXT.getPropSettings(prop));
				case 11 % ImporterRamanExperiment_TXT.GET_DIR
					check = Format.checkFormat(8, value, ImporterRamanExperiment_TXT.getPropSettings(prop));
				case 12 % ImporterRamanExperiment_TXT.RE
					check = Format.checkFormat(8, value, ImporterRamanExperiment_TXT.getPropSettings(prop));
				case 4 % ImporterRamanExperiment_TXT.TEMPLATE
					check = Format.checkFormat(8, value, ImporterRamanExperiment_TXT.getPropSettings(prop));
				otherwise
					if prop <= 9
						check = checkProp@Importer(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':ImporterRamanExperiment_TXT:' 'WrongInput'], ...
					['BRAPH2' ':ImporterRamanExperiment_TXT:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' ImporterRamanExperiment_TXT.getPropTag(prop) ' (' ImporterRamanExperiment_TXT.getFormatTag(ImporterRamanExperiment_TXT.getPropFormat(prop)) ').'] ...
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
				case 11 % ImporterRamanExperiment_TXT.GET_DIR
					directory = uigetdir('Select directory');
					if ischar(directory) && isfolder(directory)
						im.set('DIRECTORY', directory);
					end
					value = im;
					
				case 12 % ImporterRamanExperiment_TXT.RE
					rng_settings_ = rng(); rng(im.getPropSeed(12), 'twister')
					
					re = RamanExperiment();
					
					directory = im.get('DIRECTORY');
					if isfolder(directory)  
					    wb = braph2waitbar(im.get('WAITBAR'), 0, 'Reading directory ...');
					    
					    [~, name] = fileparts(directory);
					    re.set( ...
					        'ID', name, ...
					        'LABEL', name, ...
					        'NOTES', ['Spectra loaded from ' directory] ...
					        );
					
					    try
					        braph2waitbar(wb, .15, 'Loading spectra...')
					
					        % analyzes file
					        files = dir(fullfile(directory, '*.txt'));
					
					        if ~isempty(files)
					            sp_dict = re.memorize('SP_DICT');
					            for i = 1:1:length(files)
					                braph2waitbar(wb, .15 + .85 * i / length(files), ['Loading spectrum ' num2str(i) ' of ' num2str(length(files)) ' ...'])
					
					                [~, sp_id] = fileparts(files(i).name);
					
					                table = readtable(fullfile(directory, files(i).name), 'FileType', 'delimitedtext', 'Delimiter', '	');
					                table(:, 1:3) = []; % eliminates columns 1-3
					                data = table2array(table);
					
					                sp = Spectrum( ...
					                    'ID', sp_id, ...
					                    'LABEL', sp_id, ...
					                    'WAVELENGTH', data(1, :)', ... % first row
					                    'INTENSITIES', data(2:end, :)', ... % subsequent rows
					                    'NOTES', ['Spectrum loaded from ' files(i).name] ...
					                );
					                sp_dict.get('ADD', sp);
					            end
					        end
					    catch e
					        braph2waitbar(wb, 'close')
					        
					        rethrow(e)
					    end
					    
						braph2waitbar(wb, 'close')
					else
					    error(['BRAPH2' ':ImporterRamanExperiment_TXT:' 'ErrorIO'], ...
					        ['BRAPH2' ':ImporterRamanExperiment_TXT:' 'ErrorIO' '\n' ...
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
