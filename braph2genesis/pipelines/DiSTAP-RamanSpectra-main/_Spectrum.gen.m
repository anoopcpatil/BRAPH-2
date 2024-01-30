%% ¡header!
Spectrum < ConcreteElement (sp, spectrum) is a spectrum.

%%% ¡description!
Spectrum contains an acquired spectrum including its wavelength and intensity.

%%% ¡seealso!
RamanExperiment

%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Spectrum.ID
%%%% ¡title!
Spectrum ID

%%% ¡prop!
%%%% ¡id!
Spectrum.LABEL
%%%% ¡title!
Spectrum NAME

%%% ¡prop!
%%%% ¡id!
Spectrum.CALIBRATION
%%%% ¡title!
Calibration Spectrum

%%% ¡prop!
%%%% ¡id!
Spectrum.WAVELENGTH
%%%% ¡title!
Wavelength

%%% ¡prop!
%%%% ¡id!
Spectrum.INTENSITIES
%%%% ¡title!
Raman Spectra

%%% ¡prop!
%%%% ¡id!
Spectrum.NOTES
%%%% ¡title!
Spectrum NOTES

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the spectrum.
%%%% ¡default!
'Spectrum'

%%% ¡prop!
NAME (constant, string) is the name of the spectrum.
%%%% ¡default!
'spectrum'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the spectrum.
%%%% ¡default!
'Spectrum contains an acquired spectrum including its wavelength and intensity.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the spectrum.
%%%% ¡settings!
'Spectrum'

%%% ¡prop!
ID (data, string) is a few-letter code for the spectrum.
%%%% ¡default!
'Spectrum ID'
%%%% ¡gui!
pr = DistapPP_ID('EL', sp, 'PROP', Spectrum.ID);

%%% ¡prop!
LABEL (metadata, string) is an extended label of the spectrum.
%%%% ¡default!
'Spectrum label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the spectrum.
%%%% ¡default!
'Spectrum notes'

%% ¡props!

%%% ¡prop!
CALIBRATION (data, logical) determines whether it is a calibration spectrum.

%%% ¡prop!
WAVELENGTH (data, cvector) is the vector of the wavelengths at which the spectrum is acquired.

%%% ¡prop!
WAVELENGTH_LABELS (query, stringlist) is the labels for the wavelengths.
%%%% ¡calculate!
value = arrayfun(@(wavelength) [num2str(wavelength) ' cm-1'], sp.get('WAVELENGTH')', 'UniformOutput', false);

%%% ¡prop!
INTENSITIES (data, matrix) is the intensities of the spectra (one spectrum per column).
%%%% ¡gui!
pr = PanelPropMatrix('EL', sp, 'PROP', Spectrum.INTENSITIES, ...
    'ROWNAME', sp.getCallback('WAVELENGTH_LABELS'));

%%% ¡prop!
NO_AQUISITIONS (query, scalar) is the numebr of acquisitions.
%%%% ¡calculate!
value = size(sp.get('INTENSITIES'), 2);

%%% ¡prop!
INTENSITY (query, cvector) is the intesity of the a spectrum.
%%%% ¡calculate!
% INTENSITY = sp.get('INTENSITY', N) returns the intenities of the N-th spectrum.
if isempty(varargin)
    value = [];
    return
end
n = varargin{1};
intensities = sp.get('INTENSITIES');
value = intensities(:, n);

%%% ¡prop!
INTENSITY_MEAN (query, cvector) is the average intesity of the spectra.
%%%% ¡calculate!
value = mean(sp.get('INTENSITIES'), 2);