%BRAPH2DISTAP_GENESIS
% This script generates and tests BRAPH2 for DiSTAP

delete(findall(0, 'type', 'figure'))
close all
clear all %#ok<CLALL>
clc

%% Add here all included and excluded folders and elements
rollcall = { ...
    '+util*', ...
    '+ds*', '-ds_examples', ...
    '-atlas', ...
    '-gt', ...
    '-cohort', ...
    '-analysis', ...
    '-nn', ...
    '+gui*', '-gui_examples', ...
	'-brainsurfs', ...
    '-atlases', ...
    '-graphs', ...
    '-measures', ...
    '-neuralnetworks', ...
    '+pipelines', '+DiSTAP-RamanSpectra*', ...
    '+test*', ...
    '-sandbox' ...
	};

%% Genesis for DiSTAP
if ispc
    fprintf([ ...
        '\n' ...
        '<strong>@@@@   @@@@    @@@   @@@@   @   @     ####   ####     ØØØØØ ØØØØ Ø   Ø ØØØØ  ØØØØ  Ø   ØØØØ\n</strong>' ...
        '<strong>@   @  @   @  @   @  @   @  @   @        #   #  #     Ø     Ø    ØØ  Ø Ø    Ø      Ø  Ø    \n</strong>' ...
        '<strong>@@@@   @@@@   @@@@@  @@@@   @@@@@     ####   #  #     Ø  ØØ ØØØ  Ø Ø Ø ØØØ   ØØØ   Ø   ØØØ \n</strong>' ...
        '<strong>@   @  @  @   @   @  @      @   @     #      #  #     Ø   Ø Ø    Ø  ØØ Ø        Ø  Ø      Ø\n</strong>' ...
        '<strong>@@@@   @   @  @   @  @      @   @     #### # ####     ØØØØØ ØØØØ Ø   Ø ØØØØ ØØØØ   Ø  ØØØØ \n</strong>' ...
        '\n' ...
        '                                                       f o r   D i S T A P\n' ...
        '\n' ...
        ]);
else
    fprintf([ ...
        '\n' ...
        ' ████   ████    ███   ████   █   █     ▓▓▓▓   ▓▓▓▓     ▒▒▒▒▒ ▒▒▒▒ ▒   ▒ ▒▒▒▒  ▒▒▒▒  ▒   ▒▒▒▒\n' ...
        ' █   █  █   █  █   █  █   █  █   █        ▓   ▓  ▓     ▒     ▒    ▒▒  ▒ ▒    ▒      ▒  ▒    \n' ...
        ' ████   ████   █████  ████   █████     ▓▓▓▓   ▓  ▓     ▒  ▒▒ ▒▒▒  ▒ ▒ ▒ ▒▒▒   ▒▒▒   ▒   ▒▒▒ \n' ...
        ' █   █  █  █   █   █  █      █   █     ▓      ▓  ▓     ▒   ▒ ▒    ▒  ▒▒ ▒        ▒  ▒      ▒\n' ...
        ' ████   █   █  █   █  █      █   █     ▓▓▓▓ ▓ ▓▓▓▓     ▒▒▒▒▒ ▒▒▒▒ ▒   ▒ ▒▒▒▒ ▒▒▒▒   ▒  ▒▒▒▒ \n' ...
        '\n' ...
        '                                                       f o r   D i S T A P\n' ...
        '\n' ...
        ]);
end

addpath(['.' filesep() '..' filesep() '..'])
addpath(['.' filesep() '..' filesep() '..' filesep() 'genesis'])

addpath(fileparts(which('braph2genesis')))
addpath([fileparts(which('braph2genesis')) filesep 'genesis'])

target_dir = [fileparts(fileparts(which('braph2genesis'))) filesep 'braph2distap'];
if exist(target_dir, 'dir') 
    if input([ ...
        'The target directory already exists:\n' ...
        target_dir '\n'...
        'It will be erased with all its content.\n' ...
        'Proceed anyways? (y/n)\n'
        ], 's') == 'y'
    
        backup_warning_state = warning('off', 'MATLAB:RMDIR:RemovedFromPath');
        rmdir(target_dir, 's')
        warning(backup_warning_state)
    else
        disp('Compilation interrupted.')
    end
end
if ~exist(target_dir, 'dir') 
    time_start = tic;

    [target_dir, source_dir] = genesis(target_dir, [], 2, rollcall);

    % move braph2distap to main folder
    movefile([target_dir filesep() 'pipelines' filesep() 'DiSTAP-RamanSpectra' filesep() 'braph2distap.m'], target_dir)

    % move test_braph2distap to test folder
    movefile([target_dir filesep() 'pipelines' filesep() 'DiSTAP-RamanSpectra' filesep() 'test_braph2distap.m'], [target_dir filesep() 'test'])

    % erase braph2distap from compiled software
    delete([target_dir filesep() 'pipelines' filesep() 'DiSTAP-RamanSpectra' filesep() 'braph2distap_genesis.m'])

    addpath(target_dir)

    time_end = toc(time_start);

    disp( 'BRAPH 2 is now fully compiled and ready to be used.')
    disp(['Its compilation has taken ' int2str(time_end) '.' int2str(mod(time_end, 1) * 10) 's'])
    disp('')
    
    braph2(false)

    test_braph2distap
end