classdef BRAPH2
    %BRAPH2 constants.
    % BRAPH2 is a static class that contains the constants used by BRAPH2.
    %
    % Properties (Constant) - BRAPH2 ID Card:
    %  NAME         - BRAPH2 full name
    %  VERSION      - BRAPH2 version
    %  WEB          - BRAPH2 website
    %  STR          - BRAPH2 sort string
    %  BUILD        - BRAPH2 build number
    %  AUTHORS      - BRAPH2 authors
    %  COPYRIGHT    - BRAPH2 copyright
    %
    % Properties (Constant) - BRAPH2 extensions
    %  EXT_ELEMENT  - BRAPH2 element extension
    %  EXT_PIPELINE - BRAPH2 pipeline extentsion
    %
    % Properties (Constant) - BRAPH2 error codes:
    %  WRONG_INPUT  - wrong input value or format in a function
    %  WRONG_OUTPUT - wrong output value or format in a function
    %  BUG_FUNC     - bug in a function (wrong behavior)
    %  BUG_COPY     - bug while deep-copying an object
    %  BUG_IO       - bug while loading/saving
    %  BUG_ERR      - bug in the handling of errors
    %
    % Properties (Constant) - BRAPH2 GUI constants:
    %  FONTUNITS    - sets the units of the font
    %  FONTSIZE     - sets the size of the font
    
    properties (Constant) % BRAPH2 ID Card
        NAME = 'Braph 2.0' % BRAPH2 full name
        VERSION = '2.0' % BRAPH2 version
        WEB = 'braph.org' % BRAPH2 website
        STR = 'BRAPH2' % BRAPH2 sort string
        BUILD = 1 % BRAPH2 build number
        AUTHORS = 'Giovanni Volpe, Emiliano Gomez Ruiz, Anna Canal Garcia, Yu-Wei Chang, Mite Mijalkov, Joana Braga Pereira, Ehsan Kakaei, Eric Westman, et al.'
        COPYRIGHT = ['Copyright 2014-' datestr(now,'yyyy')]        
    end
    properties (Constant) % BRAPH2 extensions
        EXT_ELEMENT = {'*.b2e', '*.b2e'} % BRAPH2 element extension
        EXT_PIPELINE = {'*.braph2', '*.braph2'} % BRAPH2 pipeline extentsion
        EXT_WORKSPACE = {'*.b2', '*.b2'} % BRAPH2 pipeline workspace extension
    end
    properties (Constant) % BRAPH2 error codes
        WRONG_INPUT = 'WrongInput' % wrong input value or format in a function
        WRONG_OUTPUT = 'WrongOutput' % wrong output value or format in a function
        BUG_FUNC = 'BugFunc' % bug in a function (wrong behavior)
        BUG_COPY = 'BugCopy' % bug while deep-copying an object
        BUG_CLONE = 'BugClone' % bug while cloning an object
        BUG_IO = 'BugIO' % bug while loading/saving files
        BUG_JSON = 'BugJSON' % bug in JSON encoding/deconding
        BUG_ERR = 'BugErr' % bug in the handling of errors
    end
    properties (Constant) % BRAPH2 GUI constants
        FONTUNITS = 'normalized';
        FONTSIZE = 0.5;
    end
end