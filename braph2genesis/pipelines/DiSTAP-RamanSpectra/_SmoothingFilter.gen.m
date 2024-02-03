%% ¡header!
SmoothingFilter < REAnalysisModule (sf, Smoothing Filter) is an REAnalysisModule that reads fixed Raman spectra (with cosmic ray noise removed) and outputs smooth spectra.

%%% ¡description!
A Smoothing Filter Module (SmoothingFilter) is an REAnalysisModule that 
reads the fixed Raman spectra (with cosmic ray noise removed) and evaluates 
the smooth spectra. It also provides basic functionalities to view and 
plot the smooth spectra. 

%%% ¡seealso!
REAnalysisModule, CosmicRayNoiseRemover, RamanExperiment, Spectrum


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Smoothing Filter.
%%%% ¡default!
'SmoothingFilter'

%%% ¡prop!
NAME (constant, string) is the name of the Smoothing Filter.
%%%% ¡default!
'SmoothingFilter'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Smoothing Filter.
%%%% ¡default!
'SmoothingFilter reads and analyzes fixed Raman spectra and evaluates and plots the resulting smooth spectra.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Smoothing Filter.
%%%% ¡settings!
'SmoothingFilter'

%%% ¡prop!
ID (data, string) is a few-letter code for the Smoothing Filter.
%%%% ¡default!
'SmoothingFilter ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Smoothing Filter.
%%%% ¡default!
'SmoothingFilter label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Smoothing Filter.
%%%% ¡default!
'SmoothingFilter notes'



%%% ¡props!
% %Parameters for Savitzky-Golay smoothing: SGOLAY_POLYORDER & SGOLAY_WINDOW
% %%% ¡prop!
% SGOLAY_POLYORDER (parameter, scalar) is the order of the polynomial for Savitzky-Golay smoothing.
% %%%% ¡default!
% 3
% 
% 
% %%% ¡prop!
% SGOLAY_WINDOW (parameter, scalar) is odd number of points in the window for Savitzky-Golay smoothing.
% %%%% ¡default!
% 9


%%% ¡prop!
RE_OUT (query, item) is the output Raman Experiment with smooth spectra as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
% calculateValue using REAnalysisModule with parameters sf and 'RE_OUT'; 
% returns the query, which is assigned to the variable re_out
re_out = calculateValue@REAnalysisModule(sf, prop);

% Create a copy of REAnalysisModule 'RE_OUT' 
sf_re_out = re_out;

% Get the 'RE_OUT' from CosmicRayNoiseRemover
% 1. Pass 'RE_OUT' of REAnalysisModule to 'RE_IN' of CosmicRayNoiseRemover
% 2. Calculate and read 'RE_OUT' of CosmicRayNoiseRemover
crnr = CosmicRayNoiseRemover('RE_IN', re_out)
crnr_re_out = crnr.get('RE_OUT')

% Get the number of items in the indexed dictionary SP_DICT of
% CosmicRayNoiseRemover 'RE_OUT'
dict_length = crnr_re_out.get('SP_DICT').get('LENGTH')

for n = 1:1:dict_length
     % Read fixed intensities from the CosmicRayNoiseRemover 'RE_OUT'
     fixed_intensities = crnr_re_out.get('SP_DICT').get('IT', n).get('INTENSITIES');

     % Savitzky-Golay filtering 
     % Set the order of the polynomial for Savitzky-Golay smoothing
     SGOLAY_POLYORDER = 3;
     % Consider odd number of points in the window for Savitzky-Golay smoothing
     SGOLAY_WINDOW = 9;
     % Apply Savitzky-Golay filter to fixed intensities from
     % CosmicRayNoiseRemover
     smooth_intensities = sgolayfilt(fixed_intensities, ...
                                     SGOLAY_POLYORDER, ... 
                                     SGOLAY_WINDOW); 

     % Set the intensities of the nth spectrum in the 'SP_DICT' of sf_re_out 
     % to smooth intensities evaluated using the nth fixed spectrum of 
     % CosmicRayNoiseRemover
     sf_re_out.get('SP_DICT').get('IT', n).set('INTENSITIES', smooth_intensities)
end

% Memorize the updated 'SP_DICT' of SmoothingFilter
sf_re_out.memorize('SP_DICT');

% Set the sf_re_out to 'RE_OUT' of SmoothingFilter
value = sf_re_out;
