%% ¡header!
CosmicRayRemover < REAnalysisModule(crr, Cosmic Ray Remover) is a Raman pre-processing element that removes cosmic ray noise from the raw Raman spectra.

%%% ¡description!
A Cosmic Ray Remover (CosmicRayRemover) reads acquired raw Raman spectra from RamanExperiment element and calculates fixed spectra. Fixed spectra are the Raman spectra with cosmic ray noise removed.

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Cosmic Ray Remover.
%%%% ¡default!
'CosmicRayRemover'

%%% ¡prop!
NAME (constant, string) is the name of the Cosmic Ray Remover.
%%%% ¡default!
'CosmicRayRemover'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Cosmic Ray Remover.
%%%% ¡default!
'CosmicRayRemover reads acquired raw Raman spectral intensities from RamanExperiment element and calculates fixed spectra'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Cosmic Ray Remover.
%%%% ¡settings!
'CosmicRayRemover'

%%% ¡prop!
ID (data, string) is a few-letter code for the Cosmic Ray Remover.
%%%% ¡default!
'CosmicRayRemover ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Cosmic Ray Remover.
%%%% ¡default!
'CosmicRayRemover label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Cosmic Ray Remover.
%%%% ¡default!
'CosmicRayRemover notes'



%% ¡props!

%%% ¡prop!
RE_IN (data, item) is the cloned Raman Experiment for reading the raw Raman spectra.
%%%% ¡settings!
'RamanExperiment'


%%% ¡prop!
RE_OUT (result, item) is the Raman Experiment with cosmic-ray-noise-removed spectra as a result.
%%%% ¡settings!
'RamanExperiment'

%%%% ¡calculate!
% Temporary Raman Experiment
re_out = RamanExperiment('ID', crr.get('RE_IN').get('ID'), ...
                          'LABEL', crr.get('RE_IN').get('LABEL'), ...
                          'NOTES', crr.get('RE_IN').get('NOTES'))

for n = 1:1:crr.get('RE_IN').get('SP_DICT').get('LENGTH')
     raw_intensities = crr.get('RE_IN').get('SP_DICT').get('IT', n).get('INTENSITIES');
     fixed_intensities = medfilt1(raw_intensities);

     sp = Spectrum( ...
         'INTENSITIES', fixed_intensities, ...
         'WAVELENGTH', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('WAVELENGTH'), ...
         'ID', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('ID'), ...
         'LABEL', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('LABEL'), ...
         'NOTES', crr.get('RE_IN').get('SP_DICT').get('IT', n).get('NOTES'))

     re_out.memorize('SP_DICT').get('ADD', sp)
end
value = re_out;

