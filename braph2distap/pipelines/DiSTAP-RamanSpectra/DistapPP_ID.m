classdef DistapPP_ID < PanelPropString
	%DistapPP_ID plots the panel of a DiSTAP property id.
	% It is a subclass of <a href="matlab:help PanelPropString">PanelPropString</a>.
	%
	% DistapPP_ID plots the panel for a STRING property with an edit field.
	% It is to be used with the ID properties of the DiSTAP elements.
	%
	% The list of DistapPP_ID properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel DiSTAP id.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel DiSTAP id.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel DiSTAP id.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel DiSTAP id.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel DiSTAP id.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel DiSTAP id.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel DiSTAP id.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
	%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
	%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
	%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
	%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
	%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
	%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
	%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
	%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
	%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
	%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
	%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
	%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
	%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
	%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
	%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
	%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
	%  <strong>37</strong> <strong>EDITFIELD</strong> 	EDITFIELD (evanescent, handle) is the string value edit field.
	%  <strong>38</strong> <strong>AXES</strong> 	AXES (evanescent, handle) is the marker value axes.
	%
	% DistapPP_ID methods (constructor):
	%  DistapPP_ID - constructor
	%
	% DistapPP_ID methods:
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
	% DistapPP_ID methods (display):
	%  tostring - string with information about the panel DiSTAP id
	%  disp - displays information about the panel DiSTAP id
	%  tree - displays the tree of the panel DiSTAP id
	%
	% DistapPP_ID methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel DiSTAP id are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel DiSTAP id
	%
	% DistapPP_ID methods (save/load, Static):
	%  save - saves BRAPH2 panel DiSTAP id as b2 file
	%  load - loads a BRAPH2 panel DiSTAP id from a b2 file
	%
	% DistapPP_ID method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel DiSTAP id
	%
	% DistapPP_ID method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel DiSTAP id
	%
	% DistapPP_ID methods (inspection, Static):
	%  getClass - returns the class of the panel DiSTAP id
	%  getSubclasses - returns all subclasses of DistapPP_ID
	%  getProps - returns the property list of the panel DiSTAP id
	%  getPropNumber - returns the property number of the panel DiSTAP id
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
	% DistapPP_ID methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% DistapPP_ID methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% DistapPP_ID methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% DistapPP_ID methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?DistapPP_ID; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">DistapPP_ID constants</a>.
	%
	
	properties (Constant) % properties
		AXES = 38; %CET: Computational Efficiency Trick
		AXES_TAG = 'AXES';
		AXES_CATEGORY = 7;
		AXES_FORMAT = 18;
	end
	methods % constructor
		function pr = DistapPP_ID(varargin)
			%DistapPP_ID() creates a panel DiSTAP id.
			%
			% DistapPP_ID(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% DistapPP_ID(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of DistapPP_ID properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel DiSTAP id.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel DiSTAP id.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel DiSTAP id.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel DiSTAP id.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel DiSTAP id.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel DiSTAP id.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel DiSTAP id.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the property panel.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.
			%  <strong>20</strong> <strong>X_DRAW</strong> 	X_DRAW (query, logical) draws the property panel.
			%  <strong>21</strong> <strong>UPDATE</strong> 	UPDATE (query, logical) updates the content and permissions of the editfield.
			%  <strong>22</strong> <strong>REDRAW</strong> 	REDRAW (query, logical) resizes the property panel and repositions its graphical objects.
			%  <strong>23</strong> <strong>EL</strong> 	EL (data, item) is the element.
			%  <strong>24</strong> <strong>PROP</strong> 	PROP (data, scalar) is the property number.
			%  <strong>25</strong> <strong>HEIGHT</strong> 	HEIGHT (gui, size) is the pixel height of the property panel.
			%  <strong>26</strong> <strong>TITLE</strong> 	TITLE (gui, string) is the property title.
			%  <strong>27</strong> <strong>LABEL_TITLE</strong> 	LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.
			%  <strong>28</strong> <strong>BUTTON_CB</strong> 	BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].
			%  <strong>29</strong> <strong>GUI_CB</strong> 	GUI_CB (data, item) is the handle to the item figure.
			%  <strong>30</strong> <strong>LISTENER_CB</strong> 	LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.
			%  <strong>31</strong> <strong>BUTTON_CALC</strong> 	BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>32</strong> <strong>BUTTON_DEL</strong> 	BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].
			%  <strong>33</strong> <strong>LISTENER_SET</strong> 	LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.
			%  <strong>34</strong> <strong>LISTENER_MEMORIZED</strong> 	LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.
			%  <strong>35</strong> <strong>LISTENER_LOCKED</strong> 	LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.
			%  <strong>36</strong> <strong>ENABLE</strong> 	ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.
			%  <strong>37</strong> <strong>EDITFIELD</strong> 	EDITFIELD (evanescent, handle) is the string value edit field.
			%  <strong>38</strong> <strong>AXES</strong> 	AXES (evanescent, handle) is the marker value axes.
			%
			% See also Category, Format.
			
			pr = pr@PanelPropString(varargin{:});
		end
	end
	methods (Static) % inspection
		function pr_class = getClass()
			%GETCLASS returns the class of the panel DiSTAP id.
			%
			% CLASS = DistapPP_ID.GETCLASS() returns the class 'DistapPP_ID'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PR.GETCLASS() returns the class of the panel DiSTAP id PR.
			%  CLASS = Element.GETCLASS(PR) returns the class of 'PR'.
			%  CLASS = Element.GETCLASS('DistapPP_ID') returns 'DistapPP_ID'.
			%
			% Note that the Element.GETCLASS(PR) and Element.GETCLASS('DistapPP_ID')
			%  are less computationally efficient.
			
			pr_class = 'DistapPP_ID';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel DiSTAP id.
			%
			% LIST = DistapPP_ID.GETSUBCLASSES() returns all subclasses of 'DistapPP_ID'.
			%
			% Alternative forms to call this method are:
			%  LIST = PR.GETSUBCLASSES() returns all subclasses of the panel DiSTAP id PR.
			%  LIST = Element.GETSUBCLASSES(PR) returns all subclasses of 'PR'.
			%  LIST = Element.GETSUBCLASSES('DistapPP_ID') returns all subclasses of 'DistapPP_ID'.
			%
			% Note that the Element.GETSUBCLASSES(PR) and Element.GETSUBCLASSES('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'DistapPP_ID' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel DiSTAP id.
			%
			% PROPS = DistapPP_ID.GETPROPS() returns the property list of panel DiSTAP id
			%  as a row vector.
			%
			% PROPS = DistapPP_ID.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PR.GETPROPS([CATEGORY]) returns the property list of the panel DiSTAP id PR.
			%  PROPS = Element.GETPROPS(PR[, CATEGORY]) returns the property list of 'PR'.
			%  PROPS = Element.GETPROPS('DistapPP_ID'[, CATEGORY]) returns the property list of 'DistapPP_ID'.
			%
			% Note that the Element.GETPROPS(PR) and Element.GETPROPS('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38];
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
					prop_list = [5 23 24 29];
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 20 21 22];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 27 28 30 31 32 33 34 35 37 38];
				case 8 % Category.FIGURE
					prop_list = 14;
				case 9 % Category.GUI
					prop_list = [9 13 25 26 36];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel DiSTAP id.
			%
			% N = DistapPP_ID.GETPROPNUMBER() returns the property number of panel DiSTAP id.
			%
			% N = DistapPP_ID.GETPROPNUMBER(CATEGORY) returns the property number of panel DiSTAP id
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PR.GETPROPNUMBER([CATEGORY]) returns the property number of the panel DiSTAP id PR.
			%  N = Element.GETPROPNUMBER(PR) returns the property number of 'PR'.
			%  N = Element.GETPROPNUMBER('DistapPP_ID') returns the property number of 'DistapPP_ID'.
			%
			% Note that the Element.GETPROPNUMBER(PR) and Element.GETPROPNUMBER('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 38;
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
					prop_number = 10;
				case 7 % Category.EVANESCENT
					prop_number = 12;
				case 8 % Category.FIGURE
					prop_number = 1;
				case 9 % Category.GUI
					prop_number = 5;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel DiSTAP id/error.
			%
			% CHECK = DistapPP_ID.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSPROP(PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(PR, PROP) checks whether PROP exists for PR.
			%  CHECK = Element.EXISTSPROP(DistapPP_ID, PROP) checks whether PROP exists for DistapPP_ID.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSPROP(PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%  Element.EXISTSPROP(PR, PROP) throws error if PROP does NOT exist for PR.
			%   Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%  Element.EXISTSPROP(DistapPP_ID, PROP) throws error if PROP does NOT exist for DistapPP_ID.
			%   Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PR) and Element.EXISTSPROP('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 38 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DistapPP_ID:' 'WrongInput'], ...
					['BRAPH2' ':DistapPP_ID:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for DistapPP_ID.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel DiSTAP id/error.
			%
			% CHECK = DistapPP_ID.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PR.EXISTSTAG(TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(PR, TAG) checks whether TAG exists for PR.
			%  CHECK = Element.EXISTSTAG(DistapPP_ID, TAG) checks whether TAG exists for DistapPP_ID.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PR.EXISTSTAG(TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%  Element.EXISTSTAG(PR, TAG) throws error if TAG does NOT exist for PR.
			%   Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%  Element.EXISTSTAG(DistapPP_ID, TAG) throws error if TAG does NOT exist for DistapPP_ID.
			%   Error id: [BRAPH2:DistapPP_ID:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PR) and Element.EXISTSTAG('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD'  'AXES' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DistapPP_ID:' 'WrongInput'], ...
					['BRAPH2' ':DistapPP_ID:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for DistapPP_ID.'] ...
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
			%  PROPERTY = PR.GETPROPPROP(POINTER) returns property number of POINTER of PR.
			%  PROPERTY = Element.GETPROPPROP(DistapPP_ID, POINTER) returns property number of POINTER of DistapPP_ID.
			%  PROPERTY = PR.GETPROPPROP(DistapPP_ID, POINTER) returns property number of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPPROP(PR) and Element.GETPROPPROP('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD'  'AXES' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PR.GETPROPTAG(POINTER) returns tag of POINTER of PR.
			%  TAG = Element.GETPROPTAG(DistapPP_ID, POINTER) returns tag of POINTER of DistapPP_ID.
			%  TAG = PR.GETPROPTAG(DistapPP_ID, POINTER) returns tag of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPTAG(PR) and Element.GETPROPTAG('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				distappp_id_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'X_DRAW'  'UPDATE'  'REDRAW'  'EL'  'PROP'  'HEIGHT'  'TITLE'  'LABEL_TITLE'  'BUTTON_CB'  'GUI_CB'  'LISTENER_CB'  'BUTTON_CALC'  'BUTTON_DEL'  'LISTENER_SET'  'LISTENER_MEMORIZED'  'LISTENER_LOCKED'  'ENABLE'  'EDITFIELD'  'AXES' };
				tag = distappp_id_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PR.GETPROPCATEGORY(POINTER) returns category of POINTER of PR.
			%  CATEGORY = Element.GETPROPCATEGORY(DistapPP_ID, POINTER) returns category of POINTER of DistapPP_ID.
			%  CATEGORY = PR.GETPROPCATEGORY(DistapPP_ID, POINTER) returns category of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPCATEGORY(PR) and Element.GETPROPCATEGORY('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = DistapPP_ID.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			distappp_id_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  6  6  6  4  4  9  9  7  7  4  7  7  7  7  7  7  9  7  7 };
			prop_category = distappp_id_category_list{prop};
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
			%  FORMAT = PR.GETPROPFORMAT(POINTER) returns format of POINTER of PR.
			%  FORMAT = Element.GETPROPFORMAT(DistapPP_ID, POINTER) returns format of POINTER of DistapPP_ID.
			%  FORMAT = PR.GETPROPFORMAT(DistapPP_ID, POINTER) returns format of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPFORMAT(PR) and Element.GETPROPFORMAT('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = DistapPP_ID.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			distappp_id_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  4  4  4  8  11  22  2  18  18  8  18  18  18  19  19  19  4  18  18 };
			prop_format = distappp_id_format_list{prop};
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
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PR.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(DistapPP_ID, POINTER) returns description of POINTER of DistapPP_ID.
			%  DESCRIPTION = PR.GETPROPDESCRIPTION(DistapPP_ID, POINTER) returns description of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPDESCRIPTION(PR) and Element.GETPROPDESCRIPTION('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = DistapPP_ID.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			distappp_id_description_list = { 'ELCLASS (constant, string) is the class of the panel DiSTAP id.'  'NAME (constant, string) is the name of the panel DiSTAP id.'  'DESCRIPTION (constant, string) is the description of the panel DiSTAP id.'  'TEMPLATE (parameter, item) is the template of the panel DiSTAP id.'  'ID (data, string) is a few-letter code for the panel DiSTAP id.'  'LABEL (metadata, string) is an extended label of the panel DiSTAP id.'  'NOTES (metadata, string) are some specific notes about the panel DiSTAP id.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the property panel.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel and, possibly, the callback figure.'  'HIDE (query, logical) hides the figure containing the panel and, possibly, the callback figure.'  'DELETE (query, logical) resets the handles when the panel is deleted.'  'CLOSE (query, logical) closes the figure containing the panel and, possibly, the callback figure.'  'X_DRAW (query, logical) draws the property panel.'  'UPDATE (query, logical) updates the content and permissions of the editfield.'  'REDRAW (query, logical) resizes the property panel and repositions its graphical objects.'  'EL (data, item) is the element.'  'PROP (data, scalar) is the property number.'  'HEIGHT (gui, size) is the pixel height of the property panel.'  'TITLE (gui, string) is the property title.'  'LABEL_TITLE (evanescent, handle) is the handle for the title uilabel.'  'BUTTON_CB (evanescent, handle) is the handle for the callback button [only for PARAMETER, DATA, FIGURE and GUI].'  'GUI_CB (data, item) is the handle to the item figure.'  'LISTENER_CB (evanescent, handle) contains the listener to the updates in the property callback.'  'BUTTON_CALC (evanescent, handle) is the handle for the calculate button [only for RESULT, QUERY and EVANESCENT].'  'BUTTON_DEL (evanescent, handle) is the handle for the delete button [only for RESULT, QUERY and EVANESCENT].'  'LISTENER_SET (evanescent, handlelist) contains the listeners to the PropSet events.'  'LISTENER_MEMORIZED (evanescent, handlelist) contains the listeners to the PropMemorized events.'  'LISTENER_LOCKED (evanescent, handlelist) contains the listeners to the PropLocked events.'  'ENABLE (gui, logical) switches the editfield between active and inactive appearance when not editable.'  'EDITFIELD (evanescent, handle) is the string value edit field.'  'AXES (evanescent, handle) is the marker value axes.' };
			prop_description = distappp_id_description_list{prop};
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
			%  SETTINGS = PR.GETPROPSETTINGS(POINTER) returns settings of POINTER of PR.
			%  SETTINGS = Element.GETPROPSETTINGS(DistapPP_ID, POINTER) returns settings of POINTER of DistapPP_ID.
			%  SETTINGS = PR.GETPROPSETTINGS(DistapPP_ID, POINTER) returns settings of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPSETTINGS(PR) and Element.GETPROPSETTINGS('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = DistapPP_ID.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 38 % DistapPP_ID.AXES
					prop_settings = Format.getFormatSettings(18);
				case 4 % DistapPP_ID.TEMPLATE
					prop_settings = 'DistapPP_ID';
				otherwise
					prop_settings = getPropSettings@PanelPropString(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = DistapPP_ID.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = DistapPP_ID.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULT(DistapPP_ID, POINTER) returns the default value of POINTER of DistapPP_ID.
			%  DEFAULT = PR.GETPROPDEFAULT(DistapPP_ID, POINTER) returns the default value of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPDEFAULT(PR) and Element.GETPROPDEFAULT('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = DistapPP_ID.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 38 % DistapPP_ID.AXES
					prop_default = Format.getFormatDefault(18, DistapPP_ID.getPropSettings(prop));
				case 1 % DistapPP_ID.ELCLASS
					prop_default = 'DistapPP_ID';
				case 2 % DistapPP_ID.NAME
					prop_default = 'panel DiSTAP id';
				case 3 % DistapPP_ID.DESCRIPTION
					prop_default = 'DistapPP_ID plots the panel for a STRING property with an edit field.';
				case 4 % DistapPP_ID.TEMPLATE
					prop_default = Format.getFormatDefault(8, DistapPP_ID.getPropSettings(prop));
				case 5 % DistapPP_ID.ID
					prop_default = 'DistapPP_ID ID';
				case 6 % DistapPP_ID.LABEL
					prop_default = 'DistapPP_ID label';
				case 7 % DistapPP_ID.NOTES
					prop_default = 'DistapPP_ID notes';
				case 23 % DistapPP_ID.EL
					prop_default = Spectrum();
				case 24 % DistapPP_ID.PROP
					prop_default = 5;
				case 25 % DistapPP_ID.HEIGHT
					prop_default = 144;
				otherwise
					prop_default = getPropDefault@PanelPropString(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = DistapPP_ID.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = DistapPP_ID.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PR.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(DistapPP_ID, POINTER) returns the conditioned default value of POINTER of DistapPP_ID.
			%  DEFAULT = PR.GETPROPDEFAULTCONDITIONED(DistapPP_ID, POINTER) returns the conditioned default value of POINTER of DistapPP_ID.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PR) and Element.GETPROPDEFAULTCONDITIONED('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = DistapPP_ID.getPropProp(pointer);
			
			prop_default = DistapPP_ID.conditioning(prop, DistapPP_ID.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PR.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PR.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PR.
			%  CHECK = Element.CHECKPROP(DistapPP_ID, PROP, VALUE) checks VALUE format for PROP of DistapPP_ID.
			%  CHECK = PR.CHECKPROP(DistapPP_ID, PROP, VALUE) checks VALUE format for PROP of DistapPP_ID.
			% 
			% PR.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:DistapPP_ID:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PR.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PR.
			%   Error id: BRAPH2:DistapPP_ID:WrongInput
			%  Element.CHECKPROP(DistapPP_ID, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DistapPP_ID.
			%   Error id: BRAPH2:DistapPP_ID:WrongInput
			%  PR.CHECKPROP(DistapPP_ID, PROP, VALUE) throws error if VALUE has not a valid format for PROP of DistapPP_ID.
			%   Error id: BRAPH2:DistapPP_ID:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PR) and Element.CHECKPROP('DistapPP_ID')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = DistapPP_ID.getPropProp(pointer);
			
			switch prop
				case 38 % DistapPP_ID.AXES
					check = Format.checkFormat(18, value, DistapPP_ID.getPropSettings(prop));
				case 4 % DistapPP_ID.TEMPLATE
					check = Format.checkFormat(8, value, DistapPP_ID.getPropSettings(prop));
				otherwise
					if prop <= 37
						check = checkProp@PanelPropString(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':DistapPP_ID:' 'WrongInput'], ...
					['BRAPH2' ':DistapPP_ID:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' DistapPP_ID.getPropTag(prop) ' (' DistapPP_ID.getFormatTag(DistapPP_ID.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pr, prop, varargin)
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
				case 38 % DistapPP_ID.AXES
					axes = uiaxes( ...
					    'Parent', pr.memorize('H'), ... % H = p for Panel
					    'Tag', 'AXES', ...
					    'Units', 'pixels', ...
					    'InnerPosition', [4 30 288 96] ...
					    );
					
					im = imread('DiSTAPlogo.jpg');
					imshow(im(50:450, 320:1620, :), 'Parent', axes)
					xlim(axes, [1, 1300])
					ylim(axes, [1, 400])
					
					axes.Toolbar.Visible = 'off';
					axes.Interactions = [];
					axis(axes, 'off')
					
					value = axes;
					
				case 20 % DistapPP_ID.X_DRAW
					value = calculateValue@PanelPropString(pr, 20, varargin{:}); % also warning
					if value
					    pr.memorize('AXES')
					end
					
				case 21 % DistapPP_ID.UPDATE
					value = calculateValue@PanelPropString(pr, 21, varargin{:}); % also warning
					if value
					    %
					end
					
				case 22 % DistapPP_ID.REDRAW
					value = calculateValue@PanelPropString(pr, 22, varargin{:}); % also warning
					if value
					    %
					end
					
				case 18 % DistapPP_ID.DELETE
					value = calculateValue@PanelPropString(pr, 18, varargin{:}); % also warning
					if value
					    pr.set('AXES', Element.getNoValue())
					end
					
				otherwise
					if prop <= 37
						value = calculateValue@PanelPropString(pr, prop, varargin{:});
					else
						value = calculateValue@Element(pr, prop, varargin{:});
					end
			end
			
		end
	end
end
