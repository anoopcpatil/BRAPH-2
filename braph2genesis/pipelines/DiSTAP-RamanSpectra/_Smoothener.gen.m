%% ¡header!
Smoothener < REAnalysisModule (sf, Smoothener) is an REAnalysisModule that reads fixed Raman spectra (with cosmic ray noise removed) and outputs smooth spectra.

%%% ¡description!
A Smoothener Module (Smoothener) is an REAnalysisModule that 
reads the fixed Raman spectra (with cosmic ray noise removed) and evaluates 
the smooth spectra. It also provides basic functionalities to view and 
plot the smooth spectra. 

%%% ¡seealso!
REAnalysisModule, RamanExperiment, Spectrum


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Smoothener.
%%%% ¡default!
'Smoothener'

%%% ¡prop!
NAME (constant, string) is the name of the Smoothener.
%%%% ¡default!
'Smoothener'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Smoothener.
%%%% ¡default!
'Smoothener reads and analyzes fixed Raman spectra and evaluates and plots the resulting smooth spectra.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Smoothener.
%%%% ¡settings!
'Smoothener'

%%% ¡prop!
ID (data, string) is a few-letter code for the Smoothener.
%%%% ¡default!
'Smoothener ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Smoothener.
%%%% ¡default!
'Smoothener label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Smoothener.
%%%% ¡default!
'Smoothener notes'

%%% ¡prop!
SP_OUT (result, item) is the smooth spectrum for SP_DICT_OUT and RE_OUT of Smoothener.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = sf.get('SP_OUT', SP_IN) returns the smooth N-th spectrum
% in SP_DICT of RE_IN of Smoothener. 
if isempty(varargin)
    value = Spectrum();
    return
end
% Read the input spectrum
sp_in = varargin{1};

% Read the intensities of the raw Raman spectrum
% raw intensities
fixed_intensities = sp_in.get('INTENSITIES');

% % Apply Savitzky-Golay smoothing to fixed intensities
% % Set the order of the polynomial for Savitzky-Golay smoothing
% SGOLAY_POLYORDER = 3;
% % Consider odd number of points in the window for Savitzky-Golay smoothing
% SGOLAY_WINDOW = 9;
% Apply Savitzky-Golay filter to fixed intensities from
% CosmicRayNoiseRemover
smooth_intensities = sgolayfilt(fixed_intensities, ...
                                sf.get('SGOLAY_POLYORDER'), ... 
                                sf.get('SGOLAY_WINDOW'));  

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


%% ¡props!

%Parameters for Savitzky-Golay smoothing: 
% SGOLAY_POLYORDER & SGOLAY_WINDOW
%%% ¡prop!
SGOLAY_POLYORDER (parameter, scalar) is the order of the polynomial for Savitzky-Golay smoothing.
%%%% ¡default!
3

%%% ¡prop!
SGOLAY_WINDOW (parameter, scalar) is odd number of points in the window for Savitzky-Golay smoothing.
%%%% ¡default!
9


%% ¡tests!

%%% ¡excluded_props!
[Smoothener.TEMPLATE Smoothener.REPF]


%% ¡layout!

%%% ¡prop!
%%%% ¡id!
Smoothener.ID
%%%% ¡title!
ID

%%% ¡prop!
%%%% ¡id!
Smoothener.DESCRIPTION
%%%% ¡title!
DESCRIPTION

%%% ¡prop!
%%%% ¡id!
Smoothener.SGOLAY_POLYORDER
%%%% ¡title!
SGOLAY_POLYORDER

%%% ¡prop!
%%%% ¡id!
Smoothener.SGOLAY_WINDOW
%%%% ¡title!
SGOLAY_WINDOW

%%% ¡prop!
%%%% ¡id!
Smoothener.RE_IN
%%%% ¡title!
RE_IN

%%% ¡prop!
%%%% ¡id!
Smoothener.RE_OUT
%%%% ¡title!
RE_OUT

%%% ¡prop!
%%%% ¡id!
Smoothener.REPF
%%%% ¡title!
Plot Smoothened Spectra