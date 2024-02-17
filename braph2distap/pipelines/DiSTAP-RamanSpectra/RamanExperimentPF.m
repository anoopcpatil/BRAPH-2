classdef RamanExperimentPF < PanelFig
	%RamanExperimentPF is the base element to plot a Raman experiment.
	% It is a subclass of <a href="matlab:help PanelFig">PanelFig</a>.
	%
	% RamanExperimentPF manages the basic functionalities to plot of a Raman experiment.
	%
	% The list of RamanExperimentPF properties is:
	%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure Raman experiment.
	%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure Raman experiment.
	%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure Raman experiment.
	%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure Raman experiment.
	%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure Raman experiment.
	%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure Raman experiment.
	%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure Raman experiment.
	%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
	%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
	%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
	%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure Raman experiment.
	%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
	%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
	%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
	%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
	%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
	%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
	%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
	%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
	%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
	%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
	%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
	%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
	%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
	%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
	%  <strong>26</strong> <strong>RE</strong> 	RE (metadata, item) is the Raman experiment.
	%  <strong>27</strong> <strong>SELECTED_SP</strong> 	SELECTED_SP (figure, scalar) is the spectrum number to be plotted.
	%  <strong>28</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the Raman spectrum and stores it.
	%  <strong>29</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the average spectrum area.
	%  <strong>30</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the average spectrum area settings.
	%  <strong>31</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the average spectrum area settings to update the pushbutton.
	%  <strong>32</strong> <strong>H_LINE</strong> 	H_LINE (evanescent, handle) is the handle for the average spectrum line.
	%  <strong>33</strong> <strong>ST_LINE</strong> 	ST_LINE (figure, item) determines the average spectrum line settings.
	%  <strong>34</strong> <strong>LISTENER_ST_LINE</strong> 	LISTENER_ST_LINE (evanescent, handle) contains the listener to the average spectrum line settings to update the pushbutton.
	%  <strong>35</strong> <strong>H_LINES</strong> 	H_LINES (evanescent, handlelist) is the set of handles for the symbols.
	%  <strong>36</strong> <strong>LINES</strong> 	LINES (figure, logical) determines whether the single spectra are shown.
	%  <strong>37</strong> <strong>LINE_DICT</strong> 	LINE_DICT (figure, idict) contains the lines of the spectra.
	%  <strong>38</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
	%  <strong>39</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
	%  <strong>40</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
	%  <strong>41</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
	%  <strong>42</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
	%  <strong>43</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
	%
	% RamanExperimentPF methods (constructor):
	%  RamanExperimentPF - constructor
	%
	% RamanExperimentPF methods:
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
	% RamanExperimentPF methods (display):
	%  tostring - string with information about the panel figure Raman experiment
	%  disp - displays information about the panel figure Raman experiment
	%  tree - displays the tree of the panel figure Raman experiment
	%
	% RamanExperimentPF methods (miscellanea):
	%  getNoValue - returns a pointer to a persistent instance of NoValue
	%               Use it as Element.getNoValue()
	%  getCallback - returns the callback to a property
	%  isequal - determines whether two panel figure Raman experiment are equal (values, locked)
	%  getElementList - returns a list with all subelements
	%  copy - copies the panel figure Raman experiment
	%
	% RamanExperimentPF methods (save/load, Static):
	%  save - saves BRAPH2 panel figure Raman experiment as b2 file
	%  load - loads a BRAPH2 panel figure Raman experiment from a b2 file
	%
	% RamanExperimentPF method (JSON encode):
	%  encodeJSON - returns a JSON string encoding the panel figure Raman experiment
	%
	% RamanExperimentPF method (JSON decode, Static):
	%   decodeJSON - returns a JSON string encoding the panel figure Raman experiment
	%
	% RamanExperimentPF methods (inspection, Static):
	%  getClass - returns the class of the panel figure Raman experiment
	%  getSubclasses - returns all subclasses of RamanExperimentPF
	%  getProps - returns the property list of the panel figure Raman experiment
	%  getPropNumber - returns the property number of the panel figure Raman experiment
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
	% RamanExperimentPF methods (GUI):
	%  getPanelProp - returns a prop panel
	%
	% RamanExperimentPF methods (GUI, Static):
	%  getGUIMenuImport - returns the importer menu
	%  getGUIMenuExport - returns the exporter menu
	%
	% RamanExperimentPF methods (category, Static):
	%  getCategories - returns the list of categories
	%  getCategoryNumber - returns the number of categories
	%  existsCategory - returns whether a category exists/error
	%  getCategoryTag - returns the tag of a category
	%  getCategoryName - returns the name of a category
	%  getCategoryDescription - returns the description of a category
	%
	% RamanExperimentPF methods (format, Static):
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
	% To print full list of constants, click here <a href="matlab:metaclass = ?RamanExperimentPF; properties = metaclass.PropertyList;for i = 1:1:length(properties), if properties(i).Constant, disp([properties(i).Name newline() tostring(properties(i).DefaultValue) newline()]), end, end">RamanExperimentPF constants</a>.
	%
	%
	% See also Measure.
	
	properties (Constant) % properties
		H_AXES = 23; %CET: Computational Efficiency Trick
		H_AXES_TAG = 'H_AXES';
		H_AXES_CATEGORY = 7;
		H_AXES_FORMAT = 18;
		
		ST_AXIS = 24; %CET: Computational Efficiency Trick
		ST_AXIS_TAG = 'ST_AXIS';
		ST_AXIS_CATEGORY = 8;
		ST_AXIS_FORMAT = 8;
		
		LISTENER_ST_AXIS = 25; %CET: Computational Efficiency Trick
		LISTENER_ST_AXIS_TAG = 'LISTENER_ST_AXIS';
		LISTENER_ST_AXIS_CATEGORY = 7;
		LISTENER_ST_AXIS_FORMAT = 18;
		
		RE = 26; %CET: Computational Efficiency Trick
		RE_TAG = 'RE';
		RE_CATEGORY = 2;
		RE_FORMAT = 8;
		
		SELECTED_SP = 27; %CET: Computational Efficiency Trick
		SELECTED_SP_TAG = 'SELECTED_SP';
		SELECTED_SP_CATEGORY = 8;
		SELECTED_SP_FORMAT = 11;
		
		SETUP = 28; %CET: Computational Efficiency Trick
		SETUP_TAG = 'SETUP';
		SETUP_CATEGORY = 6;
		SETUP_FORMAT = 1;
		
		H_AREA = 29; %CET: Computational Efficiency Trick
		H_AREA_TAG = 'H_AREA';
		H_AREA_CATEGORY = 7;
		H_AREA_FORMAT = 18;
		
		ST_AREA = 30; %CET: Computational Efficiency Trick
		ST_AREA_TAG = 'ST_AREA';
		ST_AREA_CATEGORY = 8;
		ST_AREA_FORMAT = 8;
		
		LISTENER_ST_AREA = 31; %CET: Computational Efficiency Trick
		LISTENER_ST_AREA_TAG = 'LISTENER_ST_AREA';
		LISTENER_ST_AREA_CATEGORY = 7;
		LISTENER_ST_AREA_FORMAT = 18;
		
		H_LINE = 32; %CET: Computational Efficiency Trick
		H_LINE_TAG = 'H_LINE';
		H_LINE_CATEGORY = 7;
		H_LINE_FORMAT = 18;
		
		ST_LINE = 33; %CET: Computational Efficiency Trick
		ST_LINE_TAG = 'ST_LINE';
		ST_LINE_CATEGORY = 8;
		ST_LINE_FORMAT = 8;
		
		LISTENER_ST_LINE = 34; %CET: Computational Efficiency Trick
		LISTENER_ST_LINE_TAG = 'LISTENER_ST_LINE';
		LISTENER_ST_LINE_CATEGORY = 7;
		LISTENER_ST_LINE_FORMAT = 18;
		
		H_LINES = 35; %CET: Computational Efficiency Trick
		H_LINES_TAG = 'H_LINES';
		H_LINES_CATEGORY = 7;
		H_LINES_FORMAT = 19;
		
		LINES = 36; %CET: Computational Efficiency Trick
		LINES_TAG = 'LINES';
		LINES_CATEGORY = 8;
		LINES_FORMAT = 4;
		
		LINE_DICT = 37; %CET: Computational Efficiency Trick
		LINE_DICT_TAG = 'LINE_DICT';
		LINE_DICT_CATEGORY = 8;
		LINE_DICT_FORMAT = 10;
		
		H_TITLE = 38; %CET: Computational Efficiency Trick
		H_TITLE_TAG = 'H_TITLE';
		H_TITLE_CATEGORY = 7;
		H_TITLE_FORMAT = 18;
		
		ST_TITLE = 39; %CET: Computational Efficiency Trick
		ST_TITLE_TAG = 'ST_TITLE';
		ST_TITLE_CATEGORY = 8;
		ST_TITLE_FORMAT = 8;
		
		H_XLABEL = 40; %CET: Computational Efficiency Trick
		H_XLABEL_TAG = 'H_XLABEL';
		H_XLABEL_CATEGORY = 7;
		H_XLABEL_FORMAT = 18;
		
		ST_XLABEL = 41; %CET: Computational Efficiency Trick
		ST_XLABEL_TAG = 'ST_XLABEL';
		ST_XLABEL_CATEGORY = 8;
		ST_XLABEL_FORMAT = 8;
		
		H_YLABEL = 42; %CET: Computational Efficiency Trick
		H_YLABEL_TAG = 'H_YLABEL';
		H_YLABEL_CATEGORY = 7;
		H_YLABEL_FORMAT = 18;
		
		ST_YLABEL = 43; %CET: Computational Efficiency Trick
		ST_YLABEL_TAG = 'ST_YLABEL';
		ST_YLABEL_CATEGORY = 8;
		ST_YLABEL_FORMAT = 8;
	end
	methods % constructor
		function pf = RamanExperimentPF(varargin)
			%RamanExperimentPF() creates a panel figure Raman experiment.
			%
			% RamanExperimentPF(PROP, VALUE, ...) with property PROP initialized to VALUE.
			%
			% RamanExperimentPF(TAG, VALUE, ...) with property TAG set to VALUE.
			%
			% Multiple properties can be initialized at once identifying
			%  them with either property numbers (PROP) or tags (TAG).
			%
			% The list of RamanExperimentPF properties is:
			%  <strong>1</strong> <strong>ELCLASS</strong> 	ELCLASS (constant, string) is the class of the panel figure Raman experiment.
			%  <strong>2</strong> <strong>NAME</strong> 	NAME (constant, string) is the name of the panel figure Raman experiment.
			%  <strong>3</strong> <strong>DESCRIPTION</strong> 	DESCRIPTION (constant, string) is the description of the panel figure Raman experiment.
			%  <strong>4</strong> <strong>TEMPLATE</strong> 	TEMPLATE (parameter, item) is the template of the panel figure Raman experiment.
			%  <strong>5</strong> <strong>ID</strong> 	ID (data, string) is a few-letter code for the panel figure Raman experiment.
			%  <strong>6</strong> <strong>LABEL</strong> 	LABEL (metadata, string) is an extended label of the panel figure Raman experiment.
			%  <strong>7</strong> <strong>NOTES</strong> 	NOTES (metadata, string) are some specific notes about the panel figure Raman experiment.
			%  <strong>8</strong> <strong>TOSTRING</strong> 	TOSTRING (query, string) returns a string that represents the concrete element.
			%  <strong>9</strong> <strong>WAITBAR</strong> 	WAITBAR (gui, logical) detemines whether to show the waitbar.
			%  <strong>10</strong> <strong>H_WAITBAR</strong> 	H_WAITBAR (evanescent, handle) is the waitbar handle.
			%  <strong>11</strong> <strong>DRAW</strong> 	DRAW (query, logical) draws the figure Raman experiment.
			%  <strong>12</strong> <strong>DRAWN</strong> 	DRAWN (query, logical) returns whether the panel has been drawn.
			%  <strong>13</strong> <strong>PARENT</strong> 	PARENT (gui, item) is the panel parent.
			%  <strong>14</strong> <strong>BKGCOLOR</strong> 	BKGCOLOR (figure, color) is the panel background color.
			%  <strong>15</strong> <strong>H</strong> 	H (evanescent, handle) is the panel handle.
			%  <strong>16</strong> <strong>SHOW</strong> 	SHOW (query, logical) shows the figure containing the panel.
			%  <strong>17</strong> <strong>HIDE</strong> 	HIDE (query, logical) hides the figure containing the panel.
			%  <strong>18</strong> <strong>DELETE</strong> 	DELETE (query, logical) resets the handles when the panel figure graph is deleted.
			%  <strong>19</strong> <strong>CLOSE</strong> 	CLOSE (query, logical) closes the figure containing the panel.
			%  <strong>20</strong> <strong>ST_POSITION</strong> 	ST_POSITION (figure, item) determines the panel position.
			%  <strong>21</strong> <strong>H_TOOLBAR</strong> 	H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.
			%  <strong>22</strong> <strong>H_TOOLS</strong> 	H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.
			%  <strong>23</strong> <strong>H_AXES</strong> 	H_AXES (evanescent, handle) is the handle for the axes.
			%  <strong>24</strong> <strong>ST_AXIS</strong> 	ST_AXIS (figure, item) determines the axis settings.
			%  <strong>25</strong> <strong>LISTENER_ST_AXIS</strong> 	LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.
			%  <strong>26</strong> <strong>RE</strong> 	RE (metadata, item) is the Raman experiment.
			%  <strong>27</strong> <strong>SELECTED_SP</strong> 	SELECTED_SP (figure, scalar) is the spectrum number to be plotted.
			%  <strong>28</strong> <strong>SETUP</strong> 	SETUP (query, empty) calculates the Raman spectrum and stores it.
			%  <strong>29</strong> <strong>H_AREA</strong> 	H_AREA (evanescent, handle) is the handle for the average spectrum area.
			%  <strong>30</strong> <strong>ST_AREA</strong> 	ST_AREA (figure, item) determines the average spectrum area settings.
			%  <strong>31</strong> <strong>LISTENER_ST_AREA</strong> 	LISTENER_ST_AREA (evanescent, handle) contains the listener to the average spectrum area settings to update the pushbutton.
			%  <strong>32</strong> <strong>H_LINE</strong> 	H_LINE (evanescent, handle) is the handle for the average spectrum line.
			%  <strong>33</strong> <strong>ST_LINE</strong> 	ST_LINE (figure, item) determines the average spectrum line settings.
			%  <strong>34</strong> <strong>LISTENER_ST_LINE</strong> 	LISTENER_ST_LINE (evanescent, handle) contains the listener to the average spectrum line settings to update the pushbutton.
			%  <strong>35</strong> <strong>H_LINES</strong> 	H_LINES (evanescent, handlelist) is the set of handles for the symbols.
			%  <strong>36</strong> <strong>LINES</strong> 	LINES (figure, logical) determines whether the single spectra are shown.
			%  <strong>37</strong> <strong>LINE_DICT</strong> 	LINE_DICT (figure, idict) contains the lines of the spectra.
			%  <strong>38</strong> <strong>H_TITLE</strong> 	H_TITLE (evanescent, handle) is the axis title.
			%  <strong>39</strong> <strong>ST_TITLE</strong> 	ST_TITLE (figure, item) determines the title settings.
			%  <strong>40</strong> <strong>H_XLABEL</strong> 	H_XLABEL (evanescent, handle) is the axis x-label.
			%  <strong>41</strong> <strong>ST_XLABEL</strong> 	ST_XLABEL (figure, item) determines the x-label settings.
			%  <strong>42</strong> <strong>H_YLABEL</strong> 	H_YLABEL (evanescent, handle) is the axis y-label.
			%  <strong>43</strong> <strong>ST_YLABEL</strong> 	ST_YLABEL (figure, item) determines the y-label settings.
			%
			% See also Category, Format.
			
			pf = pf@PanelFig(varargin{:});
		end
	end
	methods (Static) % inspection
		function pf_class = getClass()
			%GETCLASS returns the class of the panel figure Raman experiment.
			%
			% CLASS = RamanExperimentPF.GETCLASS() returns the class 'RamanExperimentPF'.
			%
			% Alternative forms to call this method are:
			%  CLASS = PF.GETCLASS() returns the class of the panel figure Raman experiment PF.
			%  CLASS = Element.GETCLASS(PF) returns the class of 'PF'.
			%  CLASS = Element.GETCLASS('RamanExperimentPF') returns 'RamanExperimentPF'.
			%
			% Note that the Element.GETCLASS(PF) and Element.GETCLASS('RamanExperimentPF')
			%  are less computationally efficient.
			
			pf_class = 'RamanExperimentPF';
		end
		function subclass_list = getSubclasses()
			%GETSUBCLASSES returns all subclasses of the panel figure Raman experiment.
			%
			% LIST = RamanExperimentPF.GETSUBCLASSES() returns all subclasses of 'RamanExperimentPF'.
			%
			% Alternative forms to call this method are:
			%  LIST = PF.GETSUBCLASSES() returns all subclasses of the panel figure Raman experiment PF.
			%  LIST = Element.GETSUBCLASSES(PF) returns all subclasses of 'PF'.
			%  LIST = Element.GETSUBCLASSES('RamanExperimentPF') returns all subclasses of 'RamanExperimentPF'.
			%
			% Note that the Element.GETSUBCLASSES(PF) and Element.GETSUBCLASSES('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also subclasses.
			
			subclass_list = { 'RamanExperimentPF' }; %CET: Computational Efficiency Trick
		end
		function prop_list = getProps(category)
			%GETPROPS returns the property list of panel figure Raman experiment.
			%
			% PROPS = RamanExperimentPF.GETPROPS() returns the property list of panel figure Raman experiment
			%  as a row vector.
			%
			% PROPS = RamanExperimentPF.GETPROPS(CATEGORY) returns the property list 
			%  of category CATEGORY.
			%
			% Alternative forms to call this method are:
			%  PROPS = PF.GETPROPS([CATEGORY]) returns the property list of the panel figure Raman experiment PF.
			%  PROPS = Element.GETPROPS(PF[, CATEGORY]) returns the property list of 'PF'.
			%  PROPS = Element.GETPROPS('RamanExperimentPF'[, CATEGORY]) returns the property list of 'RamanExperimentPF'.
			%
			% Note that the Element.GETPROPS(PF) and Element.GETPROPS('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getPropNumber, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_list = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43];
				return
			end
			
			switch category
				case 1 % Category.CONSTANT
					prop_list = [1 2 3];
				case 2 % Category.METADATA
					prop_list = [6 7 26];
				case 3 % Category.PARAMETER
					prop_list = 4;
				case 4 % Category.DATA
					prop_list = 5;
				case 6 % Category.QUERY
					prop_list = [8 11 12 16 17 18 19 28];
				case 7 % Category.EVANESCENT
					prop_list = [10 15 21 22 23 25 29 31 32 34 35 38 40 42];
				case 8 % Category.FIGURE
					prop_list = [14 20 24 27 30 33 36 37 39 41 43];
				case 9 % Category.GUI
					prop_list = [9 13];
				otherwise
					prop_list = [];
			end
		end
		function prop_number = getPropNumber(varargin)
			%GETPROPNUMBER returns the property number of panel figure Raman experiment.
			%
			% N = RamanExperimentPF.GETPROPNUMBER() returns the property number of panel figure Raman experiment.
			%
			% N = RamanExperimentPF.GETPROPNUMBER(CATEGORY) returns the property number of panel figure Raman experiment
			%  of category CATEGORY
			%
			% Alternative forms to call this method are:
			%  N = PF.GETPROPNUMBER([CATEGORY]) returns the property number of the panel figure Raman experiment PF.
			%  N = Element.GETPROPNUMBER(PF) returns the property number of 'PF'.
			%  N = Element.GETPROPNUMBER('RamanExperimentPF') returns the property number of 'RamanExperimentPF'.
			%
			% Note that the Element.GETPROPNUMBER(PF) and Element.GETPROPNUMBER('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getProps, Category.
			
			%CET: Computational Efficiency Trick
			
			if nargin == 0
				prop_number = 43;
				return
			end
			
			switch varargin{1} % category = varargin{1}
				case 1 % Category.CONSTANT
					prop_number = 3;
				case 2 % Category.METADATA
					prop_number = 3;
				case 3 % Category.PARAMETER
					prop_number = 1;
				case 4 % Category.DATA
					prop_number = 1;
				case 6 % Category.QUERY
					prop_number = 8;
				case 7 % Category.EVANESCENT
					prop_number = 14;
				case 8 % Category.FIGURE
					prop_number = 11;
				case 9 % Category.GUI
					prop_number = 2;
				otherwise
					prop_number = 0;
			end
		end
		function check_out = existsProp(prop)
			%EXISTSPROP checks whether property exists in panel figure Raman experiment/error.
			%
			% CHECK = RamanExperimentPF.EXISTSPROP(PROP) checks whether the property PROP exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSPROP(PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(PF, PROP) checks whether PROP exists for PF.
			%  CHECK = Element.EXISTSPROP(RamanExperimentPF, PROP) checks whether PROP exists for RamanExperimentPF.
			%
			% Element.EXISTSPROP(PROP) throws an error if the PROP does NOT exist.
			%  Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSPROP(PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%  Element.EXISTSPROP(PF, PROP) throws error if PROP does NOT exist for PF.
			%   Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%  Element.EXISTSPROP(RamanExperimentPF, PROP) throws error if PROP does NOT exist for RamanExperimentPF.
			%   Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%
			% Note that the Element.EXISTSPROP(PF) and Element.EXISTSPROP('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = prop >= 1 && prop <= 43 && round(prop) == prop; %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RamanExperimentPF:' 'WrongInput'], ...
					['BRAPH2' ':RamanExperimentPF:' 'WrongInput' '\n' ...
					'The value ' tostring(prop, 100, ' ...') ' is not a valid prop for RamanExperimentPF.'] ...
					)
			end
		end
		function check_out = existsTag(tag)
			%EXISTSTAG checks whether tag exists in panel figure Raman experiment/error.
			%
			% CHECK = RamanExperimentPF.EXISTSTAG(TAG) checks whether a property with tag TAG exists.
			%
			% Alternative forms to call this method are:
			%  CHECK = PF.EXISTSTAG(TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(PF, TAG) checks whether TAG exists for PF.
			%  CHECK = Element.EXISTSTAG(RamanExperimentPF, TAG) checks whether TAG exists for RamanExperimentPF.
			%
			% Element.EXISTSTAG(TAG) throws an error if the TAG does NOT exist.
			%  Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%
			% Alternative forms to call this method are:
			%  PF.EXISTSTAG(TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%  Element.EXISTSTAG(PF, TAG) throws error if TAG does NOT exist for PF.
			%   Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%  Element.EXISTSTAG(RamanExperimentPF, TAG) throws error if TAG does NOT exist for RamanExperimentPF.
			%   Error id: [BRAPH2:RamanExperimentPF:WrongInput]
			%
			% Note that the Element.EXISTSTAG(PF) and Element.EXISTSTAG('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getProps, existsTag.
			
			check = any(strcmp(tag, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'RE'  'SELECTED_SP'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE'  'ST_LINE'  'LISTENER_ST_LINE'  'H_LINES'  'LINES'  'LINE_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); %CET: Computational Efficiency Trick
			
			if nargout == 1
				check_out = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RamanExperimentPF:' 'WrongInput'], ...
					['BRAPH2' ':RamanExperimentPF:' 'WrongInput' '\n' ...
					'The value ' tag ' is not a valid tag for RamanExperimentPF.'] ...
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
			%  PROPERTY = PF.GETPROPPROP(POINTER) returns property number of POINTER of PF.
			%  PROPERTY = Element.GETPROPPROP(RamanExperimentPF, POINTER) returns property number of POINTER of RamanExperimentPF.
			%  PROPERTY = PF.GETPROPPROP(RamanExperimentPF, POINTER) returns property number of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPPROP(PF) and Element.GETPROPPROP('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getPropFormat, getPropTag, getPropCategory, getPropDescription,
			%  getPropSettings, getPropDefault, checkProp.
			
			if ischar(pointer)
				prop = find(strcmp(pointer, { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'RE'  'SELECTED_SP'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE'  'ST_LINE'  'LISTENER_ST_LINE'  'H_LINES'  'LINES'  'LINE_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' })); % tag = pointer %CET: Computational Efficiency Trick
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
			%  TAG = PF.GETPROPTAG(POINTER) returns tag of POINTER of PF.
			%  TAG = Element.GETPROPTAG(RamanExperimentPF, POINTER) returns tag of POINTER of RamanExperimentPF.
			%  TAG = PF.GETPROPTAG(RamanExperimentPF, POINTER) returns tag of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPTAG(PF) and Element.GETPROPTAG('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropSettings, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			if ischar(pointer)
				tag = pointer;
			else % numeric
				%CET: Computational Efficiency Trick
				ramanexperimentpf_tag_list = { 'ELCLASS'  'NAME'  'DESCRIPTION'  'TEMPLATE'  'ID'  'LABEL'  'NOTES'  'TOSTRING'  'WAITBAR'  'H_WAITBAR'  'DRAW'  'DRAWN'  'PARENT'  'BKGCOLOR'  'H'  'SHOW'  'HIDE'  'DELETE'  'CLOSE'  'ST_POSITION'  'H_TOOLBAR'  'H_TOOLS'  'H_AXES'  'ST_AXIS'  'LISTENER_ST_AXIS'  'RE'  'SELECTED_SP'  'SETUP'  'H_AREA'  'ST_AREA'  'LISTENER_ST_AREA'  'H_LINE'  'ST_LINE'  'LISTENER_ST_LINE'  'H_LINES'  'LINES'  'LINE_DICT'  'H_TITLE'  'ST_TITLE'  'H_XLABEL'  'ST_XLABEL'  'H_YLABEL'  'ST_YLABEL' };
				tag = ramanexperimentpf_tag_list{pointer}; % prop = pointer
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
			%  CATEGORY = PF.GETPROPCATEGORY(POINTER) returns category of POINTER of PF.
			%  CATEGORY = Element.GETPROPCATEGORY(RamanExperimentPF, POINTER) returns category of POINTER of RamanExperimentPF.
			%  CATEGORY = PF.GETPROPCATEGORY(RamanExperimentPF, POINTER) returns category of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPCATEGORY(PF) and Element.GETPROPCATEGORY('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also Category, getPropProp, getPropTag, getPropSettings,
			%  getPropFormat, getPropDescription, getPropDefault, checkProp.
			
			prop = RamanExperimentPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ramanexperimentpf_category_list = { 1  1  1  3  4  2  2  6  9  7  6  6  9  8  7  6  6  6  6  8  7  7  7  8  7  2  8  6  7  8  7  7  8  7  7  8  8  7  8  7  8  7  8 };
			prop_category = ramanexperimentpf_category_list{prop};
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
			%  FORMAT = PF.GETPROPFORMAT(POINTER) returns format of POINTER of PF.
			%  FORMAT = Element.GETPROPFORMAT(RamanExperimentPF, POINTER) returns format of POINTER of RamanExperimentPF.
			%  FORMAT = PF.GETPROPFORMAT(RamanExperimentPF, POINTER) returns format of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPFORMAT(PF) and Element.GETPROPFORMAT('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropCategory,
			%  getPropDescription, getPropSettings, getPropDefault, checkProp.
			
			prop = RamanExperimentPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ramanexperimentpf_format_list = { 2  2  2  8  2  2  2  2  4  18  4  4  8  20  18  4  4  4  4  8  18  19  18  8  18  8  11  1  18  8  18  18  8  18  19  4  10  18  8  18  8  18  8 };
			prop_format = ramanexperimentpf_format_list{prop};
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
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(POINTER) returns description of POINTER of PF.
			%  DESCRIPTION = Element.GETPROPDESCRIPTION(RamanExperimentPF, POINTER) returns description of POINTER of RamanExperimentPF.
			%  DESCRIPTION = PF.GETPROPDESCRIPTION(RamanExperimentPF, POINTER) returns description of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPDESCRIPTION(PF) and Element.GETPROPDESCRIPTION('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory,
			%  getPropFormat, getPropSettings, getPropDefault, checkProp.
			
			prop = RamanExperimentPF.getPropProp(pointer);
			
			%CET: Computational Efficiency Trick
			ramanexperimentpf_description_list = { 'ELCLASS (constant, string) is the class of the panel figure Raman experiment.'  'NAME (constant, string) is the name of the panel figure Raman experiment.'  'DESCRIPTION (constant, string) is the description of the panel figure Raman experiment.'  'TEMPLATE (parameter, item) is the template of the panel figure Raman experiment.'  'ID (data, string) is a few-letter code for the panel figure Raman experiment.'  'LABEL (metadata, string) is an extended label of the panel figure Raman experiment.'  'NOTES (metadata, string) are some specific notes about the panel figure Raman experiment.'  'TOSTRING (query, string) returns a string that represents the concrete element.'  'WAITBAR (gui, logical) detemines whether to show the waitbar.'  'H_WAITBAR (evanescent, handle) is the waitbar handle.'  'DRAW (query, logical) draws the figure Raman experiment.'  'DRAWN (query, logical) returns whether the panel has been drawn.'  'PARENT (gui, item) is the panel parent.'  'BKGCOLOR (figure, color) is the panel background color.'  'H (evanescent, handle) is the panel handle.'  'SHOW (query, logical) shows the figure containing the panel.'  'HIDE (query, logical) hides the figure containing the panel.'  'DELETE (query, logical) resets the handles when the panel figure graph is deleted.'  'CLOSE (query, logical) closes the figure containing the panel.'  'ST_POSITION (figure, item) determines the panel position.'  'H_TOOLBAR (evanescent, handle) returns the handle of the toolbar.'  'H_TOOLS (evanescent, handlelist) is the list of panel-specific tools from the first.'  'H_AXES (evanescent, handle) is the handle for the axes.'  'ST_AXIS (figure, item) determines the axis settings.'  'LISTENER_ST_AXIS (evanescent, handle) contains the listener to the axis settings to update the pushbuttons.'  'RE (metadata, item) is the Raman experiment.'  'SELECTED_SP (figure, scalar) is the spectrum number to be plotted.'  'SETUP (query, empty) calculates the Raman spectrum and stores it.'  'H_AREA (evanescent, handle) is the handle for the average spectrum area.'  'ST_AREA (figure, item) determines the average spectrum area settings.'  'LISTENER_ST_AREA (evanescent, handle) contains the listener to the average spectrum area settings to update the pushbutton.'  'H_LINE (evanescent, handle) is the handle for the average spectrum line.'  'ST_LINE (figure, item) determines the average spectrum line settings.'  'LISTENER_ST_LINE (evanescent, handle) contains the listener to the average spectrum line settings to update the pushbutton.'  'H_LINES (evanescent, handlelist) is the set of handles for the symbols.'  'LINES (figure, logical) determines whether the single spectra are shown.'  'LINE_DICT (figure, idict) contains the lines of the spectra.'  'H_TITLE (evanescent, handle) is the axis title.'  'ST_TITLE (figure, item) determines the title settings.'  'H_XLABEL (evanescent, handle) is the axis x-label.'  'ST_XLABEL (figure, item) determines the x-label settings.'  'H_YLABEL (evanescent, handle) is the axis y-label.'  'ST_YLABEL (figure, item) determines the y-label settings.' };
			prop_description = ramanexperimentpf_description_list{prop};
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
			%  SETTINGS = PF.GETPROPSETTINGS(POINTER) returns settings of POINTER of PF.
			%  SETTINGS = Element.GETPROPSETTINGS(RamanExperimentPF, POINTER) returns settings of POINTER of RamanExperimentPF.
			%  SETTINGS = PF.GETPROPSETTINGS(RamanExperimentPF, POINTER) returns settings of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPSETTINGS(PF) and Element.GETPROPSETTINGS('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getPropProp, getPropTag, getPropCategory, getPropFormat,
			%  getPropDescription, getPropDefault, checkProp.
			
			prop = RamanExperimentPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % RamanExperimentPF.H_AXES
					prop_settings = Format.getFormatSettings(18);
				case 24 % RamanExperimentPF.ST_AXIS
					prop_settings = 'SettingsAxis';
				case 25 % RamanExperimentPF.LISTENER_ST_AXIS
					prop_settings = Format.getFormatSettings(18);
				case 26 % RamanExperimentPF.RE
					prop_settings = 'RamanExperiment';
				case 27 % RamanExperimentPF.SELECTED_SP
					prop_settings = 'RamanExperiment';
				case 28 % RamanExperimentPF.SETUP
					prop_settings = Format.getFormatSettings(1);
				case 29 % RamanExperimentPF.H_AREA
					prop_settings = Format.getFormatSettings(18);
				case 30 % RamanExperimentPF.ST_AREA
					prop_settings = 'SettingsArea';
				case 31 % RamanExperimentPF.LISTENER_ST_AREA
					prop_settings = Format.getFormatSettings(18);
				case 32 % RamanExperimentPF.H_LINE
					prop_settings = Format.getFormatSettings(18);
				case 33 % RamanExperimentPF.ST_LINE
					prop_settings = 'SettingsLine';
				case 34 % RamanExperimentPF.LISTENER_ST_LINE
					prop_settings = Format.getFormatSettings(18);
				case 35 % RamanExperimentPF.H_LINES
					prop_settings = Format.getFormatSettings(19);
				case 36 % RamanExperimentPF.LINES
					prop_settings = Format.getFormatSettings(4);
				case 37 % RamanExperimentPF.LINE_DICT
					prop_settings = 'SettingsLine';
				case 38 % RamanExperimentPF.H_TITLE
					prop_settings = Format.getFormatSettings(18);
				case 39 % RamanExperimentPF.ST_TITLE
					prop_settings = 'SettingsText';
				case 40 % RamanExperimentPF.H_XLABEL
					prop_settings = Format.getFormatSettings(18);
				case 41 % RamanExperimentPF.ST_XLABEL
					prop_settings = 'SettingsText';
				case 42 % RamanExperimentPF.H_YLABEL
					prop_settings = Format.getFormatSettings(18);
				case 43 % RamanExperimentPF.ST_YLABEL
					prop_settings = 'SettingsText';
				case 4 % RamanExperimentPF.TEMPLATE
					prop_settings = 'RamanExperimentPF';
				otherwise
					prop_settings = getPropSettings@PanelFig(prop);
			end
		end
		function prop_default = getPropDefault(pointer)
			%GETPROPDEFAULT returns the default value of a property.
			%
			% DEFAULT = RamanExperimentPF.GETPROPDEFAULT(PROP) returns the default 
			%  value of the property PROP.
			%
			% DEFAULT = RamanExperimentPF.GETPROPDEFAULT(TAG) returns the default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULT(POINTER) returns the default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULT(RamanExperimentPF, POINTER) returns the default value of POINTER of RamanExperimentPF.
			%  DEFAULT = PF.GETPROPDEFAULT(RamanExperimentPF, POINTER) returns the default value of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPDEFAULT(PF) and Element.GETPROPDEFAULT('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also getPropDefaultConditioned, getPropProp, getPropTag, getPropSettings, 
			%  getPropCategory, getPropFormat, getPropDescription, checkProp.
			
			prop = RamanExperimentPF.getPropProp(pointer);
			
			switch prop %CET: Computational Efficiency Trick
				case 23 % RamanExperimentPF.H_AXES
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 24 % RamanExperimentPF.ST_AXIS
					prop_default = SettingsAxis('AXIS', true, 'GRID', false, 'EQUAL', false);
				case 25 % RamanExperimentPF.LISTENER_ST_AXIS
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 26 % RamanExperimentPF.RE
					prop_default = Format.getFormatDefault(8, RamanExperimentPF.getPropSettings(prop));
				case 27 % RamanExperimentPF.SELECTED_SP
					prop_default = 1;
				case 28 % RamanExperimentPF.SETUP
					prop_default = Format.getFormatDefault(1, RamanExperimentPF.getPropSettings(prop));
				case 29 % RamanExperimentPF.H_AREA
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 30 % RamanExperimentPF.ST_AREA
					prop_default = Format.getFormatDefault(8, RamanExperimentPF.getPropSettings(prop));
				case 31 % RamanExperimentPF.LISTENER_ST_AREA
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 32 % RamanExperimentPF.H_LINE
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 33 % RamanExperimentPF.ST_LINE
					prop_default = SettingsLine('SYMBOLSIZE', 1);
				case 34 % RamanExperimentPF.LISTENER_ST_LINE
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 35 % RamanExperimentPF.H_LINES
					prop_default = Format.getFormatDefault(19, RamanExperimentPF.getPropSettings(prop));
				case 36 % RamanExperimentPF.LINES
					prop_default = true;
				case 37 % RamanExperimentPF.LINE_DICT
					prop_default = Format.getFormatDefault(10, RamanExperimentPF.getPropSettings(prop));
				case 38 % RamanExperimentPF.H_TITLE
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 39 % RamanExperimentPF.ST_TITLE
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 40 % RamanExperimentPF.H_XLABEL
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 41 % RamanExperimentPF.ST_XLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle');
				case 42 % RamanExperimentPF.H_YLABEL
					prop_default = Format.getFormatDefault(18, RamanExperimentPF.getPropSettings(prop));
				case 43 % RamanExperimentPF.ST_YLABEL
					prop_default = SettingsText('VISIBLE', true, 'FONTSIZE', 24, 'HALIGN', 'center', 'VALIGN', 'middle', 'ROTATION', 90);
				case 1 % RamanExperimentPF.ELCLASS
					prop_default = 'RamanExperimentPF';
				case 2 % RamanExperimentPF.NAME
					prop_default = 'Panel figure Raman experiment';
				case 3 % RamanExperimentPF.DESCRIPTION
					prop_default = 'RamanExperimentPF manages the basic functionalities to plot of a Raman experiment.';
				case 4 % RamanExperimentPF.TEMPLATE
					prop_default = Format.getFormatDefault(8, RamanExperimentPF.getPropSettings(prop));
				case 5 % RamanExperimentPF.ID
					prop_default = 'RamanExperimentPF ID';
				case 6 % RamanExperimentPF.LABEL
					prop_default = 'RamanExperimentPF label';
				case 7 % RamanExperimentPF.NOTES
					prop_default = 'RamanExperimentPF notes';
				otherwise
					prop_default = getPropDefault@PanelFig(prop);
			end
		end
		function prop_default = getPropDefaultConditioned(pointer)
			%GETPROPDEFAULTCONDITIONED returns the conditioned default value of a property.
			%
			% DEFAULT = RamanExperimentPF.GETPROPDEFAULTCONDITIONED(PROP) returns the conditioned default 
			%  value of the property PROP.
			%
			% DEFAULT = RamanExperimentPF.GETPROPDEFAULTCONDITIONED(TAG) returns the conditioned default 
			%  value of the property with tag TAG.
			%
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(POINTER) returns the conditioned default value of POINTER of PF.
			%  DEFAULT = Element.GETPROPDEFAULTCONDITIONED(RamanExperimentPF, POINTER) returns the conditioned default value of POINTER of RamanExperimentPF.
			%  DEFAULT = PF.GETPROPDEFAULTCONDITIONED(RamanExperimentPF, POINTER) returns the conditioned default value of POINTER of RamanExperimentPF.
			%
			% Note that the Element.GETPROPDEFAULTCONDITIONED(PF) and Element.GETPROPDEFAULTCONDITIONED('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also conditioning, getPropDefault, getPropProp, getPropTag, 
			%  getPropSettings, getPropCategory, getPropFormat, getPropDescription, 
			%  checkProp.
			
			prop = RamanExperimentPF.getPropProp(pointer);
			
			prop_default = RamanExperimentPF.conditioning(prop, RamanExperimentPF.getPropDefault(prop));
		end
	end
	methods (Static) % checkProp
		function prop_check = checkProp(pointer, value)
			%CHECKPROP checks whether a value has the correct format/error.
			%
			% CHECK = PF.CHECKPROP(POINTER, VALUE) checks whether
			%  VALUE is an acceptable value for the format of the property
			%  POINTER (POINTER = PROP or TAG).
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  CHECK = PF.CHECKPROP(POINTER, VALUE) checks VALUE format for PROP of PF.
			%  CHECK = Element.CHECKPROP(RamanExperimentPF, PROP, VALUE) checks VALUE format for PROP of RamanExperimentPF.
			%  CHECK = PF.CHECKPROP(RamanExperimentPF, PROP, VALUE) checks VALUE format for PROP of RamanExperimentPF.
			% 
			% PF.CHECKPROP(POINTER, VALUE) throws an error if VALUE is
			%  NOT an acceptable value for the format of the property POINTER.
			%  Error id: BRAPH2:RamanExperimentPF:WrongInput
			% 
			% Alternative forms to call this method are (POINTER = PROP or TAG):
			%  PF.CHECKPROP(POINTER, VALUE) throws error if VALUE has not a valid format for PROP of PF.
			%   Error id: BRAPH2:RamanExperimentPF:WrongInput
			%  Element.CHECKPROP(RamanExperimentPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RamanExperimentPF.
			%   Error id: BRAPH2:RamanExperimentPF:WrongInput
			%  PF.CHECKPROP(RamanExperimentPF, PROP, VALUE) throws error if VALUE has not a valid format for PROP of RamanExperimentPF.
			%   Error id: BRAPH2:RamanExperimentPF:WrongInput]
			% 
			% Note that the Element.CHECKPROP(PF) and Element.CHECKPROP('RamanExperimentPF')
			%  are less computationally efficient.
			%
			% See also Format, getPropProp, getPropTag, getPropSettings,
			% getPropCategory, getPropFormat, getPropDescription, getPropDefault.
			
			prop = RamanExperimentPF.getPropProp(pointer);
			
			switch prop
				case 23 % RamanExperimentPF.H_AXES
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 24 % RamanExperimentPF.ST_AXIS
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				case 25 % RamanExperimentPF.LISTENER_ST_AXIS
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 26 % RamanExperimentPF.RE
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				case 27 % RamanExperimentPF.SELECTED_SP
					check = Format.checkFormat(11, value, RamanExperimentPF.getPropSettings(prop));
				case 28 % RamanExperimentPF.SETUP
					check = Format.checkFormat(1, value, RamanExperimentPF.getPropSettings(prop));
				case 29 % RamanExperimentPF.H_AREA
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 30 % RamanExperimentPF.ST_AREA
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				case 31 % RamanExperimentPF.LISTENER_ST_AREA
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 32 % RamanExperimentPF.H_LINE
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 33 % RamanExperimentPF.ST_LINE
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				case 34 % RamanExperimentPF.LISTENER_ST_LINE
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 35 % RamanExperimentPF.H_LINES
					check = Format.checkFormat(19, value, RamanExperimentPF.getPropSettings(prop));
				case 36 % RamanExperimentPF.LINES
					check = Format.checkFormat(4, value, RamanExperimentPF.getPropSettings(prop));
				case 37 % RamanExperimentPF.LINE_DICT
					check = Format.checkFormat(10, value, RamanExperimentPF.getPropSettings(prop));
				case 38 % RamanExperimentPF.H_TITLE
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 39 % RamanExperimentPF.ST_TITLE
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				case 40 % RamanExperimentPF.H_XLABEL
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 41 % RamanExperimentPF.ST_XLABEL
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				case 42 % RamanExperimentPF.H_YLABEL
					check = Format.checkFormat(18, value, RamanExperimentPF.getPropSettings(prop));
				case 43 % RamanExperimentPF.ST_YLABEL
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				case 4 % RamanExperimentPF.TEMPLATE
					check = Format.checkFormat(8, value, RamanExperimentPF.getPropSettings(prop));
				otherwise
					if prop <= 22
						check = checkProp@PanelFig(prop, value);
					end
			end
			
			if nargout == 1
				prop_check = check;
			elseif ~check
				error( ...
					['BRAPH2' ':RamanExperimentPF:' 'WrongInput'], ...
					['BRAPH2' ':RamanExperimentPF:' 'WrongInput' '\n' ...
					'The value ' tostring(value, 100, ' ...') ' is not a valid property ' RamanExperimentPF.getPropTag(prop) ' (' RamanExperimentPF.getFormatTag(RamanExperimentPF.getPropFormat(prop)) ').'] ...
					)
			end
		end
	end
	methods (Access=protected) % postset
		function postset(pf, prop)
			%POSTSET postprocessing after a prop has been set.
			%
			% POSTPROCESSING(EL, PROP) postprocessesing after PROP has been set. By
			%  default, this function does not do anything, so it should be implemented
			%  in the subclasses of Element when needed.
			%
			% This postprocessing occurs only when PROP is set.
			%
			% See also conditioning, preset, checkProp, postprocessing, calculateValue,
			%  checkValue.
			
			switch prop
				case 24 % RamanExperimentPF.ST_AXIS
					if pf.get('DRAWN')
					    toolbar = pf.get('H_TOOLBAR');
					    if check_graphics(toolbar, 'uitoolbar')
					        set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
					        set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
					    end
					end
					
				case 27 % RamanExperimentPF.SELECTED_SP
					pf.get('SETUP')
					
				case 36 % RamanExperimentPF.LINES
					if ~pf.get('LINES') % false
					    h_lines = pf.get('H_LINES');
					    for i = 1:1:length(h_lines)
					        set(h_lines{i}, 'Visible', false)
					    end        
					else % true
					    % triggers the update of LINE_DICT
					    pf.set('LINE_DICT', pf.get('LINE_DICT'))
					end
					
					% update state of toggle tool
					toolbar = pf.get('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    set(findobj(toolbar, 'Tag', 'TOOL.Lines'), 'State', pf.get('LINES'))
					end
					
				case 37 % RamanExperimentPF.LINE_DICT
					if pf.get('LINES') && ~isa(pf.getr('RE'), 'NoValue')
					    
					    sp_dict = pf.get('RE').get('SP_DICT');
					    if sp_dict.get('LENGTH')
					        sp = sp_dict.get('IT', pf.get('SELECTED_SP'));
					    else
					        sp = Spectrum();
					    end
					
						if pf.get('LINE_DICT').get('LENGTH') == 0 && sp.get('NO_AQUISITIONS')
					        for i = 1:1:sp.get('NO_AQUISITIONS')
					            lines{i} = SettingsLine( ...
					                'PANEL', pf, ...
					                'PROP', 35, ...
					                'I', i, ...
					                'VISIBLE', true, ...
					                'ID', sp.get('ID'), ...
					                'LINEWIDTH', .5, ...
					                'LINECOLOR', [.7 .7 .7], ...
					                'SYMBOL', 'none' ...
					                );
					        end
					        pf.get('LINE_DICT').set('IT_LIST', lines)
					    end
					    
					    for i = 1:1:sp.get('NO_AQUISITIONS')
					        pf.get('LINE_DICT').get('IT', i).get('SETUP')
					    end
					end
					
				otherwise
					if prop <= 22
						postset@PanelFig(pf, prop);
					end
			end
		end
	end
	methods (Access=protected) % calculate value
		function value = calculateValue(pf, prop, varargin)
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
				case 23 % RamanExperimentPF.H_AXES
					h_axes = uiaxes( ...
					    'Parent', pf.memorize('H'), ...
					    'Tag', 'H_AXES', ...
					    'Units', 'normalized', ...
					    'OuterPosition', [.2 .2 .6 .6] ... % % % %TODO transform this into a prop?
					    );
					h_axes.Toolbar.Visible = 'on';
					%h_axes.Interactions = [];
					box(h_axes, 'on')
					hold(h_axes, 'on')
					value = h_axes;
					
				case 25 % RamanExperimentPF.LISTENER_ST_AXIS
					value = listener(pf.get('ST_AXIS'), 'PropSet', @cb_listener_st_axis);
					
				case 28 % RamanExperimentPF.SETUP
					sp_dict = pf.get('RE').get('SP_DICT');
					
					if sp_dict.get('LENGTH')
					    sp = sp_dict.get('IT', pf.get('SELECTED_SP'));
					
					    x = sp.get('WAVELENGTH');
					    y = sp.get('INTENSITY_MEAN');
					
					    pf.memorize('ST_AREA').set('X', [x(1); x; x(end)], 'Y', [0; y; 0])
					
					    for i = 1:1:sp.get('NO_AQUISITIONS')
					        pf.get('LINE_DICT').get('IT', i).set('X', x, 'Y', sp.get('INTENSITY', i))
					    end
					
					    % % % set the other lines
					
					    pf.memorize('ST_LINE').set('X', x, 'Y', y)
					
					    xlim = [ ...
					        min(cellfun(@(sp) min(sp.get('WAVELENGTH')), sp_dict.get('IT_LIST'))) ...
					        max(cellfun(@(sp) max(sp.get('WAVELENGTH')), sp_dict.get('IT_LIST'))) ...
					        ];
					    set(pf.get('H_AXES'), 'XLim', xlim);
					
					    ylim = [ ...
					        min(sp.get('INTENSITY_MEAN')) ... % min(cellfun(@(sp) min(sp.get('INTENSITY_MEAN')), sp_dict.get('IT_LIST'))) ...
					        max(sp.get('INTENSITY_MEAN')) ... % max(cellfun(@(sp) max(sp.get('INTENSITY_MEAN')), sp_dict.get('IT_LIST'))) ...
					        ];
					    set(pf.get('H_AXES'), 'YLim', ylim);
					    
					    pf.get('ST_TITLE').set( ...
					        'TXT', sp.get('LABEL'), ...
					        'X', .5 * (xlim(2) + xlim(1)), ...
					        'Y', ylim(2) + .07 * (ylim(2) - ylim(1)), ...
					        'Z', 0 ...
					        )
					    pf.get('ST_XLABEL').set( ...
					        'TXT', 'Raman Shift (cm-1)', ...
					        'X', .5 * (xlim(2) + xlim(1)), ...
					        'Y', ylim(1) - .10 * (ylim(2) - ylim(1)), ...
					        'Z', 0 ...
					        )
					    pf.get('ST_YLABEL').set( ...
					        'TXT', 'Intensity', ...
					        'X', xlim(1) - .14 * (xlim(2) - xlim(1)), ...
					        'Y', .5 * (ylim(2) + ylim(1)), ...
					        'Z', 0 ...
					        )
					end
					
					value = [];
					
				case 29 % RamanExperimentPF.H_AREA
					value = fill(pf.get('H_AXES'), [0], [0], 'k');
					
				case 31 % RamanExperimentPF.LISTENER_ST_AREA
					value = listener(pf.get('ST_AREA'), 'PropSet', @cb_listener_st_area);
					
				case 32 % RamanExperimentPF.H_LINE
					value = plot(pf.get('H_AXES'), [0], [0], 'b', 'LineWidth', 2);
					
				case 34 % RamanExperimentPF.LISTENER_ST_LINE
					value = listener(pf.get('ST_LINE'), 'PropSet', @cb_listener_st_line);
					
				case 35 % RamanExperimentPF.H_LINES
					sp_dict = pf.memorize('RE').get('SP_DICT');
					if sp_dict.get('LENGTH')
					    L = sp_dict.get('IT', pf.get('SELECTED_SP')).get('NO_AQUISITIONS');
					else
					    L = 0;
					end
					
					h_lines = cell(1, L);
					for i = 1:1:L
					    h_lines{i} = plot(0, 0, ...
					        'Parent', pf.get('H_AXES'), ...
					        'Tag', ['H_LINES{' int2str(i) '}'], ...
					        'Visible', false ...
					        );
					end
					value = h_lines;
					
				case 38 % RamanExperimentPF.H_TITLE
					value = title(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_TITLE'), 'NoValue')
					    st = pf.memorize('ST_TITLE');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', pf.get('RE').get('LABEL'), ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 40 % RamanExperimentPF.H_XLABEL
					value = xlabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_XLABEL'), 'NoValue')
					    st = pf.memorize('ST_XLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Wavelength', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 42 % RamanExperimentPF.H_YLABEL
					value = ylabel(pf.get('H_AXES'), '');
					
					if isa(pf.getr('ST_YLABEL'), 'NoValue')
					    st = pf.memorize('ST_YLABEL');
					    
					    position = get(value, 'Position');
					    st.set( ...
					        'TXT', 'Intensity', ...
					        'X', position(1), ...
					        'Y', position(2), ...
					        'Z', position(3) ...
					        )
					end
					
				case 11 % RamanExperimentPF.DRAW
					value = calculateValue@PanelFig(pf, 11, varargin{:}); % also warning
					if value
					    pf.memorize('H_AXES')
					
					    pf.memorize('ST_AXIS').set('PANEL', pf, 'PROP', 23).get('SETUP')
					    pf.memorize('LISTENER_ST_AXIS');
					
					    pf.memorize('H_AREA')
					    pf.memorize('ST_AREA').set('PANEL', pf, 'PROP', 29).get('SETUP')
					    pf.memorize('LISTENER_ST_AREA');
					
					    pf.memorize('H_LINES')
					    pf.set('LINES', pf.get('LINES')) % sets also LINE_DICT  
					
					    pf.memorize('H_LINE')
					    pf.memorize('ST_LINE').set('PANEL', pf, 'PROP', 32).get('SETUP')
					    pf.memorize('LISTENER_ST_LINE');
					
					    pf.memorize('H_TITLE')
					    pf.memorize('ST_TITLE').set('PANEL', pf, 'PROP', 38).get('SETUP')
					
					    pf.memorize('H_XLABEL')
					    pf.memorize('ST_XLABEL').set('PANEL', pf, 'PROP', 40).get('SETUP')
					
					    pf.memorize('H_YLABEL')
					    pf.memorize('ST_YLABEL').set('PANEL', pf, 'PROP', 42).get('SETUP')
					
					    pf.get('SETUP')
					end
					
				case 18 % RamanExperimentPF.DELETE
					value = calculateValue@PanelFig(pf, 18, varargin{:}); % also warning
					if value
					    pf.set('H_AXES', Element.getNoValue())
					
					    pf.set('LISTENER_ST_AXIS', Element.getNoValue())
					    
					    pf.set('H_AREA', Element.getNoValue())
					    pf.set('LISTENER_ST_AREA', Element.getNoValue())
					 
					    pf.set('H_LINES', Element.getNoValue())
					
					    pf.set('H_LINE', Element.getNoValue())
					    pf.set('LISTENER_ST_LINE', Element.getNoValue())
					
					    pf.set('H_TITLE', Element.getNoValue())
					
					    pf.set('H_XLABEL', Element.getNoValue())
					    
					    pf.set('H_YLABEL', Element.getNoValue())
					end
					
				case 22 % RamanExperimentPF.H_TOOLS
					toolbar = pf.memorize('H_TOOLBAR');
					if check_graphics(toolbar, 'uitoolbar')
					    value = calculateValue@PanelFig(pf, 22);
					    
					    tool_separator_1 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Axis
					    tool_axis = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Axis', ...
					        'Separator', 'on', ...
					        'State', pf.get('ST_AXIS').get('AXIS'), ...
					        'Tooltip', 'Show axis', ...
					        'CData', imread('icon_axis.png'), ...
					        'OnCallback', {@cb_axis, true}, ...
					        'OffCallback', {@cb_axis, false});
					
					    % Grid
					    tool_grid = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Grid', ...
					        'State', pf.get('ST_AXIS').get('GRID'), ...
					        'Tooltip', 'Show grid', ...
					        'CData', imread('icon_grid.png'), ...
					        'OnCallback', {@cb_grid, true}, ...
					        'OffCallback', {@cb_grid, false});
					
					    tool_separator_2 = uipushtool(toolbar, 'Separator', 'on', 'Visible', 'off');
					
					    % Measure Area
					    tool_area = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Area', ...
					        'State', pf.get('ST_AREA').get('VISIBLE'), ...
					        'Tooltip', 'Show measure area', ...
					        'CData', imresize(imread('icon_area.png'), [16 16]), ...
					        'OnCallback', {@cb_area, true}, ...
					        'OffCallback', {@cb_area, false});
					    
					    % Measure Line
					    tool_line = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Line', ...
					        'State', pf.get('ST_LINE').get('VISIBLE'), ...
					        'Tooltip', 'Show measure line', ...
					        'CData', imresize(imread('icon_line.png'), [16 16]), ...
					        'OnCallback', {@cb_line, true}, ...
					        'OffCallback', {@cb_line, false});
					
					    % Symbols
					    tool_lines = uitoggletool(toolbar, ...
					        'Tag', 'TOOL.Lines', ...
					        'Separator', 'on', ...
					        'State', pf.get('LINES'), ...
					        'Tooltip', 'Show Lines', ...
					        'CData', imresize(imread('icon_3lines_mono.png'), [16 16]), ...
					        'OnCallback', {@cb_lines, true}, ...
					        'OffCallback', {@cb_lines, false});
					
					    value = {value{:}, ...
					        tool_separator_1, ...
					        tool_axis, tool_grid, ...
					        tool_separator_2, ...
					        tool_area, tool_line, tool_lines ...
					        };
					else
					    value = {};
					end
					
				otherwise
					if prop <= 22
						value = calculateValue@PanelFig(pf, prop, varargin{:});
					else
						value = calculateValue@Element(pf, prop, varargin{:});
					end
			end
			
			function cb_listener_st_axis(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Grid'), 'State', pf.get('ST_AXIS').get('GRID'))
			            set(findobj(toolbar, 'Tag', 'TOOL.Axis'), 'State', pf.get('ST_AXIS').get('AXIS'))
			        end
			    end
			end
			function cb_listener_st_area(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Area'), 'State', pf.get('ST_AREA').get('VISIBLE'))
			        end
			    end
			end
			function cb_listener_st_line(~, ~)
			    if pf.get('DRAWN')
			        toolbar = pf.get('H_TOOLBAR');
			        if check_graphics(toolbar, 'uitoolbar')
			            set(findobj(toolbar, 'Tag', 'TOOL.Line'), 'State', pf.get('ST_LINE').get('VISIBLE'))
			        end
			    end
			end
			function cb_lines(~, ~, lines) % (src, event)
			    pf.set('LINES', lines)
			end
			function cb_axis(~, ~, axis) % (src, event)
			    pf.get('ST_AXIS').set('AXIS', axis);
			    
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_grid(~, ~, grid) % (src, event)
			    pf.get('ST_AXIS').set('GRID', grid);
			
			    % triggers the update of ST_AXIS
			    pf.set('ST_AXIS', pf.get('ST_AXIS'))
			end
			function cb_area(~, ~, visible) % (src, event)
			    pf.get('ST_AREA').set('VISIBLE', visible)
			
			    % triggers the update of ST_AREA
			    pf.set('ST_AREA', pf.get('ST_AREA'))
			end
			function cb_line(~, ~, visible) % (src, event)
				pf.get('ST_LINE').set('VISIBLE', visible)
			
			    % triggers the update of ST_LINE
			    pf.set('ST_LINE', pf.get('ST_LINE'))
			end
		end
	end
	methods % GUI
		function pr = getPanelProp(pf, prop, varargin)
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
				case 24 % RamanExperimentPF.ST_AXIS
					pr = SettingsAxisPP('EL', pf, 'PROP', 24, varargin{:});
					
				case 27 % RamanExperimentPF.SELECTED_SP
					pr = RamanExperimentPFPP_SelectedSp('EL', pf, 'PROP', 27);
					
				case 30 % RamanExperimentPF.ST_AREA
					pr = SettingsAreaPP('EL', pf, 'PROP', 30, varargin{:});
					
				case 33 % RamanExperimentPF.ST_LINE
					pr = SettingsLinePP('EL', pf, 'PROP', 33, varargin{:});
					
				case 37 % RamanExperimentPF.LINE_DICT
					pr = PanelPropIDictTable('EL', pf, 'PROP', 37, ...
					    'COLS', [-1 15 19 20 21 22 23 24 25], ...
					    varargin{:});
					
				case 39 % RamanExperimentPF.ST_TITLE
					pr = SettingsTextPP('EL', pf, 'PROP', 39, varargin{:});
					
				case 41 % RamanExperimentPF.ST_XLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 41, varargin{:});
					
				case 43 % RamanExperimentPF.ST_YLABEL
					pr = SettingsTextPP('EL', pf, 'PROP', 43, varargin{:});
					
				otherwise
					pr = getPanelProp@PanelFig(pf, prop, varargin{:});
					
			end
		end
	end
end
