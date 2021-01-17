classdef Constant
    properties (Constant)
        % version number
        BUILD = 2020
        VERSION = '2.0.0'
        DATE = ''
        AUTHORS = ''
        COPYRIGHT = ['Copyright 2014-' datestr(now,'yyyy')]

        % Braph
        BN_NAME = 'Braph 2.0'
        COLOR = [.9 .4 .1]
        FONT = 'Helvetica'

        % Variable type codes
        STRING = 1
        NUMERIC = 2
        LOGICAL = 3
        
        % file formats and dialogs
        MSG_GETDIR = 'Select directory'
        MSG_PUTDIR = 'Select directory'
        
        MAT_EXTENSION = '*.mat';
        MAT_MSG_GETFILE = 'Select MAT file';
        MAT_MSG_PUTFILE = 'Select MAT file';
        
        XLS_EXTENSION = {'*.xlsx';'*.xls'};
        XLS_MSG_GETFILE = 'Select Excel file';
        XLS_MSG_PUTFILE = 'Select Excel file';       

        TXT_EXTENSION = '*.txt';
        TXT_MSG_GETFILE = 'Select TXT file';
        TXT_MSG_PUTFILE = 'Select TXT file';
        
        JSON_EXTENSION = '*.json'
        JSON_MSG_GETFILE = 'Select JSON file'
        JSON_MSG_PUTFILE = 'Select JSON file'        
    end
end