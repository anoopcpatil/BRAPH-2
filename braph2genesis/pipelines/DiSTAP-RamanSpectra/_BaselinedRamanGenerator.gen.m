%% ¡header!
BaselinedRamanGenerator < REAnalysisModule (brgen, Baselined Raman Generator) is an REAnalysisModule that reads smooth Raman spectra and outputs baselines.

%%% ¡description!
A Baselined Raman Generator Module (BaselinedRamanGenerator) is an REAnalysisModule
that reads the smooth Raman spectra (from SmoothingFilter) and evaluates 
the baselined Raman spectra (smooth spectra with baselines removed). 
It also provides basic functionalities to view and plot the baselined spectra. 

%%% ¡seealso!
REAnalysisModule, CosmicRayNoiseRemover, SmoothingFilter, BaselineEstimator, RamanExperiment, Spectrum


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Baselined Raman Generator.
%%%% ¡default!
'BaselinedRamanGenerator'

%%% ¡prop!
NAME (constant, string) is the name of the Baselined Raman Generator.
%%%% ¡default!
'BaselinedRamanGenerator'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Baselined Raman Generator.
%%%% ¡default!
'BaselinedRamanGenerator reads and analyzes smooth Raman spectra and evaluates and plots the baselined Raman spectra.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Baselined Raman Generator.
%%%% ¡settings!
'BaselinedRamanGenerator'

%%% ¡prop!
ID (data, string) is a few-letter code for the Baselined Raman Generator.
%%%% ¡default!
'BaselinedRamanGenerator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Baselined Raman Generator.
%%%% ¡default!
'BaselinedRamanGenerator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Baselined Raman Generator.
%%%% ¡default!
'BaselinedRamanGenerator notes'


%%% ¡prop!
RE_OUT (query, item) is the output Raman Experiment with baselined Raman spectra as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
% calculateValue using REAnalysisModule with parameters brgen and 'RE_OUT'; 
% returns the query, which is assigned to the variable re_out
re_out = calculateValue@REAnalysisModule(brgen, prop);

% Create a copy of REAnalysisModule 'RE_OUT' 
brgen_re_out = re_out;

% Get the 'RE_OUT' from SmoothingFilter
% 1. Pass 'RE_OUT' of REAnalysisModule to 'RE_IN' of CosmicRayNoiseRemover
% 2. Pass 'RE_OUT' of CosmicRayNoiseRemover to 'RE_IN' of SmoothingFilter
% 3. Read 'RE_OUT' of SmoothingFilter   
crnr = CosmicRayNoiseRemover('RE_IN', re_out)
sf = SmoothingFilter('RE_IN', crnr.get('RE_OUT'))
sf_re_out = sf.get('RE_OUT')

% Get the number of items in the indexed dictionary SP_DICT of
% SmoothingFilter 'RE_OUT'
dict_length = sf_re_out.get('SP_DICT').get('LENGTH')

for n = 1:1:dict_length
     % Read smooth intensities from the SmoothingFilter 'RE_OUT'
     smooth_intensities = sf_re_out.get('SP_DICT').get('IT', n).get('INTENSITIES');

     % Baselined Raman spectra using Lieberfit function
     % Set the order of the polynomial for Lieberfit function
     LFIT_POLYORDER = 5;
     % Set the number of odd points in the window for Lieberfit function
     LFIT_ITER = 100;
     % Apply Lieberfit function to smooth intensities from
     % SmoothingFilter
     [baselines, baselined_intensities] = ...
         lieberfit(smooth_intensities', LFIT_POLYORDER, LFIT_ITER);

     % Set the intensities of the nth spectrum in the 'SP_DICT' of be_re_out 
     % to baselines evaluated using the nth smooth spectrum of 
     % SmoothingFilter
     brgen_re_out.get('SP_DICT').get('IT', n).set('INTENSITIES', baselined_intensities)
end

% Memorize the updated 'SP_DICT' of BaselinedRamanGenerator
brgen_re_out.memorize('SP_DICT');

% Set the be_re_out to 'RE_OUT' of BaselinedRamanGenerator
value = brgen_re_out;
