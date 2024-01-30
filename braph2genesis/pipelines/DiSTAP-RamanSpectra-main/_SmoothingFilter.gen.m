%% ¡header!
SmoothingFilter < ConcreteElement (sgf, Smoothing filter) is a Raman pre-processing element that smoothens fixed spectra. 

%%% ¡description!
A smoothing filter (SmoothingFilter) reads fixed Raman spectra from CosmicRayRemover element as a data matrix prop and calculates smooth spectra as a result matrix prop.

%%% ¡seealso!
RamanExperiment, Spectrum



%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Smoothing filter.
%%%% ¡default!
'SmoothingFilter'

%%% ¡prop!
NAME (constant, string) is the name of the Smoothing filter.
%%%% ¡default!
'SmoothingFilter'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Smoothing filter.
%%%% ¡default!
'SmoothingFilter reads acquired fixed Raman spectral intensities from CosmicRayRemover element and calculates smooth spectra'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Smoothing filter.
%%%% ¡settings!
'SmoothingFilter'

%%% ¡prop!
ID (data, string) is a few-letter code for the Smoothing filter.
%%%% ¡default!
'SmoothingFilter ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Smoothing filter.
%%%% ¡default!
'SmoothingFilter label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Smoothing filter.
%%%% ¡default!
'SmoothingFilter notes'



%% ¡props!

%%% ¡prop!
CRR (data, item) is the Cosmic Ray Remover.
%%%% ¡settings!
'CosmicRayRemover'


%%% ¡prop!
FIXED_INTENSITIES_DICT (query, idict) is the fixed spectra obtained from
a location in a sample at a certain timepoint (spectrum file in a folder)
read from the CosmicRayRemover crr. 
%%%% ¡calculate!
% Raman Experiment
crr = sgf.get('CRR'); % Load Raman Experiment
value = crr.get('FIXED_INTENSITIES_DICT');


%Parameters for Savitzky-Golay smoothing: SGOLAY_POLYORDER & SGOLAY_WINDOW
%%% ¡prop!
SGOLAY_POLYORDER (parameter, scalar) is the order of the polynomial...
    for Savitzky-Golay smoothing.
%%%% ¡default!
3


%%% ¡prop!
SGOLAY_WINDOW (parameter, scalar) is odd number of points in the window...
    for Savitzky-Golay smoothing.
%%%% ¡default!
9


%%% ¡prop!
SMOOTH_INTENSITIES_DICT (result, idict) is the dictionary containing the
smooth spectra (one spectrum per column)for one location of one sample 
at a certain timepoint.
%%%% ¡calculate!
% Smoothing using a Savitzky Golay filter. 
% The parameters window (number of points) w and polynomial order p 
% can be optimized for every set of spectra
% p=3 & w=9 considered. 
% Savitzky-Golay smoothing:
%temp_dict1 is a temporary dictionary used to calculate and store...
% smooth intensities.
temp_dict1 = IndexedDictionary('IT_CLASS', 'Spectrum')

for n = 1:1:sgf.get('FIXED_INTENSITIES_DICT').get('LENGTH')
     fixed_intensities = sgf.get('FIXED_INTENSITIES_DICT').get('IT', n).get('INTENSITIES');
     smooth_intensities = sgolayfilt(fixed_intensities, sgf.get('SGOLAY_POLYORDER'), sgf.get('SGOLAY_WINDOW'));

     sp = Spectrum( ...
         'INTENSITIES', smooth_intensities, ...
         'WAVELENGTH', sgf.get('FIXED_INTENSITIES_DICT').get('IT', n).get('WAVELENGTH'), ...
         'ID', sgf.get('FIXED_INTENSITIES_DICT').get('IT', n).get('ID'), ...
         'LABEL', sgf.get('FIXED_INTENSITIES_DICT').get('IT', n).get('LABEL'), ...
         'NOTES', sgf.get('FIXED_INTENSITIES_DICT').get('IT', n).get('NOTES'))

     temp_dict1.get('ADD', sp)
end
value = temp_dict1;


% %%% ¡prop!
% PFRE (gui, item) is a container of the panel figure for a RamanExperiment.
% %%%% ¡settings!
% 'RamanExperimentPF'
% %%%% ¡postprocessing!
% if isa(sgf.getr('PFRE'), 'NoValue')
%     sgf.memorize('PFRE').set('RE', sgf.memorize('SMOOTH_INTENSITIES_DICT'))
% end
% %%%% ¡gui!
% pr = PanelPropItem('EL', sgf, 'PROP', SmoothingFilter.PFRE, ...
%     'GUICLASS', 'GUIFig', ...
%     'BUTTON_TEXT', 'Plot Smooth Intensities', ...
%     varargin{:});


%%% ¡prop!
SMOOTH_INTENSITIES (query, cvector) is the matrix of smooth intensities
of the N-th spectrum file in the folder - acquired for one location of 
one sample at a certain timepoint.
%%%% ¡calculate!
% returns the smooth intensities of the N-th spectrum file.
if isempty(varargin)
    value = [];
    return
end
n = varargin{1};
smooth_intensities_query = sgf.get('SMOOTH_INTENSITIES_DICT').get('IT', n).get('INTENSITIES');
value = smooth_intensities_query;


%%% ¡prop!
SMOOTH_INTENSITY_MEAN (query, cvector) is the average intensity of the 
smooth spectra - acquired from one location of one sample at a 
certain timepoint (N belongs to 1:sgf.get('FIXED_INTENSITIES_DICT').get('LENGTH')).
%%%% ¡calculate!
% returns the average smooth intensity of the N-th spectrum file.
if isempty(varargin)
    value = [];
    return
end
n = varargin{1};
smooth_intensities_query = sgf.get('SMOOTH_INTENSITIES_DICT').get('IT', n).get('INTENSITIES');
value = mean(smooth_intensities_query, 2);
