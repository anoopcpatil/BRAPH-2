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
SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baselined Raman Generator.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = brgen.get('SP_OUT', SP_IN) returns the baselined intensities of 
% the N-th spectrum in SP_DICT of RE_IN of BaselinedRamanGenerator. 
if isempty(varargin)
    value = Spectrum();
    return
end
% Read the input spectrum
sp_in = varargin{1};

% Read the intensities of the smooth Raman spectrum
% smooth intensities
smooth_intensities = sp_in.get('INTENSITIES');

% Baselined intensities using Lieberfit function
% Set the order of the polynomial for Lieberfit function
LFIT_POLYORDER = 5;
% Set the number of odd points in the window for Lieberfit function
LFIT_ITER = 100;
% Apply Lieberfit function to smooth intensities from
% SmoothingFilter
[baselines, baselined_intensities] = lieberfit(smooth_intensities', ...
                                               LFIT_POLYORDER, ...
                                               LFIT_ITER); 

% Create unlocked copy of the spectrum being processed
% Set the baselined intensities to the INTENSITIES of the spectrum 
sp_out = Spectrum(...
         'INTENSITIES', baselined_intensities, ...
         'WAVELENGTH', sp_in.get('WAVELENGTH'), ...
         'ID', sp_in.get('ID'), ...
         'LABEL', sp_in.get('LABEL'), ...
         'NOTES', sp_in.get('NOTES'));

% Set the updated sp_out to SP_OUT
value = sp_out;
