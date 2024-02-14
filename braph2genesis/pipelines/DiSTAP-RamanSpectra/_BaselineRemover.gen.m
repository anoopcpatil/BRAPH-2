%% ¡header!
BaselineRemover < REAnalysisModule (br, Baseline Remover) is an REAnalysisModule that reads smooth Raman spectra and outputs baseline-removed Raman and Raman baselines.

%%% ¡description!
A Baseline Remover (BaselineRemover) is an REAnalysisModule
that reads the smooth Raman spectra (from Smoothener) and evaluates 
the baseline-removed Raman spectra (smooth spectra with baselines removed)
and the baselines. It also provides basic functionalities to view and plot 
the baseline-removed spectra and the baselines. 

%%% ¡seealso!
REAnalysisModule, BaselineEstimator, RamanExperiment, Spectrum


%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the Baseline Remover.
%%%% ¡default!
'BaselineRemover'

%%% ¡prop!
NAME (constant, string) is the name of the Baseline Remover.
%%%% ¡default!
'BaselineRemover'

%%% ¡prop!   
DESCRIPTION (constant, string) is the description of Baseline Remover.
%%%% ¡default!
'BaselineRemover reads and analyzes smooth Raman spectra and evaluates and plots the baselined Raman spectra.'
%%%% ¡gui!
pr = PanelPropStringTextArea('EL', br, 'PROP', br.DESCRIPTION, varargin{:});

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the Baseline Remover.
%%%% ¡settings!
'BaselineRemover'

%%% ¡prop!
ID (data, string) is a few-letter code for the Baseline Remover.
%%%% ¡default!
'BaselineRemover ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the Baseline Remover.
%%%% ¡default!
'BaselineRemover label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about Baseline Remover.
%%%% ¡default!
'BaselineRemover notes'


%%% ¡prop!
SP_OUT (result, item) is the baseline for SP_DICT_OUT and RE_OUT of Baseline Remover.
%%%% ¡settings!
'Spectrum'
%%%% ¡calculate!
% sp_out = br.get('SP_OUT', SP_IN) returns the baselined intensities of 
% the N-th spectrum in SP_DICT of RE_IN of BaselineRemover. 
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
% % Set the order of the polynomial for Lieberfit function
% LFIT_POLYORDER = 5;
% % Set the number of odd points in the window for Lieberfit function
% LFIT_ITER = 100;
% Apply Lieberfit function to smooth intensities from
% Smoothener
[baselines, baselined_intensities] = lieberfit(smooth_intensities', ...
                                               br.get('LFIT_POLYORDER'), ...
                                               br.get('LFIT_ITER')); 

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


%%% ¡prop!
REPF (gui, item) is a container of the panel figure for the BaselineRemover.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', br, 'PROP', BaselineRemover.REPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot Baseline-removed spectra', ...
    varargin{:});


%% ¡props!

%%% ¡prop!
RE_BASELINES (result, item) is the output Raman Experiment with Raman baselines as a result.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
% Call BaselineEstimator to evaluate baselines
be = BaselineEstimator('RE_IN', br.get('RE_IN'));

% Read RE_OUT of BaselineEstimator
re_out = be.get('RE_OUT')

% Set the re_out to RE_BASELINES
value = re_out;

% Set re_out to RE and memorize baselines for GUI output of BaselineRemover
br.memorize('BAPF').set('RE', re_out)


%%% ¡prop!
BAPF (gui, item) is a container of the panel figure for BaselineEstimator.
%%%% ¡settings!
'RamanExperimentPF'
%%%% ¡gui!
pr = PanelPropItem('EL', br, 'PROP', BaselineRemover.BAPF, ...
    'WAITBAR', true, ...
    'GUICLASS', 'GUIFig', ...
    'BUTTON_TEXT', 'Plot estimated baselines', ...
    varargin{:});


%Parameters for Lieberfit function for baseine estimation:
%LFIT_POLYORDER & LFIT_ITER
%%% ¡prop!
LFIT_POLYORDER (parameter, scalar) is the order of the polynomial for Lieberfit function.
%%%% ¡default!
5


%%% ¡prop!
LFIT_ITER (parameter, scalar) is the number of iterations for Lieberfit function.
%%%% ¡default!
100


%% ¡tests!

%%% ¡excluded_props!
[BaselineRemover.TEMPLATE BaselineRemover.REPF BaselineRemover.BAPF]


%% ¡layout!

%%% ¡prop!
%%%% ¡id!
BaselineRemover.DESCRIPTION
%%%% ¡title!
MODULE INFO

%%% ¡prop!
%%%% ¡id!
BaselineRemover.LFIT_POLYORDER
%%%% ¡title!
Order of Polynomial Fit

%%% ¡prop!
%%%% ¡id!
BaselineRemover.LFIT_ITER
%%%% ¡title!
Number of Iterations to Fit Baseline

%%% ¡prop!
%%%% ¡id!
BaselineRemover.RE_IN
%%%% ¡title!
Input Raman Spectra

%%% ¡prop!
%%%% ¡id!
BaselineRemover.RE_BASELINES
%%%% ¡title!
Baselines

%%% ¡prop!
%%%% ¡id!
BaselineRemover.BAPF
%%%% ¡title!
PLOT

%%% ¡prop!
%%%% ¡id!
BaselineRemover.RE_OUT
%%%% ¡title!
Output Raman Spectra

%%% ¡prop!
%%%% ¡id!
BaselineRemover.REPF
%%%% ¡title!
PLOT

%%% ¡prop!
%%%% ¡id!
BaselineRemover.NOTES
%%%% ¡title!
NOTES
