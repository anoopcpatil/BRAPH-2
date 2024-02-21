classdef WavelengthCalibrator < REAnalysisModule
	%WavelengthCalibrator is an REAnalysisModule that reads raw Raman spectra and outputs fixed spectra (with cosmic ray noise removed).
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Wavelength Calibrator Module (WavelengthCalibrator) is an REAnalysisModule that 
	% reads the wavelengths from the Raman experiment and evaluates the calibrated
	% wavelengths based on the Raman spectra of the standard (polystyrene). This is 
	% used in all the instances of REAnalysisModule.
	%
	% The list of WavelengthCalibrator properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Wavelength Calibrator.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Wavelength Calibrator.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Wavelength Calibrator.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Wavelength Calibrator.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Wavelength Calibrator.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Wavelength Calibrator.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Wavelength Calibrator.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the spectrum with calibrated wavelengths for SP_DICT_OUT and RE_OUT of WavelengthCalibrator.
	%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
	%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
	%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the WavelengthCalibrator.
	%  <strong>14</strong> <strong>PIXEL_1</strong> 	PIXEL_1 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 620.9 nm.
	%  <strong>15</strong> <strong>PIXEL_2</strong> 	PIXEL_2 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1001.4 nm.
	%  <strong>16</strong> <strong>PIXEL_3</strong> 	PIXEL_3 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1031.8 nm.
	%  <strong>17</strong> <strong>PIXEL_4</strong> 	PIXEL_4 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1602.3 nm.
	%
	% WavelengthCalibrator methods (constructor):
	%  WavelengthCalibrator - constructor
	%
	% WavelengthCalibrator methods:
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
	% WavelengthCalibrator methods (display):
	%  tostring - string with information about the Wavelength Calibrator
	%  disp - displays information about the Wavelength Calibrator
	%  tree - displays the tree of the Wavelength Calibrator
	%
	% WavelengthCalibrator methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Wavelength Calibrator are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Wavelength Calibrator
	%
	% WavelengthCalibrator methods (save/load, Static):
	%  save - saves BRAPH2 Wavelength Calibrator as b2 file
	%  load - loads a BRAPH2 Wavelength Calibrator from a b2 file
	%
	% WavelengthCalibrator method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Wavelength Calibrator
	%
	% WavelengthCalibrator method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Wavelength Calibrator
	%
	% WavelengthCalibrator methods (inspection, Static):
	%  getClass - returns the class of the Wavelength Calibrator
	%  getSubclasses - returns all subclasses of WavelengthCalibrator
	%  getProps - returns the property list of the Wavelength Calibrator
	%  getPropNumber - returns the property number of the Wavelength Calibrator
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
	% WavelengthCalibrator methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% WavelengthCalibrator methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% WavelengthCalibrator methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% WavelengthCalibrator methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?WavelengthCalibrator; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">WavelengthCalibrator constants</a>.
	%
	%
	% See also REAnalysisModule, RamanExperiment, Spectrum.
	
	properties (Constant) % properties
		PIXEL_1 = 14; %CET: Computational Efficiency Trick
		PIXEL_1_TAG = 'PIXEL_1';
		PIXEL_1_CATEGORY = 3;
		PIXEL_1_FORMAT = 11;
		
		PIXEL_2 = 15; %CET: Computational Efficiency Trick
		PIXEL_2_TAG = 'PIXEL_2';
		PIXEL_2_CATEGORY = 3;
		PIXEL_2_FORMAT = 11;
		
		PIXEL_3 = 16; %CET: Computational Efficiency Trick
		PIXEL_3_TAG = 'PIXEL_3';
		PIXEL_3_CATEGORY = 3;
		PIXEL_3_FORMAT = 11;
		
		PIXEL_4 = 17; %CET: Computational Efficiency Trick
		PIXEL_4_TAG = 'PIXEL_4';
		PIXEL_4_CATEGORY = 3;
		PIXEL_4_FORMAT = 11;
	end
	methods % constructor
		function wc = WavelengthCalibrator(varargin)
			%WavelengthCalibrator() creates a Wavelength Calibrator.
			%
			% WavelengthCalibrator(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% WavelengthCalibrator(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of WavelengthCalibrator properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Wavelength Calibrator.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Wavelength Calibrator.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Wavelength Calibrator.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Wavelength Calibrator.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Wavelength Calibrator.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Wavelength Calibrator.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Wavelength Calibrator.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the spectrum with calibrated wavelengths for SP_DICT_OUT and RE_OUT of WavelengthCalibrator.
			%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
			%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
			%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the WavelengthCalibrator.
			%  <strong>14</strong> <strong>PIXEL_1</strong> 	PIXEL_1 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 620.9 nm.
			%  <strong>15</strong> <strong>PIXEL_2</strong> 	PIXEL_2 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1001.4 nm.
			%  <strong>16</strong> <strong>PIXEL_3</strong> 	PIXEL_3 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1031.8 nm.
			%  <strong>17</strong> <strong>PIXEL_4</strong> 	PIXEL_4 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1602.3 nm.
			%
			% See also Category, Format.
			
			wc = wc@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function wc_class = getClass()
			%GETCLASS returns the class of the Wavelength Calibrator.
			%
			% CLASS = WavelengthCalibrator.GETCLASS() returns the class 'WavelengthCalibrator'.
			%
			% Alternative forms to call this method are:
			%  CLASS = WC.GETCLASS() returns the class of the Wavelength Calibrator WC.
			%  CLASS = Element.GETCLASS(WC) returns the class of 'WC'.
			%  CLASS = Element.GETCLASS('WavelengthCalibrator') returns 'WavelengthCalibrator'.
			%
			% Note that the Element.GETCLASS(WC) and Element.GETCLASS('WavelengthCalibrator')
			%  are less computationally efficient.
			
			wc_class = 'WavelengthCalibrator';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Wavelength Calibrator.
			%
			% LIST = WavelengthCalibrator.GETSUBCLASSES() returns all subclasses of 'WavelengthCalibrator'.
			%
			% Alternative forms to call this method are:
			%  LIST = WC.GETSUBCLASSES() returns all subclasses of the Wavelength Calibrator WC.
			%  LIST = Element.GETSUBCLASSES(WC) returns all subclasses of 'WC'.
			%  LIST = Element.GETSUBCLASSES('WavelengthCalibrator') returns all subclasses of 'WavelengthCalibrator'.
			%
			% Note that the Element.GETSUBCLASSES(WC) and Element.GETSUBCLASSES('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'WavelengthCalibrator' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Wavelength Calibrator.
			%
			% PROPS = WavelengthCalibrator.GETPROPS() returns the property list of Wavelength Calibrator
			%  as a row vector.
			%
			% PROPS = WavelengthCalibrator.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = WC.GETPROPS([CATEGORY]) returns the property list of the Wavelength Calibrator WC.
			%  PROPS = Element.GETPROPS(WC[, CATEGORY]) returns the property list of 'WC'.
			%  PROPS = Element.GETPROPS('WavelengthCalibrator'[, CATEGORY]) returns the property list of 'WavelengthCalibrator'.
			%
			% Note that the Element.GETPROPS(WC) and Element.GETPROPS('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7];
				case 3 % Category.PARAMETER
					prop_list = [4 14 15 16 17];
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
			%GETPROPNUMBER returns the property number of Wavelength Calibrator.
			%
			% N = WavelengthCalibrator.GETPROPNUMBER() returns the property number of Wavelength Calibrator.
			%
			% N = WavelengthCalibrator.GETPROPNUMBER(CATEGORY) returns the property number of Wavelength Calibrator
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = WC.GETPROPNUMBER([CATEGORY]) returns the property number of the Wavelength Calibrator WC.
			%  N = Element.GETPROPNUMBER(WC) returns the property number of 'WC'.
			%  N = Element.GETPROPNUMBER('WavelengthCalibrator') returns the property number of 'WavelengthCalibrator'.
			%
			% Note that the Element.GETPROPNUMBER(WC) and Element.GETPROPNUMBER('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 17;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 2;
				case 3 % Category.PARAMETER
					prop_number = 5;
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
			%EXISTSPROP checks whether property exists in Wavelength Calibrator/error.
			%
			% CHECK = WavelengthCalibrator.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = WC.EXISTSPROP(PROP) checks whether PROP exists for WC.
			%  CHECK = Element.EXISTSPROP(WC, PROP) checks whether PROP exists for WC.
			%  CHECK = Element.EXISTSPROP(WavelengthCalibrator, PROP) checks whether PROP exists for WavelengthCalibrator.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  WC.EXISTSPROP(PROP) throws error if PROP does NOT exist for WC.
			%   Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%  Element.EXISTSPROP(WC, PROP) throws error if PROP does NOT exist for WC.
			%   Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%  Element.EXISTSPROP(WavelengthCalibrator, PROP) throws error if PROP does NOT exist for WavelengthCalibrator.
			%   Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%
			% Note that the Element.EXISTSPROP(WC) and Element.EXISTSPROP('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WavelengthCalibrator:' 'WrongInput'], ...
					['BRAPH2' ':WavelengthCalibrator:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for WavelengthCalibrator.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Wavelength Calibrator/error.
			%
			% CHECK = WavelengthCalibrator.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = WC.EXISTSTAG(TAG) checks whether TAG exists for WC.
			%  CHECK = Element.EXISTSTAG(WC, TAG) checks whether TAG exists for WC.
			%  CHECK = Element.EXISTSTAG(WavelengthCalibrator, TAG) checks whether TAG exists for WavelengthCalibrator.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%
			% Alternative forms to call this method are:
			%  WC.EXISTSTAG(TAG) throws error if TAG does NOT exist for WC.
			%   Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%  Element.EXISTSTAG(WC, TAG) throws error if TAG does NOT exist for WC.
			%   Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%  Element.EXISTSTAG(WavelengthCalibrator, TAG) throws error if TAG does NOT exist for WavelengthCalibrator.
			%   Error id: [BRAPH2:WavelengthCalibrator:WrongInput]
			%
			% Note that the Element.EXISTSTAG(WC) and Element.EXISTSTAG('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'PIXEL_1'  'PIXEL_2'  'PIXEL_3'  'PIXEL_4' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WavelengthCalibrator:' 'WrongInput'], ...
					['BRAPH2' ':WavelengthCalibrator:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for WavelengthCalibrator.'] ...
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
			%  PROPERTY = WC.GETPROPPROP(POINTER) returns property number of POINTER of WC.
			%  PROPERTY = Element.GETPROPPROP(WavelengthCalibrator, POINTER) returns property number of POINTER of WavelengthCalibrator.
			%  PROPERTY = WC.GETPROPPROP(WavelengthCalibrator, POINTER) returns property number of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPPROP(WC) and Element.GETPROPPROP('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'PIXEL_1'  'PIXEL_2'  'PIXEL_3'  'PIXEL_4' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = WC.GETPROPTAG(POINTER) returns tag of POINTER of WC.
			%  TAG = Element.GETPROPTAG(WavelengthCalibrator, POINTER) returns tag of POINTER of WavelengthCalibrator.
			%  TAG = WC.GETPROPTAG(WavelengthCalibrator, POINTER) returns tag of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPTAG(WC) and Element.GETPROPTAG('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				wavelengthcalibrator_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'PIXEL_1'  'PIXEL_2'  'PIXEL_3'  'PIXEL_4' };
				tag = wavelengthcalibrator_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = WC.GETPROPCATEGORY(POINTER) returns category of POINTER of WC.
			%  CATEGORY = Element.GETPROPCATEGORY(WavelengthCalibrator, POINTER) returns category of POINTER of WavelengthCalibrator.
			%  CATEGORY = WC.GETPROPCATEGORY(WavelengthCalibrator, POINTER) returns category of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPCATEGORY(WC) and Element.GETPROPCATEGORY('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = WavelengthCalibrator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			wavelengthcalibrator_category_list = { 1  1  1  3  4  2  2  6  4  6  5  5  9  3  3  3  3 };
			prop_category = wavelengthcalibrator_category_list{prop};
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
			%  FORMAT = WC.GETPROPFORMAT(POINTER) returns format of POINTER of WC.
			%  FORMAT = Element.GETPROPFORMAT(WavelengthCalibrator, POINTER) returns format of POINTER of WavelengthCalibrator.
			%  FORMAT = WC.GETPROPFORMAT(WavelengthCalibrator, POINTER) returns format of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPFORMAT(WC) and Element.GETPROPFORMAT('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = WavelengthCalibrator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			wavelengthcalibrator_format_list = { 2  2  2  8  2  2  2  2  8  8  10  8  8  11  11  11  11 };
			prop_format = wavelengthcalibrator_format_list{prop};
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
			%  DESCRIPTION = WC.GETPROPDESCRIPTION(POINTER) returns description of POINTER of WC.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(WavelengthCalibrator, POINTER) returns description of POINTER of WavelengthCalibrator.
			%  DESCRIPTION = WC.GETPROPDESCRIPTION(WavelengthCalibrator, POINTER) returns description of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPDESCRIPTION(WC) and Element.GETPROPDESCRIPTION('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = WavelengthCalibrator.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			wavelengthcalibrator_description_list = { 'ELCLASS (constant, string) is the class of the Wavelength Calibrator.'  'NAME (constant, string) is the name of the Wavelength Calibrator.'  'DESCRIPTION (constant, string) is the description of Wavelength Calibrator.'  'TEMPLATE (parameter, item) is the template of the Wavelength Calibrator.'  'ID (data, string) is a few-letter code for the Wavelength Calibrator.'  'LABEL (metadata, string) is an extended label of the Wavelength Calibrator.'  'NOTES (metadata, string) are some specific notes about Wavelength Calibrator.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'SP_OUT (result, item) is the spectrum with calibrated wavelengths for SP_DICT_OUT and RE_OUT of WavelengthCalibrator.'  'SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. '  'RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the WavelengthCalibrator.'  'PIXEL_1 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 620.9 nm.'  'PIXEL_2 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1001.4 nm.'  'PIXEL_3 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1031.8 nm.'  'PIXEL_4 (parameter, scalar) is the pixel for the polystyrene peak corresponding to 1602.3 nm.' };
			prop_description = wavelengthcalibrator_description_list{prop};
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
			%  SETTINGS = WC.GETPROPSETTINGS(POINTER) returns settings of POINTER of WC.
			%  SETTINGS = Element.GETPROPSETTINGS(WavelengthCalibrator, POINTER) returns settings of POINTER of WavelengthCalibrator.
			%  SETTINGS = WC.GETPROPSETTINGS(WavelengthCalibrator, POINTER) returns settings of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPSETTINGS(WC) and Element.GETPROPSETTINGS('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = WavelengthCalibrator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % WavelengthCalibrator.PIXEL_1
					prop_settings = Format.getFormatSettings(11);
				case 15 % WavelengthCalibrator.PIXEL_2
					prop_settings = Format.getFormatSettings(11);
				case 16 % WavelengthCalibrator.PIXEL_3
					prop_settings = Format.getFormatSettings(11);
				case 17 % WavelengthCalibrator.PIXEL_4
					prop_settings = Format.getFormatSettings(11);
				case 4 % WavelengthCalibrator.TEMPLATE
					prop_settings = 'WavelengthCalibrator';
				case 10 % WavelengthCalibrator.SP_OUT
					prop_settings = 'Spectrum';
				case 13 % WavelengthCalibrator.REPF
					prop_settings = 'RamanExperimentPF';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = WavelengthCalibrator.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = WavelengthCalibrator.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = WC.GETPROPDEFAULT(POINTER) returns the default value of POINTER of WC.
			%  DEFAULT = Element.GETPROPDEFAULT(WavelengthCalibrator, POINTER) returns the default value of POINTER of WavelengthCalibrator.
			%  DEFAULT = WC.GETPROPDEFAULT(WavelengthCalibrator, POINTER) returns the default value of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPDEFAULT(WC) and Element.GETPROPDEFAULT('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = WavelengthCalibrator.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % WavelengthCalibrator.PIXEL_1
					prop_default = 138;
				case 15 % WavelengthCalibrator.PIXEL_2
					prop_default = 394;
				case 16 % WavelengthCalibrator.PIXEL_3
					prop_default = 416;
				case 17 % WavelengthCalibrator.PIXEL_4
					prop_default = 843;
				case 1 % WavelengthCalibrator.ELCLASS
					prop_default = 'WavelengthCalibrator';
				case 2 % WavelengthCalibrator.NAME
					prop_default = 'WavelengthCalibrator';
				case 3 % WavelengthCalibrator.DESCRIPTION
					prop_default = 'WavelengthCalibrator reads the wavelengths of the raw Raman spectra and evaluates the calibrated wavelengths based on the standard (polystyrene).';
				case 4 % WavelengthCalibrator.TEMPLATE
					prop_default = Format.getFormatDefault(8, WavelengthCalibrator.getPropSettings(prop));
				case 5 % WavelengthCalibrator.ID
					prop_default = 'WavelengthCalibrator ID';
				case 6 % WavelengthCalibrator.LABEL
					prop_default = 'WavelengthCalibrator label';
				case 7 % WavelengthCalibrator.NOTES
					prop_default = 'WavelengthCalibrator notes';
				case 10 % WavelengthCalibrator.SP_OUT
					prop_default = Format.getFormatDefault(8, WavelengthCalibrator.getPropSettings(prop));
				case 13 % WavelengthCalibrator.REPF
					prop_default = Format.getFormatDefault(8, WavelengthCalibrator.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = WavelengthCalibrator.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = WavelengthCalibrator.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = WC.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of WC.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(WavelengthCalibrator, POINTER) returns the conditioned default value of POINTER of WavelengthCalibrator.
			%  DEFAULT = WC.GETPROPDEFAULTCONDITIONED(WavelengthCalibrator, POINTER) returns the conditioned default value of POINTER of WavelengthCalibrator.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(WC) and Element.GETPROPDEFAULTCONDITIONED('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = WavelengthCalibrator.getPropProp(pointer);
			
			prop_default = WavelengthCalibrator.conditioning(prop, WavelengthCalibrator.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = WC.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = WC.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of WC.
			%  CHECK = Element.CHECKPROP(WavelengthCalibrator, PROP, VALUE) checks VALUE format for PROP of WavelengthCalibrator.
			%  CHECK = WC.CHECKPROP(WavelengthCalibrator, PROP, VALUE) checks VALUE format for PROP of WavelengthCalibrator.
			% 
			% WC.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:WavelengthCalibrator:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  WC.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of WC.
			%   Error id: BRAPH2:WavelengthCalibrator:WrongInput
			%  Element.CHECKPROP(WavelengthCalibrator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WavelengthCalibrator.
			%   Error id: BRAPH2:WavelengthCalibrator:WrongInput
			%  WC.CHECKPROP(WavelengthCalibrator, PROP, VALUE) throws error if VALUE has not a valid format for PROP of WavelengthCalibrator.
			%   Error id: BRAPH2:WavelengthCalibrator:WrongInput]
			% 
			% Note that the Element.CHECKPROP(WC) and Element.CHECKPROP('WavelengthCalibrator')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = WavelengthCalibrator.getPropProp(pointer);
			
			switch prop
				case 14 % WavelengthCalibrator.PIXEL_1
					check = Format.checkFormat(11, value, WavelengthCalibrator.getPropSettings(prop));
				case 15 % WavelengthCalibrator.PIXEL_2
					check = Format.checkFormat(11, value, WavelengthCalibrator.getPropSettings(prop));
				case 16 % WavelengthCalibrator.PIXEL_3
					check = Format.checkFormat(11, value, WavelengthCalibrator.getPropSettings(prop));
				case 17 % WavelengthCalibrator.PIXEL_4
					check = Format.checkFormat(11, value, WavelengthCalibrator.getPropSettings(prop));
				case 4 % WavelengthCalibrator.TEMPLATE
					check = Format.checkFormat(8, value, WavelengthCalibrator.getPropSettings(prop));
				case 10 % WavelengthCalibrator.SP_OUT
					check = Format.checkFormat(8, value, WavelengthCalibrator.getPropSettings(prop));
				case 13 % WavelengthCalibrator.REPF
					check = Format.checkFormat(8, value, WavelengthCalibrator.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':WavelengthCalibrator:' 'WrongInput'], ...
					['BRAPH2' ':WavelengthCalibrator:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' WavelengthCalibrator.getPropTag(prop) ' (' WavelengthCalibrator.getFormatTag(WavelengthCalibrator.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(wc, prop, varargin)
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
				case 10 % WavelengthCalibrator.SP_OUT
					rng_settings_ = rng(); rng(wc.getPropSeed(10), 'twister')
					
					% sp_out = wc.get('SP_OUT', SP_IN) returns the N-th spectrum
					% in SP_DICT of RE_IN of WavelengthCalibrator with calibrated wavelengths. 
					if isempty(varargin)
					    value = Spectrum();
					    return
					end
					% Read the input spectrum
					sp_in = varargin{1};
					
					% % Read the length of the trimmed wavelength vector of the 
					% trimmed Raman spectra
					trimmed_length = size((sp_in.get('WAVELENGTH')),1);
					
					% Reference wavelengths for polystyrene signature peaks
					reference_wavelengths = [620.9 1001.4 1031.8 1602.3];
					
					% Get the pixel values (wavelength indices) for the corresponding peaks in
					% the baseline-removed trimmed Raman spectra of the polystyrene sample
					pix = [wc.get('PIXEL_1') wc.get('PIXEL_2') wc.get('PIXEL_3') wc.get('PIXEL_4')];
					
					% Calibrate the raw wavelengths
					calibrated_wavelengths = interp1(pix, reference_wavelengths, [1:trimmed_length], 'linear', 'extrap'); 
					calibrated_wavelengths = calibrated_wavelengths';
					
					% Create unlocked copy of the spectrum being processed
					% Set the calibrated_wavelengths to the WAVELENGTH of the spectrum 
					sp_out = Spectrum(...
					         'INTENSITIES', sp_in.get('INTENSITIES'), ...
					         'WAVELENGTH', calibrated_wavelengths, ...
					         'ID', sp_in.get('ID'), ...
					         'LABEL', sp_in.get('LABEL'), ...
					         'NOTES', sp_in.get('NOTES'));
					
					% Set the updated sp_out to SP_OUT
					value = sp_out;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 13
						value = calculateValue@REAnalysisModule(wc, prop, varargin{:});
					else
						value = calculateValue@Element(wc, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(wc, prop, varargin)
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
				case 3 % WavelengthCalibrator.DESCRIPTION
					pr = PanelPropStringTextArea('EL', wc, 'PROP', wc.DESCRIPTION, varargin{:});
					
				case 13 % WavelengthCalibrator.REPF
					pr = PanelPropItem('EL', wc, 'PROP', 13, ...
					    'WAITBAR', true, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot calibrated spectra', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@REAnalysisModule(wc, prop, varargin{:});
					
			end
		end
	end
end
