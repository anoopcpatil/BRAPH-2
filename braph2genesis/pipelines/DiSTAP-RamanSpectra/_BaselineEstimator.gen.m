%% ¡header!
BaselineEstimator < REAnalysisModule (be, Baseline Estimator) is an REAnalysisModule that reads smooth Raman spectra and outputs baselines.

%%% ¡description!
A Baseline Estimator Module (BaselineEstimator) is an REAnalysisModule that 
reads the smooth Raman spectra (from SmoothingFilter) and evaluates 
the baselines. It also provides basic functionalities to view and 
plot the baselines. 

%%% ¡seealso!
REAnalysisModule, CosmicRayNoiseRemover, SmoothingFilter, RamanExperiment, Spectrum


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator'

%%% ¡prop!
NAME (constant, string) is the name of the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Baseline Estimator.
%%%% ¡default!
'BaselineEstimator reads and analyzes smooth Raman spectra and evaluates and plots the baselines.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Baseline Estimator.
%%%% ¡settings!
'BaselineEstimator'

%%% ¡prop!
ID (data, string) is a few-letter code for the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Baseline Estimator.
%%%% ¡default!
'BaselineEstimator label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Baseline Estimator.
%%%% ¡default!
'BaselineEstimator notes'


%%% ¡prop!
RE_OUT (query, item) is the output Raman Experiment with baselines as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
% calculateValue using REAnalysisModule with parameters be and 'RE_OUT'; 
% returns the query, which is assigned to the variable re_out
re_out = calculateValue@REAnalysisModule(be, prop);

% Create a copy of REAnalysisModule 'RE_OUT' 
be_re_out = re_out;

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

     % Baseline estimation using Lieberfit function
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
     be_re_out.get('SP_DICT').get('IT', n).set('INTENSITIES', baselines)
end

% Memorize the updated 'SP_DICT' of BaselineEstimator
be_re_out.memorize('SP_DICT');

% Set the be_re_out to 'RE_OUT' of BaselineEstimator
value = be_re_out;
