classdef CosmicRayNoiseRemover < REAnalysisModule
	%CosmicRayNoiseRemover is an REAnalysisModule that reads raw Raman spectra and outputs fixed spectra (with cosmic ray noise removed).
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Cosmic Ray Noise Remover Module (CosmicRayNoiseRemover) is an REAnalysisModule that 
	% reads the raw Raman spectra and evaluates the fixed spectra with cosmic ray noise removed.
	% It also provides basic functionalities to view and plot the fixed spectra.
	%
	% The list of CosmicRayNoiseRemover properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Cosmic Ray Noise Remover.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Cosmic Ray Noise Remover.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Cosmic Ray Noise Remover.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Cosmic Ray Noise Remover.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Cosmic Ray Noise Remover.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Cosmic Ray Noise Remover.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Cosmic Ray Noise Remover.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>RE_OUT</strong> 	RE_OUT (query, item) is the output Raman Experiment with fixed spectra as a result.
	%  <strong>11</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
	%
	% CosmicRayNoiseRemover methods (constructor):
	%  CosmicRayNoiseRemover - constructor
	%
	% CosmicRayNoiseRemover methods:
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
	% CosmicRayNoiseRemover methods (display):
	%  tostring - string with information about the Cosmic Ray Noise Remover
	%  disp - displays information about the Cosmic Ray Noise Remover
	%  tree - displays the tree of the Cosmic Ray Noise Remover
	%
	% CosmicRayNoiseRemover methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Cosmic Ray Noise Remover are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Cosmic Ray Noise Remover
	%
	% CosmicRayNoiseRemover methods (save/load, Static):
	%  save - saves BRAPH2 Cosmic Ray Noise Remover as b2 file
	%  load - loads a BRAPH2 Cosmic Ray Noise Remover from a b2 file
	%
	% CosmicRayNoiseRemover method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Cosmic Ray Noise Remover
	%
	% CosmicRayNoiseRemover method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Cosmic Ray Noise Remover
	%
	% CosmicRayNoiseRemover methods (inspection, Static):
	%  getClass - returns the class of the Cosmic Ray Noise Remover
	%  getSubclasses - returns all subclasses of CosmicRayNoiseRemover
	%  getProps - returns the property list of the Cosmic Ray Noise Remover
	%  getPropNumber - returns the property number of the Cosmic Ray Noise Remover
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
	% CosmicRayNoiseRemover methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CosmicRayNoiseRemover methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CosmicRayNoiseRemover methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CosmicRayNoiseRemover methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CosmicRayNoiseRemover; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CosmicRayNoiseRemover constants</a>.
	%
	%
	% See also REAnalysisModule, RamanExperiment, Spectrum.
	
	methods % constructor
		function crnr = CosmicRayNoiseRemover(varargin)
			%CosmicRayNoiseRemover() creates a Cosmic Ray Noise Remover.
			%
			% CosmicRayNoiseRemover(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CosmicRayNoiseRemover(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CosmicRayNoiseRemover properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Cosmic Ray Noise Remover.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Cosmic Ray Noise Remover.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Cosmic Ray Noise Remover.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Cosmic Ray Noise Remover.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Cosmic Ray Noise Remover.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Cosmic Ray Noise Remover.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Cosmic Ray Noise Remover.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>RE_OUT</strong> 	RE_OUT (query, item) is the output Raman Experiment with fixed spectra as a result.
			%  <strong>11</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the REAnalysisModule.
			%
			% See also Category, Format.
			
			crnr = crnr@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function crnr_class = getClass()
			%GETCLASS returns the class of the Cosmic Ray Noise Remover.
			%
			% CLASS = CosmicRayNoiseRemover.GETCLASS() returns the class 'CosmicRayNoiseRemover'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CRNR.GETCLASS() returns the class of the Cosmic Ray Noise Remover CRNR.
			%  CLASS = Element.GETCLASS(CRNR) returns the class of 'CRNR'.
			%  CLASS = Element.GETCLASS('CosmicRayNoiseRemover') returns 'CosmicRayNoiseRemover'.
			%
			% Note that the Element.GETCLASS(CRNR) and Element.GETCLASS('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			
			crnr_class = 'CosmicRayNoiseRemover';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Cosmic Ray Noise Remover.
			%
			% LIST = CosmicRayNoiseRemover.GETSUBCLASSES() returns all subclasses of 'CosmicRayNoiseRemover'.
			%
			% Alternative forms to call this method are:
			%  LIST = CRNR.GETSUBCLASSES() returns all subclasses of the Cosmic Ray Noise Remover CRNR.
			%  LIST = Element.GETSUBCLASSES(CRNR) returns all subclasses of 'CRNR'.
			%  LIST = Element.GETSUBCLASSES('CosmicRayNoiseRemover') returns all subclasses of 'CosmicRayNoiseRemover'.
			%
			% Note that the Element.GETSUBCLASSES(CRNR) and Element.GETSUBCLASSES('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'CosmicRayNoiseRemover' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Cosmic Ray Noise Remover.
			%
			% PROPS = CosmicRayNoiseRemover.GETPROPS() returns the property list of Cosmic Ray Noise Remover
			%  as a row vector.
			%
			% PROPS = CosmicRayNoiseRemover.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CRNR.GETPROPS([CATEGORY]) returns the property list of the Cosmic Ray Noise Remover CRNR.
			%  PROPS = Element.GETPROPS(CRNR[, CATEGORY]) returns the property list of 'CRNR'.
			%  PROPS = Element.GETPROPS('CosmicRayNoiseRemover'[, CATEGORY]) returns the property list of 'CosmicRayNoiseRemover'.
			%
			% Note that the Element.GETPROPS(CRNR) and Element.GETPROPS('CosmicRayNoiseRemover')
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
			%GETPROPNUMBER returns the property number of Cosmic Ray Noise Remover.
			%
			% N = CosmicRayNoiseRemover.GETPROPNUMBER() returns the property number of Cosmic Ray Noise Remover.
			%
			% N = CosmicRayNoiseRemover.GETPROPNUMBER(CATEGORY) returns the property number of Cosmic Ray Noise Remover
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CRNR.GETPROPNUMBER([CATEGORY]) returns the property number of the Cosmic Ray Noise Remover CRNR.
			%  N = Element.GETPROPNUMBER(CRNR) returns the property number of 'CRNR'.
			%  N = Element.GETPROPNUMBER('CosmicRayNoiseRemover') returns the property number of 'CosmicRayNoiseRemover'.
			%
			% Note that the Element.GETPROPNUMBER(CRNR) and Element.GETPROPNUMBER('CosmicRayNoiseRemover')
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
			%EXISTSPROP checks whether property exists in Cosmic Ray Noise Remover/error.
			%
			% CHECK = CosmicRayNoiseRemover.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CRNR.EXISTSPROP(PROP) checks whether PROP exists for CRNR.
			%  CHECK = Element.EXISTSPROP(CRNR, PROP) checks whether PROP exists for CRNR.
			%  CHECK = Element.EXISTSPROP(CosmicRayNoiseRemover, PROP) checks whether PROP exists for CosmicRayNoiseRemover.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CRNR.EXISTSPROP(PROP) throws error if PROP does NOT exist for CRNR.
			%   Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%  Element.EXISTSPROP(CRNR, PROP) throws error if PROP does NOT exist for CRNR.
			%   Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%  Element.EXISTSPROP(CosmicRayNoiseRemover, PROP) throws error if PROP does NOT exist for CosmicRayNoiseRemover.
			%   Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CRNR) and Element.EXISTSPROP('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 11 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CosmicRayNoiseRemover:' 'WrongInput'], ...
					['BRAPH2' ':CosmicRayNoiseRemover:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CosmicRayNoiseRemover.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Cosmic Ray Noise Remover/error.
			%
			% CHECK = CosmicRayNoiseRemover.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CRNR.EXISTSTAG(TAG) checks whether TAG exists for CRNR.
			%  CHECK = Element.EXISTSTAG(CRNR, TAG) checks whether TAG exists for CRNR.
			%  CHECK = Element.EXISTSTAG(CosmicRayNoiseRemover, TAG) checks whether TAG exists for CosmicRayNoiseRemover.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CRNR.EXISTSTAG(TAG) throws error if TAG does NOT exist for CRNR.
			%   Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%  Element.EXISTSTAG(CRNR, TAG) throws error if TAG does NOT exist for CRNR.
			%   Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%  Element.EXISTSTAG(CosmicRayNoiseRemover, TAG) throws error if TAG does NOT exist for CosmicRayNoiseRemover.
			%   Error id: [BRAPH2:CosmicRayNoiseRemover:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CRNR) and Element.EXISTSTAG('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT'  'REPF' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CosmicRayNoiseRemover:' 'WrongInput'], ...
					['BRAPH2' ':CosmicRayNoiseRemover:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for CosmicRayNoiseRemover.'] ...
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
			%  PROPERTY = CRNR.GETPROPPROP(POINTER) returns property number of POINTER of CRNR.
			%  PROPERTY = Element.GETPROPPROP(CosmicRayNoiseRemover, POINTER) returns property number of POINTER of CosmicRayNoiseRemover.
			%  PROPERTY = CRNR.GETPROPPROP(CosmicRayNoiseRemover, POINTER) returns property number of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPPROP(CRNR) and Element.GETPROPPROP('CosmicRayNoiseRemover')
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
			%  TAG = CRNR.GETPROPTAG(POINTER) returns tag of POINTER of CRNR.
			%  TAG = Element.GETPROPTAG(CosmicRayNoiseRemover, POINTER) returns tag of POINTER of CosmicRayNoiseRemover.
			%  TAG = CRNR.GETPROPTAG(CosmicRayNoiseRemover, POINTER) returns tag of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPTAG(CRNR) and Element.GETPROPTAG('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				cosmicraynoiseremover_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT'  'REPF' };
				tag = cosmicraynoiseremover_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = CRNR.GETPROPCATEGORY(POINTER) returns category of POINTER of CRNR.
			%  CATEGORY = Element.GETPROPCATEGORY(CosmicRayNoiseRemover, POINTER) returns category of POINTER of CosmicRayNoiseRemover.
			%  CATEGORY = CRNR.GETPROPCATEGORY(CosmicRayNoiseRemover, POINTER) returns category of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPCATEGORY(CRNR) and Element.GETPROPCATEGORY('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CosmicRayNoiseRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			cosmicraynoiseremover_category_list = { 1  1  1  3  4  2  2  6  4  6  9 };
			prop_category = cosmicraynoiseremover_category_list{prop};
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
			%  FORMAT = CRNR.GETPROPFORMAT(POINTER) returns format of POINTER of CRNR.
			%  FORMAT = Element.GETPROPFORMAT(CosmicRayNoiseRemover, POINTER) returns format of POINTER of CosmicRayNoiseRemover.
			%  FORMAT = CRNR.GETPROPFORMAT(CosmicRayNoiseRemover, POINTER) returns format of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPFORMAT(CRNR) and Element.GETPROPFORMAT('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CosmicRayNoiseRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			cosmicraynoiseremover_format_list = { 2  2  2  8  2  2  2  2  8  8  8 };
			prop_format = cosmicraynoiseremover_format_list{prop};
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
			%  DESCRIPTION = CRNR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CRNR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CosmicRayNoiseRemover, POINTER) returns description of POINTER of CosmicRayNoiseRemover.
			%  DESCRIPTION = CRNR.GETPROPDESCRIPTION(CosmicRayNoiseRemover, POINTER) returns description of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPDESCRIPTION(CRNR) and Element.GETPROPDESCRIPTION('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CosmicRayNoiseRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			cosmicraynoiseremover_description_list = { 'ELCLASS (constant, string) is the class of the Cosmic Ray Noise Remover.'  'NAME (constant, string) is the name of the Cosmic Ray Noise Remover.'  'DESCRIPTION (constant, string) is the description of Cosmic Ray Noise Remover.'  'TEMPLATE (parameter, item) is the template of the Cosmic Ray Noise Remover.'  'ID (data, string) is a few-letter code for the Cosmic Ray Noise Remover.'  'LABEL (metadata, string) is an extended label of the Cosmic Ray Noise Remover.'  'NOTES (metadata, string) are some specific notes about Cosmic Ray Noise Remover.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'RE_OUT (query, item) is the output Raman Experiment with fixed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the REAnalysisModule.' };
			prop_description = cosmicraynoiseremover_description_list{prop};
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
			%  SETTINGS = CRNR.GETPROPSETTINGS(POINTER) returns settings of POINTER of CRNR.
			%  SETTINGS = Element.GETPROPSETTINGS(CosmicRayNoiseRemover, POINTER) returns settings of POINTER of CosmicRayNoiseRemover.
			%  SETTINGS = CRNR.GETPROPSETTINGS(CosmicRayNoiseRemover, POINTER) returns settings of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPSETTINGS(CRNR) and Element.GETPROPSETTINGS('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CosmicRayNoiseRemover.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 4 % CosmicRayNoiseRemover.TEMPLATE
					prop_settings = 'CosmicRayNoiseRemover';
				case 10 % CosmicRayNoiseRemover.RE_OUT
					prop_settings = 'RamanExperiment';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CosmicRayNoiseRemover.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CosmicRayNoiseRemover.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CRNR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CRNR.
			%  DEFAULT = Element.GETPROPDEFAULT(CosmicRayNoiseRemover, POINTER) returns the default value of POINTER of CosmicRayNoiseRemover.
			%  DEFAULT = CRNR.GETPROPDEFAULT(CosmicRayNoiseRemover, POINTER) returns the default value of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPDEFAULT(CRNR) and Element.GETPROPDEFAULT('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CosmicRayNoiseRemover.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 1 % CosmicRayNoiseRemover.ELCLASS
					prop_default = 'CosmicRayNoiseRemover';
				case 2 % CosmicRayNoiseRemover.NAME
					prop_default = 'CosmicRayNoiseRemover';
				case 3 % CosmicRayNoiseRemover.DESCRIPTION
					prop_default = 'CosmicRayNoiseRemover reads and analyzes raw Raman spectra and evaluates and plots the resulting fixed spectra.';
				case 4 % CosmicRayNoiseRemover.TEMPLATE
					prop_default = Format.getFormatDefault(8, CosmicRayNoiseRemover.getPropSettings(prop));
				case 5 % CosmicRayNoiseRemover.ID
					prop_default = 'CosmicRayNoiseRemover ID';
				case 6 % CosmicRayNoiseRemover.LABEL
					prop_default = 'CosmicRayNoiseRemover label';
				case 7 % CosmicRayNoiseRemover.NOTES
					prop_default = 'CosmicRayNoiseRemover notes';
				case 10 % CosmicRayNoiseRemover.RE_OUT
					prop_default = Format.getFormatDefault(8, CosmicRayNoiseRemover.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CosmicRayNoiseRemover.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CosmicRayNoiseRemover.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CRNR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CRNR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CosmicRayNoiseRemover, POINTER) returns the conditioned default value of POINTER of CosmicRayNoiseRemover.
			%  DEFAULT = CRNR.GETPROPDEFAULTCONDITIONED(CosmicRayNoiseRemover, POINTER) returns the conditioned default value of POINTER of CosmicRayNoiseRemover.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CRNR) and Element.GETPROPDEFAULTCONDITIONED('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CosmicRayNoiseRemover.getPropProp(pointer);
			
			prop_default = CosmicRayNoiseRemover.conditioning(prop, CosmicRayNoiseRemover.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CRNR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CRNR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CRNR.
			%  CHECK = Element.CHECKPROP(CosmicRayNoiseRemover, PROP, VALUE) checks VALUE format for PROP of CosmicRayNoiseRemover.
			%  CHECK = CRNR.CHECKPROP(CosmicRayNoiseRemover, PROP, VALUE) checks VALUE format for PROP of CosmicRayNoiseRemover.
			% 
			% CRNR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:CosmicRayNoiseRemover:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CRNR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CRNR.
			%   Error id: BRAPH2:CosmicRayNoiseRemover:WrongInput
			%  Element.CHECKPROP(CosmicRayNoiseRemover, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CosmicRayNoiseRemover.
			%   Error id: BRAPH2:CosmicRayNoiseRemover:WrongInput
			%  CRNR.CHECKPROP(CosmicRayNoiseRemover, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CosmicRayNoiseRemover.
			%   Error id: BRAPH2:CosmicRayNoiseRemover:WrongInput]
			% 
			% Note that the Element.CHECKPROP(CRNR) and Element.CHECKPROP('CosmicRayNoiseRemover')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CosmicRayNoiseRemover.getPropProp(pointer);
			
			switch prop
				case 4 % CosmicRayNoiseRemover.TEMPLATE
					check = Format.checkFormat(8, value, CosmicRayNoiseRemover.getPropSettings(prop));
				case 10 % CosmicRayNoiseRemover.RE_OUT
					check = Format.checkFormat(8, value, CosmicRayNoiseRemover.getPropSettings(prop));
				otherwise
					if prop <= 11
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CosmicRayNoiseRemover:' 'WrongInput'], ...
					['BRAPH2' ':CosmicRayNoiseRemover:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CosmicRayNoiseRemover.getPropTag(prop) ' (' CosmicRayNoiseRemover.getFormatTag(CosmicRayNoiseRemover.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(crnr, prop, varargin)
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
				case 10 % CosmicRayNoiseRemover.RE_OUT
					% calculateValue using REAnalysisModule with parameters crnr and 'RE_OUT'; 
					% returns the query, which is assigned to the variable re_out
					re_out = calculateValue@REAnalysisModule(crnr, prop);
					
					% Create a copy of REAnalysisModule 'RE_OUT' 
					crnr_re_out = re_out;
					
					% Get the number of items in the indexed dictionary SP_DICT of
					% REAnalysisModule 'RE_OUT'
					dict_length = re_out.get('SP_DICT').get('LENGTH')
					
					for n = 1:1:dict_length
					     % Read raw intensities from the REAnalysisModule 'RE_OUT'
					     raw_intensities = re_out.get('SP_DICT').get('IT', n).get('INTENSITIES');
					
					     % Apply median filter to raw intensities
					     fixed_intensities = medfilt1(raw_intensities); 
					
					     % Set the intensities of the nth spectrum in the 'SP_DICT' of crnr_re_out 
					     % to fixed intensities evaluated using the nth raw spectrum of 
					     % REAnalysisModule
					     crnr_re_out.get('SP_DICT').get('IT', n).set('INTENSITIES', fixed_intensities)
					end
					
					% Memorize the updated 'SP_DICT'
					crnr_re_out.memorize('SP_DICT');
					
					% Set the re_out to RE_OUT
					value = crnr_re_out;
					
				otherwise
					if prop <= 11
						value = calculateValue@REAnalysisModule(crnr, prop, varargin{:});
					else
						value = calculateValue@Element(crnr, prop, varargin{:});
					end
			end
			
		end
	end
end
