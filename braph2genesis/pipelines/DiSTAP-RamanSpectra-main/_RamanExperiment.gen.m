%% ¡header!
RamanExperiment < ConcreteElement (re, Raman spectroscopy experiment) is a  Raman spectroscopy experiment.

%%% ¡description!
RamanExperiment is a  Raman spectroscopy experiment.

%%% ¡seealso!

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
RamanExperiment.ID
%%%% ¡title!
Raman Experiment ID

%%% ¡prop!
%%%% ¡id!
RamanExperiment.LABEL
%%%% ¡title!
Raman Experiment NAME

%%% ¡prop!
%%%% ¡id!
RamanExperiment.RESEARCHER
%%%% ¡title!
Researcher's Name

%%% ¡prop!
%%%% ¡id!
RamanExperiment.DATE
%%%% ¡title!
Experiment Date (YYYY-MM-DD)

%%% ¡prop!
%%%% ¡id!
RamanExperiment.PLANT_NAME
%%%% ¡title!
Plant Name

%%% ¡prop!
%%%% ¡id!
RamanExperiment.PLANT_TYPE
%%%% ¡title!
Plant Type

%%% ¡prop!
%%%% ¡id!
RamanExperiment.PLANT_TYPE_COMMENT
%%%% ¡title!
Plant Type Comment (mutant type)

%%% ¡prop!
%%%% ¡id!
RamanExperiment.PLANT_AGE
%%%% ¡title!
Plant Age (days)

%%% ¡prop!
%%%% ¡id!
RamanExperiment.LEAF_NUMBER
%%%% ¡title!
Leaf Number

%%% ¡prop!
%%%% ¡id!
RamanExperiment.GROWTH_MEDIUM
%%%% ¡title!
Growth Medium

%%% ¡prop!
%%%% ¡id!
RamanExperiment.STRESS_TYPE
%%%% ¡title!
Stress Type

%%% ¡prop!
%%%% ¡id!
RamanExperiment.SETUP
%%%% ¡title!
Setup

%%% ¡prop!
%%%% ¡id!
RamanExperiment.LASER_WAVELENGTH
%%%% ¡title!
Laser Wavelength

%%% ¡prop!
%%%% ¡id!
RamanExperiment.LASER_POWER
%%%% ¡title!
Laser Power (mW)

%%% ¡prop!
%%%% ¡id!
RamanExperiment.ACQUISITION_TIME
%%%% ¡title!
Acquisition Time (s)

%%% ¡prop!
%%%% ¡id!
RamanExperiment.SP_DICT
%%%% ¡title!
Raman Spectra

%%% ¡prop!
%%%% ¡id!
RamanExperiment.NOTES
%%%% ¡title!
Raman Experiment NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment'

%%% ¡prop!
NAME (constant, string) is the name of the Raman spectroscopy experiment.
%%%% ¡default!
'Raman spectroscopy experiment'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment is a Raman spectroscopy experiment.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Raman spectroscopy experiment.
%%%% ¡settings!
'RamanExperiment'

%%% ¡prop!
ID (data, string) is a few-letter code for the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment ID'
%%%% ¡gui!
pr = DistapPP_ID('EL', re, 'PROP', RamanExperiment.ID);

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the Raman spectroscopy experiment.
%%%% ¡default!
'RamanExperiment notes'

%% ¡props!

%%% ¡prop!
SP_DICT (data, idict) contains the aquired Raman spectra.
%%%% ¡settings!
'Spectrum'
%%%% ¡gui!
pr = PanelPropIDictTable('EL', re, 'PROP', RamanExperiment.SP_DICT, ... 
    'COLS', [PanelPropIDictTable.SELECTOR Spectrum.CALIBRATION Spectrum.ID Spectrum.LABEL Spectrum.WAVELENGTH Spectrum.INTENSITIES Spectrum.NOTES], ... 
    'ROWNAME', 'numbered', ...
    'MENU_OPEN_ITEMS', true, ...
	varargin{:});

%%% ¡prop!
RESEARCHER (data, option) is the researcher name.
%%%% ¡settings!
{'--', 'Alice', 'Benny', 'Chung Hao', 'Ekta', 'Gajendra', 'Ganga', 'Javier', 'Mervin', 'Michelle', 'Monika', 'Niha', 'Nivedita', 'Pil Joong', 'Praveen', 'Raju', 'Sally', 'Savita', 'Sayuj', 'Sayyid', 'Shilpi', 'Song Yi', 'Thinh', 'Yangyang', 'Zheng Yong'}

%%% ¡prop!
DATE (data, rvector) is the experiment date.
%%%% ¡default!
[2000 1 1]
%%%% ¡gui!
pr = PanelPropRVectorDate('EL', re, 'PROP', RamanExperiment.DATE);

%%% ¡prop!
PLANT_NAME (data, option) is the plant name.
%%%% ¡settings!
{'--', 'Algae', 'Amaranth', 'Arabidopsis', 'Bell Pepper', 'Choy Sum', 'Lettuce', 'Kale', 'Pak Choi', 'Tobacco'}

%%% ¡prop!
PLANT_TYPE (data, option) is the plant type
%%%% ¡settings!
{'--', 'wild type', 'mutant', 'transgenic'} 

%%% ¡prop!
PLANT_TYPE_COMMENT (data, string) is the mutant type (when mutant is selected).

%%% ¡prop!
PLANT_AGE (data, scalar) is the plant age (in weeks).

%%% ¡prop!
LEAF_NUMBER (data, scalar) is the leaf number.

%%% ¡prop!
GROWTH_MEDIUM (data, option) is the growth medium.
%%%% ¡settings!
{'--', 'soil', 'hydroponics'}

%%% ¡prop!
STRESS_TYPE (data, option) is the lant stress type.
%%%% ¡settings!
{'--', 'bacterial', 'drought', 'fungal', 'high light', 'mechanical damage', 'nutrient', 'salt', 'SAS', 'spraying', 'water-logged'}

%%% ¡prop!
SETUP (data, option) is the kind of setup employed.
%%%% ¡settings!
{'--', 'Raman microscope', 'benchtop', 'portable', 'hand-held'}

%%% ¡prop!
LASER_WAVELENGTH (data, option) is the laser wavelength.
%%%% ¡settings!
{'--', '532 nm', '785 nm', '830 nm', '1064 nm'}

%%% ¡prop!
LASER_POWER (data, scalar) is the laser power.

%%% ¡prop!
ACQUISITION_TIME (data, scalar) is the Raman spectral acquisition time.
