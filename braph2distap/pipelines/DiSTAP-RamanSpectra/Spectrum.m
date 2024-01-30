classdef Spectrum < ConcreteElement
	%Spectrum is a spectrum.
	% It is a subclass of <a href="matlab:help ConcreteElement">ConcreteElement</a>.
	%
	% Spectrum contains an acquired spectrum including its wavelength and intensity.
	%
	% The list of Spectrum properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the spectrum.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the spectrum.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the spectrum.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the spectrum.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the spectrum.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the spectrum.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the spectrum.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>CALIBRATION</strong> 	CALIBRATION (data, logical) determines whether it is a calibration spectrum.
	%  <strong>10</strong> <strong>WAVELENGTH</strong> 	WAVELENGTH (data, cvector) is the vector of the wavelengths at which the spectrum is acquired.
	%  <strong>11</strong> <strong>WAVELENGTH_LABELS</strong> 	WAVELENGTH_LABELS (query, stringlist) is the labels for the wavelengths.
	%  <strong>12</strong> <strong>INTENSITIES</strong> 	INTENSITIES (data, matrix) is the intensities of the spectra (one spectrum per column).
	%  <strong>13</strong> <strong>NO_AQUISITIONS</strong> 	NO_AQUISITIONS (query, scalar) is the numebr of acquisitions.
	%  <strong>14</strong> <strong>INTENSITY</strong> 	INTENSITY (query, cvector) is the intesity of the a spectrum.
	%  <strong>15</strong> <strong>INTENSITY_MEAN</strong> 	INTENSITY_MEAN (query, cvector) is the average intesity of the spectra.
	%
	% Spectrum methods (constructor):
	%  Spectrum - constructor
	%
	% Spectrum methods:
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
	% Spectrum methods (display):
	%  tostring - string with information about the spectrum
	%  disp - displays information about the spectrum
	%  tree - displays the tree of the spectrum
	%
	% Spectrum methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two spectrum are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the spectrum
	%
	% Spectrum methods (save/load, Static):
	%  save - saves BRAPH2 spectrum as b2 file
	%  load - loads a BRAPH2 spectrum from a b2 file
	%
	% Spectrum method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the spectrum
	%
	% Spectrum method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the spectrum
	%
	% Spectrum methods (inspection, Static):
	%  getClass - returns the class of the spectrum
	%  getSubclasses - returns all subclasses of Spectrum
	%  getProps - returns the property list of the spectrum
	%  getPropNumber - returns the property number of the spectrum
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
	% Spectrum methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% Spectrum methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% Spectrum methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% Spectrum methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?Spectrum; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">Spectrum constants</a>.
	%
	%
	% See also RamanExperiment.
	
	properties (Constant) % properties
		CALIBRATION = 9; %CET: Computational Efficiency Trick
		CALIBRATION_TAG = 'CALIBRATION';
		CALIBRATION_CATEGORY = 4;
		CALIBRATION_FORMAT = 4;
		
		WAVELENGTH = 10; %CET: Computational Efficiency Trick
		WAVELENGTH_TAG = 'WAVELENGTH';
		WAVELENGTH_CATEGORY = 4;
		WAVELENGTH_FORMAT = 13;
		
		WAVELENGTH_LABELS = 11; %CET: Computational Efficiency Trick
		WAVELENGTH_LABELS_TAG = 'WAVELENGTH_LABELS';
		WAVELENGTH_LABELS_CATEGORY = 6;
		WAVELENGTH_LABELS_FORMAT = 3;
		
		INTENSITIES = 12; %CET: Computational Efficiency Trick
		INTENSITIES_TAG = 'INTENSITIES';
		INTENSITIES_CATEGORY = 4;
		INTENSITIES_FORMAT = 14;
		
		NO_AQUISITIONS = 13; %CET: Computational Efficiency Trick
		NO_AQUISITIONS_TAG = 'NO_AQUISITIONS';
		NO_AQUISITIONS_CATEGORY = 6;
		NO_AQUISITIONS_FORMAT = 11;
		
		INTENSITY = 14; %CET: Computational Efficiency Trick
		INTENSITY_TAG = 'INTENSITY';
		INTENSITY_CATEGORY = 6;
		INTENSITY_FORMAT = 13;
		
		INTENSITY_MEAN = 15; %CET: Computational Efficiency Trick
		INTENSITY_MEAN_TAG = 'INTENSITY_MEAN';
		INTENSITY_MEAN_CATEGORY = 6;
		INTENSITY_MEAN_FORMAT = 13;
	end
	methods % constructor
		function sp = Spectrum(varargin)
			%Spectrum() creates a spectrum.
			%
			% Spectrum(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% Spectrum(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of Spectrum properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the spectrum.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the spectrum.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the spectrum.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the spectrum.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the spectrum.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the spectrum.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the spectrum.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>CALIBRATION</strong> 	CALIBRATION (data, logical) determines whether it is a calibration spectrum.
			%  <strong>10</strong> <strong>WAVELENGTH</strong> 	WAVELENGTH (data, cvector) is the vector of the wavelengths at which the spectrum is acquired.
			%  <strong>11</strong> <strong>WAVELENGTH_LABELS</strong> 	WAVELENGTH_LABELS (query, stringlist) is the labels for the wavelengths.
			%  <strong>12</strong> <strong>INTENSITIES</strong> 	INTENSITIES (data, matrix) is the intensities of the spectra (one spectrum per column).
			%  <strong>13</strong> <strong>NO_AQUISITIONS</strong> 	NO_AQUISITIONS (query, scalar) is the numebr of acquisitions.
			%  <strong>14</strong> <strong>INTENSITY</strong> 	INTENSITY (query, cvector) is the intesity of the a spectrum.
			%  <strong>15</strong> <strong>INTENSITY_MEAN</strong> 	INTENSITY_MEAN (query, cvector) is the average intesity of the spectra.
			%
			% See also Category, Format.
			
			sp = sp@ConcreteElement(varargin{:});
		end
	end
	methods (Static) % inspection
		function sp_class = getClass()
			%GETCLASS returns the class of the spectrum.
			%
			% CLASS = Spectrum.GETCLASS() returns the class 'Spectrum'.
			%
			% Alternative forms to call this method are:
			%  CLASS = SP.GETCLASS() returns the class of the spectrum SP.
			%  CLASS = Element.GETCLASS(SP) returns the class of 'SP'.
			%  CLASS = Element.GETCLASS('Spectrum') returns 'Spectrum'.
			%
			% Note that the Element.GETCLASS(SP) and Element.GETCLASS('Spectrum')
			%  are less computationally efficient.
			
			sp_class = 'Spectrum';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the spectrum.
			%
			% LIST = Spectrum.GETSUBCLASSES() returns all subclasses of 'Spectrum'.
			%
			% Alternative forms to call this method are:
			%  LIST = SP.GETSUBCLASSES() returns all subclasses of the spectrum SP.
			%  LIST = Element.GETSUBCLASSES(SP) returns all subclasses of 'SP'.
			%  LIST = Element.GETSUBCLASSES('Spectrum') returns all subclasses of 'Spectrum'.
			%
			% Note that the Element.GETSUBCLASSES(SP) and Element.GETSUBCLASSES('Spectrum')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'Spectrum' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of spectrum.
			%
			% PROPS = Spectrum.GETPROPS() returns the property list of spectrum
			%  as a row vector.
			%
			% PROPS = Spectrum.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = SP.GETPROPS([CATEGORY]) returns the property list of the spectrum SP.
			%  PROPS = Element.GETPROPS(SP[, CATEGORY]) returns the property list of 'SP'.
			%  PROPS = Element.GETPROPS('Spectrum'[, CATEGORY]) returns the property list of 'Spectrum'.
			%
			% Note that the Element.GETPROPS(SP) and Element.GETPROPS('Spectrum')
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
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = [5 9 10 12];
				case 6 % Category.QUERY
					prop_list = [8 11 13 14 15];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of spectrum.
			%
			% N = Spectrum.GETPROPNUMBER() returns the property number of spectrum.
			%
			% N = Spectrum.GETPROPNUMBER(CATEGORY) returns the property number of spectrum
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = SP.GETPROPNUMBER([CATEGORY]) returns the property number of the spectrum SP.
			%  N = Element.GETPROPNUMBER(SP) returns the property number of 'SP'.
			%  N = Element.GETPROPNUMBER('Spectrum') returns the property number of 'Spectrum'.
			%
			% Note that the Element.GETPROPNUMBER(SP) and Element.GETPROPNUMBER('Spectrum')
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
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 4;
				case 6 % Category.QUERY
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in spectrum/error.
			%
			% CHECK = Spectrum.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SP.EXISTSPROP(PROP) checks whether PROP exists for SP.
			%  CHECK = Element.EXISTSPROP(SP, PROP) checks whether PROP exists for SP.
			%  CHECK = Element.EXISTSPROP(Spectrum, PROP) checks whether PROP exists for Spectrum.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:Spectrum:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SP.EXISTSPROP(PROP) throws error if PROP does NOT exist for SP.
			%   Error id: [BRAPH2:Spectrum:WrongInput]
			%  Element.EXISTSPROP(SP, PROP) throws error if PROP does NOT exist for SP.
			%   Error id: [BRAPH2:Spectrum:WrongInput]
			%  Element.EXISTSPROP(Spectrum, PROP) throws error if PROP does NOT exist for Spectrum.
			%   Error id: [BRAPH2:Spectrum:WrongInput]
			%
			% Note that the Element.EXISTSPROP(SP) and Element.EXISTSPROP('Spectrum')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 15 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Spectrum:' 'WrongInput'], ...
					['BRAPH2' ':Spectrum:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for Spectrum.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in spectrum/error.
			%
			% CHECK = Spectrum.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = SP.EXISTSTAG(TAG) checks whether TAG exists for SP.
			%  CHECK = Element.EXISTSTAG(SP, TAG) checks whether TAG exists for SP.
			%  CHECK = Element.EXISTSTAG(Spectrum, TAG) checks whether TAG exists for Spectrum.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:Spectrum:WrongInput]
			%
			% Alternative forms to call this method are:
			%  SP.EXISTSTAG(TAG) throws error if TAG does NOT exist for SP.
			%   Error id: [BRAPH2:Spectrum:WrongInput]
			%  Element.EXISTSTAG(SP, TAG) throws error if TAG does NOT exist for SP.
			%   Error id: [BRAPH2:Spectrum:WrongInput]
			%  Element.EXISTSTAG(Spectrum, TAG) throws error if TAG does NOT exist for Spectrum.
			%   Error id: [BRAPH2:Spectrum:WrongInput]
			%
			% Note that the Element.EXISTSTAG(SP) and Element.EXISTSTAG('Spectrum')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'CALIBRATION'  'WAVELENGTH'  'WAVELENGTH_LABELS'  'INTENSITIES'  'NO_AQUISITIONS'  'INTENSITY'  'INTENSITY_MEAN' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Spectrum:' 'WrongInput'], ...
					['BRAPH2' ':Spectrum:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for Spectrum.'] ...
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
			%  PROPERTY = SP.GETPROPPROP(POINTER) returns property number of POINTER of SP.
			%  PROPERTY = Element.GETPROPPROP(Spectrum, POINTER) returns property number of POINTER of Spectrum.
			%  PROPERTY = SP.GETPROPPROP(Spectrum, POINTER) returns property number of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPPROP(SP) and Element.GETPROPPROP('Spectrum')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'CALIBRATION'  'WAVELENGTH'  'WAVELENGTH_LABELS'  'INTENSITIES'  'NO_AQUISITIONS'  'INTENSITY'  'INTENSITY_MEAN' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = SP.GETPROPTAG(POINTER) returns tag of POINTER of SP.
			%  TAG = Element.GETPROPTAG(Spectrum, POINTER) returns tag of POINTER of Spectrum.
			%  TAG = SP.GETPROPTAG(Spectrum, POINTER) returns tag of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPTAG(SP) and Element.GETPROPTAG('Spectrum')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				spectrum_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'CALIBRATION'  'WAVELENGTH'  'WAVELENGTH_LABELS'  'INTENSITIES'  'NO_AQUISITIONS'  'INTENSITY'  'INTENSITY_MEAN' };
				tag = spectrum_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = SP.GETPROPCATEGORY(POINTER) returns category of POINTER of SP.
			%  CATEGORY = Element.GETPROPCATEGORY(Spectrum, POINTER) returns category of POINTER of Spectrum.
			%  CATEGORY = SP.GETPROPCATEGORY(Spectrum, POINTER) returns category of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPCATEGORY(SP) and Element.GETPROPCATEGORY('Spectrum')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = Spectrum.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			spectrum_category_list = { 1  1  1  3  4  2  2  6  4  4  6  4  6  6  6 };
			prop_category = spectrum_category_list{prop};
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
			%  FORMAT = SP.GETPROPFORMAT(POINTER) returns format of POINTER of SP.
			%  FORMAT = Element.GETPROPFORMAT(Spectrum, POINTER) returns format of POINTER of Spectrum.
			%  FORMAT = SP.GETPROPFORMAT(Spectrum, POINTER) returns format of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPFORMAT(SP) and Element.GETPROPFORMAT('Spectrum')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = Spectrum.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			spectrum_format_list = { 2  2  2  8  2  2  2  2  4  13  3  14  11  13  13 };
			prop_format = spectrum_format_list{prop};
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
			%  DESCRIPTION = SP.GETPROPDESCRIPTION(POINTER) returns description of POINTER of SP.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(Spectrum, POINTER) returns description of POINTER of Spectrum.
			%  DESCRIPTION = SP.GETPROPDESCRIPTION(Spectrum, POINTER) returns description of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPDESCRIPTION(SP) and Element.GETPROPDESCRIPTION('Spectrum')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = Spectrum.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			spectrum_description_list = { 'ELCLASS (constant, string) is the class of the spectrum.'  'NAME (constant, string) is the name of the spectrum.'  'DESCRIPTION (constant, string) is the description of the spectrum.'  'TEMPLATE (parameter, item) is the template of the spectrum.'  'ID (data, string) is a few-letter code for the spectrum.'  'LABEL (metadata, string) is an extended label of the spectrum.'  'NOTES (metadata, string) are some specific notes about the spectrum.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'CALIBRATION (data, logical) determines whether it is a calibration spectrum.'  'WAVELENGTH (data, cvector) is the vector of the wavelengths at which the spectrum is acquired.'  'WAVELENGTH_LABELS (query, stringlist) is the labels for the wavelengths.'  'INTENSITIES (data, matrix) is the intensities of the spectra (one spectrum per column).'  'NO_AQUISITIONS (query, scalar) is the numebr of acquisitions.'  'INTENSITY (query, cvector) is the intesity of the a spectrum.'  'INTENSITY_MEAN (query, cvector) is the average intesity of the spectra.' };
			prop_description = spectrum_description_list{prop};
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
			%  SETTINGS = SP.GETPROPSETTINGS(POINTER) returns settings of POINTER of SP.
			%  SETTINGS = Element.GETPROPSETTINGS(Spectrum, POINTER) returns settings of POINTER of Spectrum.
			%  SETTINGS = SP.GETPROPSETTINGS(Spectrum, POINTER) returns settings of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPSETTINGS(SP) and Element.GETPROPSETTINGS('Spectrum')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = Spectrum.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Spectrum.CALIBRATION
					prop_settings = Format.getFormatSettings(4);
				case 10 % Spectrum.WAVELENGTH
					prop_settings = Format.getFormatSettings(13);
				case 11 % Spectrum.WAVELENGTH_LABELS
					prop_settings = Format.getFormatSettings(3);
				case 12 % Spectrum.INTENSITIES
					prop_settings = Format.getFormatSettings(14);
				case 13 % Spectrum.NO_AQUISITIONS
					prop_settings = Format.getFormatSettings(11);
				case 14 % Spectrum.INTENSITY
					prop_settings = Format.getFormatSettings(13);
				case 15 % Spectrum.INTENSITY_MEAN
					prop_settings = Format.getFormatSettings(13);
				case 4 % Spectrum.TEMPLATE
					prop_settings = 'Spectrum';
				otherwise
					prop_settings = getPropSettings@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = Spectrum.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = Spectrum.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SP.GETPROPDEFAULT(POINTER) returns the default value of POINTER of SP.
			%  DEFAULT = Element.GETPROPDEFAULT(Spectrum, POINTER) returns the default value of POINTER of Spectrum.
			%  DEFAULT = SP.GETPROPDEFAULT(Spectrum, POINTER) returns the default value of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPDEFAULT(SP) and Element.GETPROPDEFAULT('Spectrum')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = Spectrum.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 9 % Spectrum.CALIBRATION
					prop_default = Format.getFormatDefault(4, Spectrum.getPropSettings(prop));
				case 10 % Spectrum.WAVELENGTH
					prop_default = Format.getFormatDefault(13, Spectrum.getPropSettings(prop));
				case 11 % Spectrum.WAVELENGTH_LABELS
					prop_default = Format.getFormatDefault(3, Spectrum.getPropSettings(prop));
				case 12 % Spectrum.INTENSITIES
					prop_default = Format.getFormatDefault(14, Spectrum.getPropSettings(prop));
				case 13 % Spectrum.NO_AQUISITIONS
					prop_default = Format.getFormatDefault(11, Spectrum.getPropSettings(prop));
				case 14 % Spectrum.INTENSITY
					prop_default = Format.getFormatDefault(13, Spectrum.getPropSettings(prop));
				case 15 % Spectrum.INTENSITY_MEAN
					prop_default = Format.getFormatDefault(13, Spectrum.getPropSettings(prop));
				case 1 % Spectrum.ELCLASS
					prop_default = 'Spectrum';
				case 2 % Spectrum.NAME
					prop_default = 'spectrum';
				case 3 % Spectrum.DESCRIPTION
					prop_default = 'Spectrum contains an acquired spectrum including its wavelength and intensity.';
				case 4 % Spectrum.TEMPLATE
					prop_default = Format.getFormatDefault(8, Spectrum.getPropSettings(prop));
				case 5 % Spectrum.ID
					prop_default = 'Spectrum ID';
				case 6 % Spectrum.LABEL
					prop_default = 'Spectrum label';
				case 7 % Spectrum.NOTES
					prop_default = 'Spectrum notes';
				otherwise
					prop_default = getPropDefault@ConcreteElement(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = Spectrum.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = Spectrum.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = SP.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of SP.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(Spectrum, POINTER) returns the conditioned default value of POINTER of Spectrum.
			%  DEFAULT = SP.GETPROPDEFAULTCONDITIONED(Spectrum, POINTER) returns the conditioned default value of POINTER of Spectrum.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(SP) and Element.GETPROPDEFAULTCONDITIONED('Spectrum')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = Spectrum.getPropProp(pointer);
			
			prop_default = Spectrum.conditioning(prop, Spectrum.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = SP.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = SP.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of SP.
			%  CHECK = Element.CHECKPROP(Spectrum, PROP, VALUE) checks VALUE format for PROP of Spectrum.
			%  CHECK = SP.CHECKPROP(Spectrum, PROP, VALUE) checks VALUE format for PROP of Spectrum.
			% 
			% SP.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:Spectrum:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  SP.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of SP.
			%   Error id: BRAPH2:Spectrum:WrongInput
			%  Element.CHECKPROP(Spectrum, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Spectrum.
			%   Error id: BRAPH2:Spectrum:WrongInput
			%  SP.CHECKPROP(Spectrum, PROP, VALUE) throws error if VALUE has not a valid format for PROP of Spectrum.
			%   Error id: BRAPH2:Spectrum:WrongInput]
			% 
			% Note that the Element.CHECKPROP(SP) and Element.CHECKPROP('Spectrum')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = Spectrum.getPropProp(pointer);
			
			switch prop
				case 9 % Spectrum.CALIBRATION
					check = Format.checkFormat(4, value, Spectrum.getPropSettings(prop));
				case 10 % Spectrum.WAVELENGTH
					check = Format.checkFormat(13, value, Spectrum.getPropSettings(prop));
				case 11 % Spectrum.WAVELENGTH_LABELS
					check = Format.checkFormat(3, value, Spectrum.getPropSettings(prop));
				case 12 % Spectrum.INTENSITIES
					check = Format.checkFormat(14, value, Spectrum.getPropSettings(prop));
				case 13 % Spectrum.NO_AQUISITIONS
					check = Format.checkFormat(11, value, Spectrum.getPropSettings(prop));
				case 14 % Spectrum.INTENSITY
					check = Format.checkFormat(13, value, Spectrum.getPropSettings(prop));
				case 15 % Spectrum.INTENSITY_MEAN
					check = Format.checkFormat(13, value, Spectrum.getPropSettings(prop));
				case 4 % Spectrum.TEMPLATE
					check = Format.checkFormat(8, value, Spectrum.getPropSettings(prop));
				otherwise
					if prop <= 8
						check = checkProp@ConcreteElement(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':Spectrum:' 'WrongInput'], ...
					['BRAPH2' ':Spectrum:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' Spectrum.getPropTag(prop) ' (' Spectrum.getFormatTag(Spectrum.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(sp, prop, varargin)
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
				case 11 % Spectrum.WAVELENGTH_LABELS
					value = arrayfun(@(wavelength) [num2str(wavelength) ' cm-1'], sp.get('WAVELENGTH')', 'UniformOutput', false);
					
				case 13 % Spectrum.NO_AQUISITIONS
					value = size(sp.get('INTENSITIES'), 2);
					
				case 14 % Spectrum.INTENSITY
					% INTENSITY = sp.get('INTENSITY', N) returns the intenities of the N-th spectrum.
					if isempty(varargin)
					    value = [];
					    return
					end
					n = varargin{1};
					intensities = sp.get('INTENSITIES');
					value = intensities(:, n);
					
				case 15 % Spectrum.INTENSITY_MEAN
					value = mean(sp.get('INTENSITIES'), 2);
					
				otherwise
					if prop <= 8
						value = calculateValue@ConcreteElement(sp, prop, varargin{:});
					else
						value = calculateValue@Element(sp, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(sp, prop, varargin)
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
				case 12 % Spectrum.INTENSITIES
					pr = PanelPropMatrix('EL', sp, 'PROP', 12, ...
					    'ROWNAME', sp.getCallback('WAVELENGTH_LABELS'));
					
				case 5 % Spectrum.ID
					pr = DistapPP_ID('EL', sp, 'PROP', 5);
					
				otherwise
					pr = getPanelProp@ConcreteElement(sp, prop, varargin{:});
					
			end
		end
	end
end
