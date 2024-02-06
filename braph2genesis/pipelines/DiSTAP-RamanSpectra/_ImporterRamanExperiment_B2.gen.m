%% ¡header!
ImporterRamanExperiment_B2 < Importer (im, importer of Raman experiment from B2) imports a Raman experiment from a .b2 file.

%%% ¡description!
Raman experiment importer from B2 file (ImporterRamanExperiment_B2) imports a set of Raman spectra acquired in a Raman Experiment stored in a B2 file.

%%% ¡seealso!
RamanExperiment, Spectrum

%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2'

%%% ¡prop!
NAME (constant, string) is the name of the importer of Raman experiment from B2.
%%%% ¡default!
'Importer of Raman experiment from B2'

%%% ¡prop!
DESCRIPTION (constant, string) is the description of the importer of Raman experiment from B2.
%%%% ¡default!
'Raman experiment importer from B2 file (ImporterRamanExperiment_B2) imports a set of Raman spectra acquired in a Raman Experiment stored in a B2 file.'

%%% ¡prop!
TEMPLATE (parameter, item) is the template of the importer of Raman experiment from B2.
%%%% ¡settings!
'ImporterRamanExperiment_B2'

%%% ¡prop!
ID (data, string) is a few-letter code for the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2 ID'

%%% ¡prop!
LABEL (metadata, string) is an extended label of the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2 label'

%%% ¡prop!
NOTES (metadata, string) are some specific notes about the importer of Raman experiment from B2.
%%%% ¡default!
'ImporterRamanExperiment_B2 notes'

%% ¡props!

%%% ¡prop!
DIRECTORY (data, string) is the directory containing the B2 file from which the entire Raman experiment is read.
%%%% ¡default!
fileparts(which('test_braph2'))

%%% ¡prop!
GET_DIR (query, item) opens a dialog box to set the directory from where the B2 file can be loaded. 
%%%% ¡settings!
'ImporterRamanExperiment_B2'
%%%% ¡calculate!
directory = uigetdir('Select directory');
if ischar(directory) && isfolder(directory)
	im.set('DIRECTORY', directory);
end
value = im;

%%% ¡prop!
RE (result, item) is a Raman experiment.
%%%% ¡settings!
'RamanExperiment'
%%%% ¡calculate!
re = RamanExperiment();

file_path = im.get('FILE_PATH');
if exist(file_path, 'file')
    % Load data from the .b2 file
    try
        b2_data = load(file_path, '-mat');
        
        % Extract relevant information from the loaded structure (modify as needed)
        %wavelengths = Read wavelengths;
        %intensities = Read intensities;

        % Populate RamanExperiment with data
        sp = Spectrum( ...
            'ID', 'Spectrum1', ...
            'LABEL', 'Spectrum1', ...
            'WAVELENGTH', wavelengths, ...
            'INTENSITIES', intensities, ...
            'NOTES', ['Spectrum loaded from ' file_path] ...
        );

        re.set( ...
            'ID', 'RamanExperiment1', ...
            'LABEL', 'RamanExperiment1', ...
            'NOTES', ['Spectra loaded from ' file_path] ...
        );
        re.memorize('SP_DICT').get('ADD', sp);
        
    catch e
        error('Error loading .b2 file: %s', e.message);
    end
else
    error('File not found: %s', file_path);
end

value = re;

%% ¡tests!

%%% ¡excluded_props!
[ImporterRamanExperiment_B2.FILE_PATH]

%%% ¡test!
%%%% ¡name!
GUI
%%%% ¡probability!
.01
%%%% ¡parallel!
false
%%%% ¡code!
im_re = ImporterRamanExperiment_B2( ...
    'FILE_PATH', [fileparts(which('RamanExperiment')) filesep 'example.b2'], ...
    'WAITBAR', true ...
);
re = im_re.get('RE');

gui = GUIElement('PE', re, 'CLOSEREQ', false);
gui.get('DRAW')
gui.get('SHOW')

gui.get('CLOSE')
