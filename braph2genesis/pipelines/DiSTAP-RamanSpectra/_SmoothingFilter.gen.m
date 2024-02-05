%% ¡header!
SmoothingFilter < REAnalysisModule (sf, Smoothing Filter) is an REAnalysisModule that reads fixed Raman spectra (with cosmic ray noise removed) and outputs smooth spectra.

%%% ¡description!
A Smoothing Filter Module (SmoothingFilter) is an REAnalysisModule that 
reads the fixed Raman spectra (with cosmic ray noise removed) and evaluates 
the smooth spectra. It also provides basic functionalities to view and 
plot the smooth spectra. 

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum


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


%%% ¡prop!
SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothing Filter.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = sf.get('SP_OUT', SP_IN) returns the smooth N-th spectrum
% in SP_DICT of RE_IN of SmoothingFilter. 
if isempty(varargin)
    value = Spectrum();
    return
end
% Read the input spectrum
sp_in = varargin{1};

% Read the intensities of the raw Raman spectrum
% raw intensities
fixed_intensities = sp_in.get('INTENSITIES');

% Apply Savitzky-Golay smoothing to fixed intensities
% Set the order of the polynomial for Savitzky-Golay smoothing
SGOLAY_POLYORDER = 3;
% Consider odd number of points in the window for Savitzky-Golay smoothing
SGOLAY_WINDOW = 9;
% Apply Savitzky-Golay filter to fixed intensities from
% CosmicRayNoiseRemover
smooth_intensities = sgolayfilt(fixed_intensities, ...
                                SGOLAY_POLYORDER, ... 
                                SGOLAY_WINDOW);  

% Create unlocked copy of the spectrum being processed
% Set the smooth intensities to the INTENSITIES of the spectrum 
sp_out = Spectrum(...
         'INTENSITIES', smooth_intensities, ...
         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
         'ID', sp_in.get('ID'), ...
         'LABEL', sp_in.get('LABEL'), ...
         'NOTES', sp_in.get('NOTES'));

% Set the updated sp_out to SP_OUT
value = sp_out;
