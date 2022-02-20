%% ¡header!
NNRegressorData_FUN_WU < NNRegressorData (nnd, data of a neural network regressor with functional data) produces a dataset to train or test a neural netowrk regressor using functional data. 

%% ¡description!
This dataset can be used to train or test a neural network regressor. The
INPUTS and TARGETS are the two cells for trianing a neurla network. The INPUTS 
cell is obtained direcly from DTI connectivity matrices, and is represented as 
floating point feature cell. Feature selection procedure can be implemented 
when constructing the INPUTS. The TARGETS cell holds the target values for 
the trianing samples. 

%% ¡props!
%%% ¡prop!
REPETITION(parameter, scalar) is the number of repetitions
%%%% ¡default!
1

%%% ¡prop!
FREQUENCYRULEMIN(parameter, scalar)is the minimum frequency value
%%%% ¡default!
0
%%% ¡prop!
FREQUENCYRULEMAX(parameter, scalar)is the maximum frequency value
%%%% ¡default!
Inf

%%% ¡prop!
CORRELATION_RULE (parameter, option) is the correlation type.
%%%% ¡settings!
Correlation.CORRELATION_RULE_LIST
%%%% ¡default!
Correlation.CORRELATION_RULE_LIST{1}

%%% ¡prop!
NEGATIVE_WEIGHT_RULE (parameter, option) determines how to deal with negative weights.
%%%% ¡settings!
Correlation.NEGATIVE_WEIGHT_RULE_LIST
%%%% ¡default!
Correlation.NEGATIVE_WEIGHT_RULE_LIST{1}

%% ¡props_update!
%%% ¡prop!
TRAIN_G_DICT (result, idict) is the graph (GraphWU) from subjects in training set.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = nnd.get('TRAIN_GR');
T = nnd.get('REPETITION');
fmin = nnd.get('FREQUENCYRULEMIN');
fmax = nnd.get('FREQUENCYRULEMAX');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    data = sub.getr('FUN');
    fs = 1 / T;
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end
    
    A = Correlation.getAdjacencyMatrix(data, nnd.get('CORRELATION_RULE'), nnd.get('NEGATIVE_WEIGHT_RULE'));
    
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'BRAINATLAS', atlas ...
        );
    g_dict.add(g)
end

value = g_dict;

%%% ¡prop!
VAL_G_DICT (result, idict) is the graph (GraphWU) from subjects in validation set.
%%%% ¡settings!
'GraphWU'
%%%% ¡default!
IndexedDictionary('IT_CLASS', 'GraphWU')
%%%% ¡calculate!
g_dict = IndexedDictionary('IT_CLASS', 'GraphWU');
gr = nnd.get('VAL_GR');
T = nnd.get('REPETITION');
fmin = nnd.get('FREQUENCYRULEMIN');
fmax = nnd.get('FREQUENCYRULEMAX');
atlas = BrainAtlas();
if ~isempty(gr) && ~isa(gr, 'NoValue') && gr.get('SUB_DICT').length > 0
    atlas = gr.get('SUB_DICT').getItem(1).get('BA');
end
for i = 1:1:gr.get('SUB_DICT').length()
	sub = gr.get('SUB_DICT').getItem(i);
    data = sub.getr('FUN');
    fs = 1 / T;
    
    if fmax > fmin && T > 0
        NFFT = 2 * ceil(size(data, 1) / 2);
        ft = fft(data, NFFT);  % Fourier transform
        f = fftshift(fs * abs(-NFFT / 2:NFFT / 2 - 1) / NFFT);  % absolute frequency
        ft(f < fmin | f > fmax, :) = 0;
        data = ifft(ft, NFFT);
    end
    
    A = Correlation.getAdjacencyMatrix(data, nnd.get('CORRELATION_RULE'), nnd.get('NEGATIVE_WEIGHT_RULE'));
    
    g = GraphWU( ...
        'ID', ['g ' sub.get('ID')], ...
        'B', A, ...
        'BRAINATLAS', atlas ...
        );
    g_dict.add(g)
end

value = g_dict;

%%% ¡prop!
GR (data, item) is the subject group, which also defines the subject class SubjectFUN.
%%%% ¡default!
Group('SUB_CLASS', 'SubjectFUN')

%% ¡tests!
%%% ¡test!
%%%% ¡name!
Example
%%%% ¡code!
example_NN_FUN_WU_Regression_AdjacencyMatrix