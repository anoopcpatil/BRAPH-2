%% ¡header!
CosmicRayNoiseRemover < REAnalysisModule (crnr, Cosmic Ray Noise Remover) is an REAnalysisModule that reads raw Raman spectra and outputs fixed spectra (with cosmic ray noise removed).

%%% ¡description!
A Cosmic Ray Noise Remover Module (CosmicRayNoiseRemover) is an REAnalysisModule that 
reads the raw Raman spectra and evaluates the fixed spectra with cosmic ray noise removed.
It also provides basic functionalities to view and plot the fixed spectra. 

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover'

%%% ¡prop!
NAME (constant, string) is the name of the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover reads and analyzes raw Raman spectra and evaluates and plots the resulting fixed spectra.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Cosmic Ray Noise Remover.
%%%% ¡settings!
'CosmicRayNoiseRemover'

%%% ¡prop!
ID (data, string) is a few-letter code for the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Cosmic Ray Noise Remover.
%%%% ¡default!
'CosmicRayNoiseRemover notes'


%%% ¡prop!
RE_OUT (query, item) is the output Raman Experiment with fixed spectra as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
% calculateValue using REAnalysisModule with parameters crnr and 'RE_OUT'; 
% returns the query, which is assigned to the variable re_out
re_out = calculateValue@REAnalysisModule(crnr, prop);

% Create a copy of REAnalysisModule 'RE_OUT' 
crnr_re_out = re_out;

% Get the number of items in the indexed dictionary SP_DICT of
% REAnalysisModule 'RE_OUT'
dict_length = re_out.get('SP_DICT').get('LENGTH')

for n = 1:1:dict_length
     % Read raw intensities from the REAnalysisModule 'RE_OUT'
     raw_intensities = re_out.get('SP_DICT').get('IT', n).get('INTENSITIES');

     % Apply median filter to raw intensities
     fixed_intensities = medfilt1(raw_intensities); 

     % Set the intensities of the nth spectrum in the 'SP_DICT' of crnr_re_out 
     % to fixed intensities evaluated using the nth raw spectrum of 
     % REAnalysisModule
     crnr_re_out.get('SP_DICT').get('IT', n).set('INTENSITIES', fixed_intensities)
end

% Memorize the updated 'SP_DICT'
crnr_re_out.memorize('SP_DICT');

% Set the re_out to RE_OUT
value = crnr_re_out;
