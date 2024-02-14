classdef BaselineRemover < REAnalysisModule
	%BaselineRemover is an REAnalysisModule that reads smooth Raman spectra and outputs baseline-removed Raman and Raman baselines.
	% It is a subclass of <a href="matlab:help REAnalysisModule">REAnalysisModule</a>.
	%
	% A Baseline Remover (BaselineRemover) is an REAnalysisModule
	% that reads the smooth Raman spectra (from Smoothener) and evaluates 
	% the baseline-removed Raman spectra (smooth spectra with baselines removed)
	% and the baselines. It also provides basic functionalities to view and plot 
	% the baseline-removed spectra and the baselines.
	%
	% The list of BaselineRemover properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Baseline Remover.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Baseline Remover.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Baseline Remover.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Baseline Remover.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Baseline Remover.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Baseline Remover.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Baseline Remover.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
	%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baseline Remover.
	%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
	%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
	%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the BaselineRemover.
	%  <strong>14</strong> <strong>RE_BASELINES</strong> 	RE_BASELINES (result, item) is the output Raman Experiment with Raman baselines as a result.
	%  <strong>15</strong> <strong>BAPF</strong> 	BAPF (gui, item) is a container of the panel figure for BaselineEstimator.
	%  <strong>16</strong> <strong>LFIT_POLYORDER</strong> 	LFIT_POLYORDER (parameter, scalar) is the order of the polynomial for Lieberfit function.
	%  <strong>17</strong> <strong>LFIT_ITER</strong> 	LFIT_ITER (parameter, scalar) is the number of iterations for Lieberfit function.
	%
	% BaselineRemover methods (constructor):
	%  BaselineRemover - constructor
	%
	% BaselineRemover methods:
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
	% BaselineRemover methods (display):
	%  tostring - string with information about the Baseline Remover
	%  disp - displays information about the Baseline Remover
	%  tree - displays the tree of the Baseline Remover
	%
	% BaselineRemover methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two Baseline Remover are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the Baseline Remover
	%
	% BaselineRemover methods (save/load, Static):
	%  save - saves BRAPH2 Baseline Remover as b2 file
	%  load - loads a BRAPH2 Baseline Remover from a b2 file
	%
	% BaselineRemover method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the Baseline Remover
	%
	% BaselineRemover method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the Baseline Remover
	%
	% BaselineRemover methods (inspection, Static):
	%  getClass - returns the class of the Baseline Remover
	%  getSubclasses - returns all subclasses of BaselineRemover
	%  getProps - returns the property list of the Baseline Remover
	%  getPropNumber - returns the property number of the Baseline Remover
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
	% BaselineRemover methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% BaselineRemover methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% BaselineRemover methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% BaselineRemover methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?BaselineRemover; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">BaselineRemover constants</a>.
	%
	%
	% See also REAnalysisModule, BaselineEstimator, RamanExperiment, Spectrum.
	
	properties (Constant) % properties
		RE_BASELINES = 14; %CET: Computational Efficiency Trick
		RE_BASELINES_TAG = 'RE_BASELINES';
		RE_BASELINES_CATEGORY = 5;
		RE_BASELINES_FORMAT = 8;
		
		BAPF = 15; %CET: Computational Efficiency Trick
		BAPF_TAG = 'BAPF';
		BAPF_CATEGORY = 9;
		BAPF_FORMAT = 8;
		
		LFIT_POLYORDER = 16; %CET: Computational Efficiency Trick
		LFIT_POLYORDER_TAG = 'LFIT_POLYORDER';
		LFIT_POLYORDER_CATEGORY = 3;
		LFIT_POLYORDER_FORMAT = 11;
		
		LFIT_ITER = 17; %CET: Computational Efficiency Trick
		LFIT_ITER_TAG = 'LFIT_ITER';
		LFIT_ITER_CATEGORY = 3;
		LFIT_ITER_FORMAT = 11;
	end
	methods % constructor
		function br = BaselineRemover(varargin)
			%BaselineRemover() creates a Baseline Remover.
			%
			% BaselineRemover(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% BaselineRemover(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of BaselineRemover properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the Baseline Remover.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the Baseline Remover.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of Baseline Remover.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the Baseline Remover.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the Baseline Remover.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the Baseline Remover.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about Baseline Remover.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>RE_IN</strong> 	RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.
			%  <strong>10</strong> <strong>SP_OUT</strong> 	SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baseline Remover.
			%  <strong>11</strong> <strong>SP_DICT_OUT</strong> 	SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. 
			%  <strong>12</strong> <strong>RE_OUT</strong> 	RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.
			%  <strong>13</strong> <strong>REPF</strong> 	REPF (gui, item) is a container of the panel figure for the BaselineRemover.
			%  <strong>14</strong> <strong>RE_BASELINES</strong> 	RE_BASELINES (result, item) is the output Raman Experiment with Raman baselines as a result.
			%  <strong>15</strong> <strong>BAPF</strong> 	BAPF (gui, item) is a container of the panel figure for BaselineEstimator.
			%  <strong>16</strong> <strong>LFIT_POLYORDER</strong> 	LFIT_POLYORDER (parameter, scalar) is the order of the polynomial for Lieberfit function.
			%  <strong>17</strong> <strong>LFIT_ITER</strong> 	LFIT_ITER (parameter, scalar) is the number of iterations for Lieberfit function.
			%
			% See also Category, Format.
			
			br = br@REAnalysisModule(varargin{:});
		end
	end
	methods (Static) % inspection
		function br_class = getClass()
			%GETCLASS returns the class of the Baseline Remover.
			%
			% CLASS = BaselineRemover.GETCLASS() returns the class 'BaselineRemover'.
			%
			% Alternative forms to call this method are:
			%  CLASS = BR.GETCLASS() returns the class of the Baseline Remover BR.
			%  CLASS = Element.GETCLASS(BR) returns the class of 'BR'.
			%  CLASS = Element.GETCLASS('BaselineRemover') returns 'BaselineRemover'.
			%
			% Note that the Element.GETCLASS(BR) and Element.GETCLASS('BaselineRemover')
			%  are less computationally efficient.
			
			br_class = 'BaselineRemover';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the Baseline Remover.
			%
			% LIST = BaselineRemover.GETSUBCLASSES() returns all subclasses of 'BaselineRemover'.
			%
			% Alternative forms to call this method are:
			%  LIST = BR.GETSUBCLASSES() returns all subclasses of the Baseline Remover BR.
			%  LIST = Element.GETSUBCLASSES(BR) returns all subclasses of 'BR'.
			%  LIST = Element.GETSUBCLASSES('BaselineRemover') returns all subclasses of 'BaselineRemover'.
			%
			% Note that the Element.GETSUBCLASSES(BR) and Element.GETSUBCLASSES('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'BaselineRemover' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of Baseline Remover.
			%
			% PROPS = BaselineRemover.GETPROPS() returns the property list of Baseline Remover
			%  as a row vector.
			%
			% PROPS = BaselineRemover.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = BR.GETPROPS([CATEGORY]) returns the property list of the Baseline Remover BR.
			%  PROPS = Element.GETPROPS(BR[, CATEGORY]) returns the property list of 'BR'.
			%  PROPS = Element.GETPROPS('BaselineRemover'[, CATEGORY]) returns the property list of 'BaselineRemover'.
			%
			% Note that the Element.GETPROPS(BR) and Element.GETPROPS('BaselineRemover')
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
					prop_list = [4 16 17];
				case 4 % Category.DATA
					prop_list = [5 9];
				case 5 % Category.RESULT
					prop_list = [11 12 14];
				case 6 % Category.QUERY
					prop_list = [8 10];
				case 9 % Category.GUI
					prop_list = [13 15];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of Baseline Remover.
			%
			% N = BaselineRemover.GETPROPNUMBER() returns the property number of Baseline Remover.
			%
			% N = BaselineRemover.GETPROPNUMBER(CATEGORY) returns the property number of Baseline Remover
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = BR.GETPROPNUMBER([CATEGORY]) returns the property number of the Baseline Remover BR.
			%  N = Element.GETPROPNUMBER(BR) returns the property number of 'BR'.
			%  N = Element.GETPROPNUMBER('BaselineRemover') returns the property number of 'BaselineRemover'.
			%
			% Note that the Element.GETPROPNUMBER(BR) and Element.GETPROPNUMBER('BaselineRemover')
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
					prop_number = 3;
				case 4 % Category.DATA
					prop_number = 2;
				case 5 % Category.RESULT
					prop_number = 3;
				case 6 % Category.QUERY
					prop_number = 2;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in Baseline Remover/error.
			%
			% CHECK = BaselineRemover.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BR.EXISTSPROP(PROP) checks whether PROP exists for BR.
			%  CHECK = Element.EXISTSPROP(BR, PROP) checks whether PROP exists for BR.
			%  CHECK = Element.EXISTSPROP(BaselineRemover, PROP) checks whether PROP exists for BaselineRemover.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:BaselineRemover:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BR.EXISTSPROP(PROP) throws error if PROP does NOT exist for BR.
			%   Error id: [BRAPH2:BaselineRemover:WrongInput]
			%  Element.EXISTSPROP(BR, PROP) throws error if PROP does NOT exist for BR.
			%   Error id: [BRAPH2:BaselineRemover:WrongInput]
			%  Element.EXISTSPROP(BaselineRemover, PROP) throws error if PROP does NOT exist for BaselineRemover.
			%   Error id: [BRAPH2:BaselineRemover:WrongInput]
			%
			% Note that the Element.EXISTSPROP(BR) and Element.EXISTSPROP('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 17 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselineRemover:' 'WrongInput'], ...
					['BRAPH2' ':BaselineRemover:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for BaselineRemover.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in Baseline Remover/error.
			%
			% CHECK = BaselineRemover.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = BR.EXISTSTAG(TAG) checks whether TAG exists for BR.
			%  CHECK = Element.EXISTSTAG(BR, TAG) checks whether TAG exists for BR.
			%  CHECK = Element.EXISTSTAG(BaselineRemover, TAG) checks whether TAG exists for BaselineRemover.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:BaselineRemover:WrongInput]
			%
			% Alternative forms to call this method are:
			%  BR.EXISTSTAG(TAG) throws error if TAG does NOT exist for BR.
			%   Error id: [BRAPH2:BaselineRemover:WrongInput]
			%  Element.EXISTSTAG(BR, TAG) throws error if TAG does NOT exist for BR.
			%   Error id: [BRAPH2:BaselineRemover:WrongInput]
			%  Element.EXISTSTAG(BaselineRemover, TAG) throws error if TAG does NOT exist for BaselineRemover.
			%   Error id: [BRAPH2:BaselineRemover:WrongInput]
			%
			% Note that the Element.EXISTSTAG(BR) and Element.EXISTSTAG('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'RE_BASELINES'  'BAPF'  'LFIT_POLYORDER'  'LFIT_ITER' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselineRemover:' 'WrongInput'], ...
					['BRAPH2' ':BaselineRemover:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for BaselineRemover.'] ...
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
			%  PROPERTY = BR.GETPROPPROP(POINTER) returns property number of POINTER of BR.
			%  PROPERTY = Element.GETPROPPROP(BaselineRemover, POINTER) returns property number of POINTER of BaselineRemover.
			%  PROPERTY = BR.GETPROPPROP(BaselineRemover, POINTER) returns property number of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPPROP(BR) and Element.GETPROPPROP('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'RE_BASELINES'  'BAPF'  'LFIT_POLYORDER'  'LFIT_ITER' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = BR.GETPROPTAG(POINTER) returns tag of POINTER of BR.
			%  TAG = Element.GETPROPTAG(BaselineRemover, POINTER) returns tag of POINTER of BaselineRemover.
			%  TAG = BR.GETPROPTAG(BaselineRemover, POINTER) returns tag of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPTAG(BR) and Element.GETPROPTAG('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				baselineremover_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'RE_IN'  'SP_OUT'  'SP_DICT_OUT'  'RE_OUT'  'REPF'  'RE_BASELINES'  'BAPF'  'LFIT_POLYORDER'  'LFIT_ITER' };
				tag = baselineremover_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = BR.GETPROPCATEGORY(POINTER) returns category of POINTER of BR.
			%  CATEGORY = Element.GETPROPCATEGORY(BaselineRemover, POINTER) returns category of POINTER of BaselineRemover.
			%  CATEGORY = BR.GETPROPCATEGORY(BaselineRemover, POINTER) returns category of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPCATEGORY(BR) and Element.GETPROPCATEGORY('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = BaselineRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselineremover_category_list = { 1  1  1  3  4  2  2  6  4  6  5  5  9  5  9  3  3 };
			prop_category = baselineremover_category_list{prop};
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
			%  FORMAT = BR.GETPROPFORMAT(POINTER) returns format of POINTER of BR.
			%  FORMAT = Element.GETPROPFORMAT(BaselineRemover, POINTER) returns format of POINTER of BaselineRemover.
			%  FORMAT = BR.GETPROPFORMAT(BaselineRemover, POINTER) returns format of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPFORMAT(BR) and Element.GETPROPFORMAT('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = BaselineRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselineremover_format_list = { 2  2  2  8  2  2  2  2  8  8  10  8  8  8  8  11  11 };
			prop_format = baselineremover_format_list{prop};
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
			%  DESCRIPTION = BR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of BR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(BaselineRemover, POINTER) returns description of POINTER of BaselineRemover.
			%  DESCRIPTION = BR.GETPROPDESCRIPTION(BaselineRemover, POINTER) returns description of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPDESCRIPTION(BR) and Element.GETPROPDESCRIPTION('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = BaselineRemover.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			baselineremover_description_list = { 'ELCLASS (constant, string) is the class of the Baseline Remover.'  'NAME (constant, string) is the name of the Baseline Remover.'  'DESCRIPTION (constant, string) is the description of Baseline Remover.'  'TEMPLATE (parameter, item) is the template of the Baseline Remover.'  'ID (data, string) is a few-letter code for the Baseline Remover.'  'LABEL (metadata, string) is an extended label of the Baseline Remover.'  'NOTES (metadata, string) are some specific notes about Baseline Remover.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'RE_IN (data, item) is the input Raman Experiment for reading the Raman spectra.'  'SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baseline Remover.'  'SP_DICT_OUT (result, idict) is the processed dictionary SP_DICT of RE_IN for RE_OUT. '  'RE_OUT (result, item) is the output Raman Experiment with processed spectra as a result.'  'REPF (gui, item) is a container of the panel figure for the BaselineRemover.'  'RE_BASELINES (result, item) is the output Raman Experiment with Raman baselines as a result.'  'BAPF (gui, item) is a container of the panel figure for BaselineEstimator.'  'LFIT_POLYORDER (parameter, scalar) is the order of the polynomial for Lieberfit function.'  'LFIT_ITER (parameter, scalar) is the number of iterations for Lieberfit function.' };
			prop_description = baselineremover_description_list{prop};
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
			%  SETTINGS = BR.GETPROPSETTINGS(POINTER) returns settings of POINTER of BR.
			%  SETTINGS = Element.GETPROPSETTINGS(BaselineRemover, POINTER) returns settings of POINTER of BaselineRemover.
			%  SETTINGS = BR.GETPROPSETTINGS(BaselineRemover, POINTER) returns settings of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPSETTINGS(BR) and Element.GETPROPSETTINGS('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = BaselineRemover.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % BaselineRemover.RE_BASELINES
					prop_settings = 'RamanExperiment';
				case 15 % BaselineRemover.BAPF
					prop_settings = 'RamanExperimentPF';
				case 16 % BaselineRemover.LFIT_POLYORDER
					prop_settings = Format.getFormatSettings(11);
				case 17 % BaselineRemover.LFIT_ITER
					prop_settings = Format.getFormatSettings(11);
				case 4 % BaselineRemover.TEMPLATE
					prop_settings = 'BaselineRemover';
				case 10 % BaselineRemover.SP_OUT
					prop_settings = 'Spectrum';
				case 13 % BaselineRemover.REPF
					prop_settings = 'RamanExperimentPF';
				otherwise
					prop_settings = getPropSettings@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = BaselineRemover.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = BaselineRemover.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of BR.
			%  DEFAULT = Element.GETPROPDEFAULT(BaselineRemover, POINTER) returns the default value of POINTER of BaselineRemover.
			%  DEFAULT = BR.GETPROPDEFAULT(BaselineRemover, POINTER) returns the default value of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPDEFAULT(BR) and Element.GETPROPDEFAULT('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = BaselineRemover.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 14 % BaselineRemover.RE_BASELINES
					prop_default = Format.getFormatDefault(8, BaselineRemover.getPropSettings(prop));
				case 15 % BaselineRemover.BAPF
					prop_default = Format.getFormatDefault(8, BaselineRemover.getPropSettings(prop));
				case 16 % BaselineRemover.LFIT_POLYORDER
					prop_default = 5;
				case 17 % BaselineRemover.LFIT_ITER
					prop_default = 100;
				case 1 % BaselineRemover.ELCLASS
					prop_default = 'BaselineRemover';
				case 2 % BaselineRemover.NAME
					prop_default = 'BaselineRemover';
				case 3 % BaselineRemover.DESCRIPTION
					prop_default = 'BaselineRemover reads and analyzes smooth Raman spectra and evaluates and plots the baselined Raman spectra.';
				case 4 % BaselineRemover.TEMPLATE
					prop_default = Format.getFormatDefault(8, BaselineRemover.getPropSettings(prop));
				case 5 % BaselineRemover.ID
					prop_default = 'BaselineRemover ID';
				case 6 % BaselineRemover.LABEL
					prop_default = 'BaselineRemover label';
				case 7 % BaselineRemover.NOTES
					prop_default = 'BaselineRemover notes';
				case 10 % BaselineRemover.SP_OUT
					prop_default = Format.getFormatDefault(8, BaselineRemover.getPropSettings(prop));
				case 13 % BaselineRemover.REPF
					prop_default = Format.getFormatDefault(8, BaselineRemover.getPropSettings(prop));
				otherwise
					prop_default = getPropDefault@REAnalysisModule(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = BaselineRemover.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = BaselineRemover.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = BR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of BR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(BaselineRemover, POINTER) returns the conditioned default value of POINTER of BaselineRemover.
			%  DEFAULT = BR.GETPROPDEFAULTCONDITIONED(BaselineRemover, POINTER) returns the conditioned default value of POINTER of BaselineRemover.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(BR) and Element.GETPROPDEFAULTCONDITIONED('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = BaselineRemover.getPropProp(pointer);
			
			prop_default = BaselineRemover.conditioning(prop, BaselineRemover.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = BR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = BR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of BR.
			%  CHECK = Element.CHECKPROP(BaselineRemover, PROP, VALUE) checks VALUE format for PROP of BaselineRemover.
			%  CHECK = BR.CHECKPROP(BaselineRemover, PROP, VALUE) checks VALUE format for PROP of BaselineRemover.
			% 
			% BR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:BaselineRemover:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  BR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of BR.
			%   Error id: BRAPH2:BaselineRemover:WrongInput
			%  Element.CHECKPROP(BaselineRemover, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BaselineRemover.
			%   Error id: BRAPH2:BaselineRemover:WrongInput
			%  BR.CHECKPROP(BaselineRemover, PROP, VALUE) throws error if VALUE has not a valid format for PROP of BaselineRemover.
			%   Error id: BRAPH2:BaselineRemover:WrongInput]
			% 
			% Note that the Element.CHECKPROP(BR) and Element.CHECKPROP('BaselineRemover')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = BaselineRemover.getPropProp(pointer);
			
			switch prop
				case 14 % BaselineRemover.RE_BASELINES
					check = Format.checkFormat(8, value, BaselineRemover.getPropSettings(prop));
				case 15 % BaselineRemover.BAPF
					check = Format.checkFormat(8, value, BaselineRemover.getPropSettings(prop));
				case 16 % BaselineRemover.LFIT_POLYORDER
					check = Format.checkFormat(11, value, BaselineRemover.getPropSettings(prop));
				case 17 % BaselineRemover.LFIT_ITER
					check = Format.checkFormat(11, value, BaselineRemover.getPropSettings(prop));
				case 4 % BaselineRemover.TEMPLATE
					check = Format.checkFormat(8, value, BaselineRemover.getPropSettings(prop));
				case 10 % BaselineRemover.SP_OUT
					check = Format.checkFormat(8, value, BaselineRemover.getPropSettings(prop));
				case 13 % BaselineRemover.REPF
					check = Format.checkFormat(8, value, BaselineRemover.getPropSettings(prop));
				otherwise
					if prop <= 13
						check = checkProp@REAnalysisModule(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':BaselineRemover:' 'WrongInput'], ...
					['BRAPH2' ':BaselineRemover:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' BaselineRemover.getPropTag(prop) ' (' BaselineRemover.getFormatTag(BaselineRemover.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(br, prop, varargin)
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
				case 14 % BaselineRemover.RE_BASELINES
					rng_settings_ = rng(); rng(br.getPropSeed(14), 'twister')
					
					% Call BaselineEstimator to evaluate baselines
					be = BaselineEstimator('RE_IN', br.get('RE_IN'));
					
					% Read RE_OUT of BaselineEstimator
					re_out = be.get('RE_OUT')
					
					% Set the re_out to RE_BASELINES
					value = re_out;
					
					% Set re_out to RE and memorize baselines for GUI output of BaselineRemover
					br.memorize('BAPF').set('RE', re_out)
					
					rng(rng_settings_)
					
				case 10 % BaselineRemover.SP_OUT
					rng_settings_ = rng(); rng(br.getPropSeed(10), 'twister')
					
					% sp_out = br.get('SP_OUT', SP_IN) returns the baselined intensities of 
					% the N-th spectrum in SP_DICT of RE_IN of BaselineRemover. 
					if isempty(varargin)
					    value = Spectrum();
					    return
					end
					% Read the input spectrum
					sp_in = varargin{1};
					
					% Read the intensities of the smooth Raman spectrum
					% smooth intensities
					smooth_intensities = sp_in.get('INTENSITIES');
					
					% Baselined intensities using Lieberfit function
					% % Set the order of the polynomial for Lieberfit function
					% LFIT_POLYORDER = 5;
					% % Set the number of odd points in the window for Lieberfit function
					% LFIT_ITER = 100;
					% Apply Lieberfit function to smooth intensities from
					% Smoothener
					[baselines, baselined_intensities] = lieberfit(smooth_intensities', ...
					                                               br.get('LFIT_POLYORDER'), ...
					                                               br.get('LFIT_ITER')); 
					
					% Create unlocked copy of the spectrum being processed
					% Set the baselined intensities to the INTENSITIES of the spectrum 
					sp_out = Spectrum(...
					         'INTENSITIES', baselined_intensities, ...
					         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
					         'ID', sp_in.get('ID'), ...
					         'LABEL', sp_in.get('LABEL'), ...
					         'NOTES', sp_in.get('NOTES'));
					
					% Set the updated sp_out to SP_OUT
					value = sp_out;
					
					rng(rng_settings_)
					
				otherwise
					if prop <= 13
						value = calculateValue@REAnalysisModule(br, prop, varargin{:});
					else
						value = calculateValue@Element(br, prop, varargin{:});
					end
			end
			
		end
	end
	methods % GUI
		function pr = getPanelProp(br, prop, varargin)
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
				case 15 % BaselineRemover.BAPF
					pr = PanelPropItem('EL', br, 'PROP', 15, ...
					    'WAITBAR', true, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot estimated baselines', ...
					    varargin{:});
					
					
					%Parameters for Lieberfit function for baseine estimation:
					%LFIT_POLYORDER & LFIT_ITER
					
				case 3 % BaselineRemover.DESCRIPTION
					pr = PanelPropStringTextArea('EL', br, 'PROP', br.DESCRIPTION, varargin{:});
					
				case 13 % BaselineRemover.REPF
					pr = PanelPropItem('EL', br, 'PROP', 13, ...
					    'WAITBAR', true, ...
					    'GUICLASS', 'GUIFig', ...
					    'BUTTON_TEXT', 'Plot Baseline-removed spectra', ...
					    varargin{:});
					
				otherwise
					pr = getPanelProp@REAnalysisModule(br, prop, varargin{:});
					
			end
		end
	end
end
