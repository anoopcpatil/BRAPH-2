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
RE_OUT (result, item) is the output Raman Experiment with fixed spectra as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
re_out = calculateValue@REAnalysisModule(crnr, 'RE_OUT');
dict_length = re_out.get('SP_DICT').get('LENGTH')

for n = 1:1:dict_length
     raw_intensities = re_out.get('SP_DICT').get('IT', n).get('INTENSITIES');
     fixed_intensities = medfilt1(raw_intensities);
     sp = Spectrum('INTENSITIES', fixed_intensities)
     re_out.memorize('SP_DICT').get('ADD', sp)
end
value = re_out;



%% ¡tests!

%%% ¡excluded_props!
[REAnalysisModule.TEMPLATE REAnalysisModule.REPF]

%%% ¡test!
%%%% ¡name!
Basic read functions and setting props
%%%% ¡probability!
.01
%%%% ¡code!
m1 = [1 2 3 4 5; 2 4 6 8 10; 3 6 9 12 15; 4 8 12 16 20; 5 10 15 20 25]
m2 = m1 + 1
m3 = m1 + 2
m4 = m1 + 3
m5 = m1 + 4
m6 = m1 + 5
s1 = Spectrum('ID', 'id1', 'LABEL', 'label1', 'NOTES', 'notes1', 'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m1);
s2 = Spectrum('ID', 'id2', 'LABEL', 'label2', 'NOTES', 'notes2', 'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m2);
s3 = Spectrum('ID', 'id3', 'LABEL', 'label3', 'NOTES', 'notes3', 'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m3);
s4 = Spectrum('ID', 'id4', 'LABEL', 'label4', 'NOTES', 'notes4', 'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m4);
s5 = Spectrum('ID', 'id5', 'LABEL', 'label5', 'NOTES', 'notes5', 'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m5);
s6 = Spectrum('ID', 'id6', 'LABEL', 'label6', 'NOTES', 'notes6', 'WAVELENGTH', [1;2;3;4;5], 'INTENSITIES', m6);

items = {s1, s2, s3, s4, s5, s6};

idict_1 = IndexedDictionary( ...
    'ID', 'idict', ...
    'IT_CLASS', 'Spectrum', ...
    'IT_KEY', IndexedDictionary.getPropDefault(IndexedDictionary.IT_KEY), ...
    'IT_LIST', items ...
    );
re = RamanExperiment('ID', 'REid1', 'LABEL', 'RElabel1', 'NOTES', 'REnotes1', 'SP_DICT', idict_1);
ream = REAnalysisModule('ID', 'REAM_TEST1', 'LABEL', 'RE Analysis Test Module 1', 'NOTES', 'Testing RE Analysis Module 1.', 'RE_IN', re);
re_out = ream.get('RE_OUT');

gui = GUIElement('PE', ream, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')
gui.get('CLOSE')
