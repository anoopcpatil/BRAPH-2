classdef CosmicRayRemover < ConcreteElement
	%CosmicRayRemover is a Raman pre-processing element that removes cosmic ray noise.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% A Cosmic Ray Remover (CosmicRayRemover) reads acquired raw Raman spectra from RamanExperiment element as a data matrix prop and calculates fixed spectra as a result matrix prop. Fixed spectra are the Raman spectra with cosmic ray noise removed.
	%
	% The list of CosmicRayRemover properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Cosmic Ray Remover.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Cosmic Ray Remover.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Cosmic Ray Remover.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Cosmic Ray Remover.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Cosmic Ray Remover.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Cosmic Ray Remover.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Cosmic Ray Remover.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the cloned Raman Experiment for reading the raw Raman spectra.
	%  <strong>10</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the Raman Experiment with cosmic-ray-noise removed spectra as a result.
	%
	% CosmicRayRemover methods (constructor):
	%  CosmicRayRemover - constructor
	%
	% CosmicRayRemover methods:
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
	% CosmicRayRemover methods (display):
	%  tostring - string with information about the Cosmic Ray Remover
	%  disp - displays information about the Cosmic Ray Remover
	%  tree - displays the tree of the Cosmic Ray Remover
	%
	% CosmicRayRemover methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Cosmic Ray Remover are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Cosmic Ray Remover
	%
	% CosmicRayRemover methods (save/load, Static):
	%  save - saves BRAPH2 Cosmic Ray Remover as b2 file
	%  load - loads a BRAPH2 Cosmic Ray Remover from a b2 file
	%
	% CosmicRayRemover method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Cosmic Ray Remover
	%
	% CosmicRayRemover method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Cosmic Ray Remover
	%
	% CosmicRayRemover methods (inspection, Static):
	%  getClass - returns the class of the Cosmic Ray Remover
	%  getSubclasses - returns all subclasses of CosmicRayRemover
	%  getProps - returns the property list of the Cosmic Ray Remover
	%  getPropNumber - returns the property number of the Cosmic Ray Remover
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
	% CosmicRayRemover methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% CosmicRayRemover methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% CosmicRayRemover methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% CosmicRayRemover methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?CosmicRayRemover; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">CosmicRayRemover constants</a>.
	%
	%
	% See also RamanExperiment, Spectrum

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
	
	properties (Constant) % properties
		RE_IN = 9; %CET: Computational Efficiency Trick
		RE_IN_TAG = 'RE_IN';
		RE_IN_CATEGORY = 4;
		RE_IN_FORMAT = 8;
		
		RE_OUT = 10; %CET: Computational Efficiency Trick
		RE_OUT_TAG = 'RE_OUT';
		RE_OUT_CATEGORY = 5;
		RE_OUT_FORMAT = 8;
	end
	methods % constructor
		function crr = CosmicRayRemover(varargin)
			%CosmicRayRemover() creates a Cosmic Ray Remover.
			%
			% CosmicRayRemover(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% CosmicRayRemover(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of CosmicRayRemover properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Cosmic Ray Remover.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Cosmic Ray Remover.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Cosmic Ray Remover.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Cosmic Ray Remover.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Cosmic Ray Remover.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Cosmic Ray Remover.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Cosmic Ray Remover.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the cloned Raman Experiment for reading the raw Raman spectra.
			%  <strong>10</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the Raman Experiment with cosmic-ray-noise removed spectra as a result.
			%
			% See also Category, Format.
			
			crr = crr@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function crr_class = getClass()
			%GETCLASS returns the class of the Cosmic Ray Remover.
			%
			% CLASS = CosmicRayRemover.GETCLASS() returns the class 'CosmicRayRemover'.
			%
			% Alternative forms to call this method are:
			%  CLASS = CRR.GETCLASS() returns the class of the Cosmic Ray Remover CRR.
			%  CLASS = Element.GETCLASS(CRR) returns the class of 'CRR'.
			%  CLASS = Element.GETCLASS('CosmicRayRemover') returns 'CosmicRayRemover'.
			%
			% Note that the Element.GETCLASS(CRR) and Element.GETCLASS('CosmicRayRemover')
			%  are less computationally efficient.
			
			crr_class = 'CosmicRayRemover';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Cosmic Ray Remover.
			%
			% LIST = CosmicRayRemover.GETSUBCLASSES() returns all subclasses of 'CosmicRayRemover'.
			%
			% Alternative forms to call this method are:
			%  LIST = CRR.GETSUBCLASSES() returns all subclasses of the Cosmic Ray Remover CRR.
			%  LIST = Element.GETSUBCLASSES(CRR) returns all subclasses of 'CRR'.
			%  LIST = Element.GETSUBCLASSES('CosmicRayRemover') returns all subclasses of 'CosmicRayRemover'.
			%
			% Note that the Element.GETSUBCLASSES(CRR) and Element.GETSUBCLASSES('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'CosmicRayRemover' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Cosmic Ray Remover.
			%
			% PROPS = CosmicRayRemover.GETPROPS() returns the property list of Cosmic Ray Remover
			%  as a row vector.
			%
			% PROPS = CosmicRayRemover.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = CRR.GETPROPS([CATEGORY]) returns the property list of the Cosmic Ray Remover CRR.
			%  PROPS = Element.GETPROPS(CRR[, CATEGORY]) returns the property list of 'CRR'.
			%  PROPS = Element.GETPROPS('CosmicRayRemover'[, CATEGORY]) returns the property list of 'CosmicRayRemover'.
			%
			% Note that the Element.GETPROPS(CRR) and Element.GETPROPS('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10];
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
					prop_list = 10;
				case 6 % Category.QUERY
					prop_list = 8;
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of Cosmic Ray Remover.
			%
			% N = CosmicRayRemover.GETPROPNUMBER() returns the property number of Cosmic Ray Remover.
			%
			% N = CosmicRayRemover.GETPROPNUMBER(CATEGORY) returns the property number of Cosmic Ray Remover
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = CRR.GETPROPNUMBER([CATEGORY]) returns the property number of the Cosmic Ray Remover CRR.
			%  N = Element.GETPROPNUMBER(CRR) returns the property number of 'CRR'.
			%  N = Element.GETPROPNUMBER('CosmicRayRemover') returns the property number of 'CosmicRayRemover'.
			%
			% Note that the Element.GETPROPNUMBER(CRR) and Element.GETPROPNUMBER('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 10;
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
					prop_number = 1;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in Cosmic Ray Remover/error.
			%
			% CHECK = CosmicRayRemover.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CRR.EXISTSPROP(PROP) checks whether PROP exists for CRR.
			%  CHECK = Element.EXISTSPROP(CRR, PROP) checks whether PROP exists for CRR.
			%  CHECK = Element.EXISTSPROP(CosmicRayRemover, PROP) checks whether PROP exists for CosmicRayRemover.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CRR.EXISTSPROP(PROP) throws error if PROP does NOT exist for CRR.
			%   Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%  Element.EXISTSPROP(CRR, PROP) throws error if PROP does NOT exist for CRR.
			%   Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%  Element.EXISTSPROP(CosmicRayRemover, PROP) throws error if PROP does NOT exist for CosmicRayRemover.
			%   Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%
			% Note that the Element.EXISTSPROP(CRR) and Element.EXISTSPROP('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 10 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CosmicRayRemover:' 'WrongInput'], ...
					['BRAPH2' ':CosmicRayRemover:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for CosmicRayRemover.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Cosmic Ray Remover/error.
			%
			% CHECK = CosmicRayRemover.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = CRR.EXISTSTAG(TAG) checks whether TAG exists for CRR.
			%  CHECK = Element.EXISTSTAG(CRR, TAG) checks whether TAG exists for CRR.
			%  CHECK = Element.EXISTSTAG(CosmicRayRemover, TAG) checks whether TAG exists for CosmicRayRemover.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%
			% Alternative forms to call this method are:
			%  CRR.EXISTSTAG(TAG) throws error if TAG does NOT exist for CRR.
			%   Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%  Element.EXISTSTAG(CRR, TAG) throws error if TAG does NOT exist for CRR.
			%   Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%  Element.EXISTSTAG(CosmicRayRemover, TAG) throws error if TAG does NOT exist for CosmicRayRemover.
			%   Error id: [BRAPH2:CosmicRayRemover:WrongInput]
			%
			% Note that the Element.EXISTSTAG(CRR) and Element.EXISTSTAG('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CosmicRayRemover:' 'WrongInput'], ...
					['BRAPH2' ':CosmicRayRemover:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for CosmicRayRemover.'] ...
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
			%  PROPERTY = CRR.GETPROPPROP(POINTER) returns property number of POINTER of CRR.
			%  PROPERTY = Element.GETPROPPROP(CosmicRayRemover, POINTER) returns property number of POINTER of CosmicRayRemover.
			%  PROPERTY = CRR.GETPROPPROP(CosmicRayRemover, POINTER) returns property number of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPPROP(CRR) and Element.GETPROPPROP('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = CRR.GETPROPTAG(POINTER) returns tag of POINTER of CRR.
			%  TAG = Element.GETPROPTAG(CosmicRayRemover, POINTER) returns tag of POINTER of CosmicRayRemover.
			%  TAG = CRR.GETPROPTAG(CosmicRayRemover, POINTER) returns tag of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPTAG(CRR) and Element.GETPROPTAG('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				cosmicrayremover_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'RE_OUT' };
				tag = cosmicrayremover_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = CRR.GETPROPCATEGORY(POINTER) returns category of POINTER of CRR.
			%  CATEGORY = Element.GETPROPCATEGORY(CosmicRayRemover, POINTER) returns category of POINTER of CosmicRayRemover.
			%  CATEGORY = CRR.GETPROPCATEGORY(CosmicRayRemover, POINTER) returns category of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPCATEGORY(CRR) and Element.GETPROPCATEGORY('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = CosmicRayRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			cosmicrayremover_category_list = { 1  1  1  3  4  2  2  6  4  5 };
			prop_category = cosmicrayremover_category_list{prop};
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
			%  FORMAT = CRR.GETPROPFORMAT(POINTER) returns format of POINTER of CRR.
			%  FORMAT = Element.GETPROPFORMAT(CosmicRayRemover, POINTER) returns format of POINTER of CosmicRayRemover.
			%  FORMAT = CRR.GETPROPFORMAT(CosmicRayRemover, POINTER) returns format of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPFORMAT(CRR) and Element.GETPROPFORMAT('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = CosmicRayRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			cosmicrayremover_format_list = { 2  2  2  8  2  2  2  2  8  8 };
			prop_format = cosmicrayremover_format_list{prop};
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
			%  DESCRIPTION = CRR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of CRR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(CosmicRayRemover, POINTER) returns description of POINTER of CosmicRayRemover.
			%  DESCRIPTION = CRR.GETPROPDESCRIPTION(CosmicRayRemover, POINTER) returns description of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPDESCRIPTION(CRR) and Element.GETPROPDESCRIPTION('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = CosmicRayRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			cosmicrayremover_description_list = { 'ELCLASS (constant, string) is the class of the Cosmic Ray Remover.'  'NAME (constant, string) is the name of the Cosmic Ray Remover.'  'DESCRIPTION (constant, string) is the description of Cosmic Ray Remover.'  'TEMPLATE (parameter, item) is the template of the Cosmic Ray Remover.'  'ID (data, string) is a few-letter code for the Cosmic Ray Remover.'  'LABEL (metadata, string) is an extended label of the Cosmic Ray Remover.'  'NOTES (metadata, string) are some specific notes about Cosmic Ray Remover.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the cloned Raman Experiment for reading the raw Raman spectra.'  'RE_OUT (result, item) is the Raman Experiment with cosmic-ray-noise removed spectra as a result.' };
			prop_description = cosmicrayremover_description_list{prop};
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
			%  SETTINGS = CRR.GETPROPSETTINGS(POINTER) returns settings of POINTER of CRR.
			%  SETTINGS = Element.GETPROPSETTINGS(CosmicRayRemover, POINTER) returns settings of POINTER of CosmicRayRemover.
			%  SETTINGS = CRR.GETPROPSETTINGS(CosmicRayRemover, POINTER) returns settings of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPSETTINGS(CRR) and Element.GETPROPSETTINGS('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = CosmicRayRemover.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % CosmicRayRemover.RE_IN
					prop_settings = 'RamanExperiment';
				case 10 % CosmicRayRemover.RE_OUT
					prop_settings = 'RamanExperiment';
				case 4 % CosmicRayRemover.TEMPLATE
					prop_settings = 'CosmicRayRemover';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = CosmicRayRemover.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = CosmicRayRemover.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CRR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of CRR.
			%  DEFAULT = Element.GETPROPDEFAULT(CosmicRayRemover, POINTER) returns the default value of POINTER of CosmicRayRemover.
			%  DEFAULT = CRR.GETPROPDEFAULT(CosmicRayRemover, POINTER) returns the default value of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPDEFAULT(CRR) and Element.GETPROPDEFAULT('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = CosmicRayRemover.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % CosmicRayRemover.RE_IN
					prop_default = Format.getFormatDefault(8, CosmicRayRemover.getPropSettings(prop));
				case 10 % CosmicRayRemover.RE_OUT
					prop_default = Format.getFormatDefault(8, CosmicRayRemover.getPropSettings(prop));
				case 1 % CosmicRayRemover.ELCLASS
					prop_default = 'CosmicRayRemover';
				case 2 % CosmicRayRemover.NAME
					prop_default = 'CosmicRayRemover';
				case 3 % CosmicRayRemover.DESCRIPTION
					prop_default = 'CosmicRayRemover reads acquired raw Raman spectral intensities from RamanExperiment element and calculates fixed spectra';
				case 4 % CosmicRayRemover.TEMPLATE
					prop_default = Format.getFormatDefault(8, CosmicRayRemover.getPropSettings(prop));
				case 5 % CosmicRayRemover.ID
					prop_default = 'CosmicRayRemover ID';
				case 6 % CosmicRayRemover.LABEL
					prop_default = 'CosmicRayRemover label';
				case 7 % CosmicRayRemover.NOTES
					prop_default = 'CosmicRayRemover notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = CosmicRayRemover.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = CosmicRayRemover.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = CRR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of CRR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(CosmicRayRemover, POINTER) returns the conditioned default value of POINTER of CosmicRayRemover.
			%  DEFAULT = CRR.GETPROPDEFAULTCONDITIONED(CosmicRayRemover, POINTER) returns the conditioned default value of POINTER of CosmicRayRemover.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(CRR) and Element.GETPROPDEFAULTCONDITIONED('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = CosmicRayRemover.getPropProp(pointer);
			
			prop_default = CosmicRayRemover.conditioning(prop, CosmicRayRemover.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = CRR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = CRR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of CRR.
			%  CHECK = Element.CHECKPROP(CosmicRayRemover, PROP, VALUE) checks VALUE format for PROP of CosmicRayRemover.
			%  CHECK = CRR.CHECKPROP(CosmicRayRemover, PROP, VALUE) checks VALUE format for PROP of CosmicRayRemover.
			% 
			% CRR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:CosmicRayRemover:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CRR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of CRR.
			%   Error id: BRAPH2:CosmicRayRemover:WrongInput
			%  Element.CHECKPROP(CosmicRayRemover, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CosmicRayRemover.
			%   Error id: BRAPH2:CosmicRayRemover:WrongInput
			%  CRR.CHECKPROP(CosmicRayRemover, PROP, VALUE) throws error if VALUE has not a valid format for PROP of CosmicRayRemover.
			%   Error id: BRAPH2:CosmicRayRemover:WrongInput]
			% 
			% Note that the Element.CHECKPROP(CRR) and Element.CHECKPROP('CosmicRayRemover')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = CosmicRayRemover.getPropProp(pointer);
			
			switch prop
				case 9 % CosmicRayRemover.RE_IN
					check = Format.checkFormat(8, value, CosmicRayRemover.getPropSettings(prop));
				case 10 % CosmicRayRemover.RE_OUT
					check = Format.checkFormat(8, value, CosmicRayRemover.getPropSettings(prop));
				case 4 % CosmicRayRemover.TEMPLATE
					check = Format.checkFormat(8, value, CosmicRayRemover.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':CosmicRayRemover:' 'WrongInput'], ...
					['BRAPH2' ':CosmicRayRemover:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' CosmicRayRemover.getPropTag(prop) ' (' CosmicRayRemover.getFormatTag(CosmicRayRemover.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(crr, prop, varargin)
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
				case 10 % CosmicRayRemover.RE_OUT
					rng_settings_ = rng(); rng(crr.getPropSeed(10), 'twister')
					
					% Temporary Raman Experiment
					re_out = RamanExperiment('ID', crr.get('RE_IN').get('ID'), ...
					                          'LABEL', crr.get('RE_IN').get('LABEL'), ...
					                          'NOTES', crr.get('RE_IN').get('NOTES'))
					
					for n = 1:1:crr.get('RE_IN').get('SP_DICT').get('LENGTH')
					     raw_intensities = crr.get('RE_IN').get('SP_DICT').get('IT', n).get('INTENSITIES');
					     fixed_intensities = medfilt1(raw_intensities);
					
					     sp = Spectrum( ...
					         'INTENSITIES', fixed_intensities, ...
					         'WAVELENGTH', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('WAVELENGTH'), ...
					         'ID', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('ID'), ...
					         'LABEL', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('LABEL'), ...
					         'NOTES', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('NOTES'))
					
					     re_out.memorize('SP_DICT').get('ADD', sp)
					end
					value = re_out;
					
					
					
					% %% ¡prop!
					% PFRE (gui, item) is a container of the panel figure for a RamanExperiment.
					% %% ¡settings!
					% 'RamanExperimentPF'
					% %% ¡postprocessing!
					% if isa(crr.getr('PFRE'), 'NoValue')
					%     crr.memorize('PFRE').set('RE', crr.get('RE_OUT'))
					% end
					% %% ¡gui!
					% pr = PanelPropItem('EL', crr, 'PROP', CosmicRayRemover.PFRE, ...
					%     'GUICLASS', 'GUIFig', ...
					%     'BUTTON_TEXT', 'Plot Fixed Intensities', ...
					%     varargin{:});
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(crr, prop, varargin{:});
					else
						value = calculateValue@Element(crr, prop, varargin{:});
					end
			end
			
		end
	end
end
