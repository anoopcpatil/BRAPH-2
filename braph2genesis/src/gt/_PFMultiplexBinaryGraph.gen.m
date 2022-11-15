%% ¡header!
PFMultiplexBinaryGraph < PFMultiGraph (pf, panel figure multiplex) is a plot of a multiplex.

%%% ¡description!
% % % PFMultiplexGraph manages the plot of the multiplex layer graph. 
% % % This class provides the common methods needed to manage the plot of 
% % % the graph. 

%%% ¡seealso!
PanelFig, Graph, MultiplexBUD, MultiplexBUT

%% ¡properties!
p  % handle for panel
h_axes % handle for the axes

h_plot

%% ¡props!

%%% ¡prop!
LAYER (figure, string) is the id of the selected layer.
%%%% ¡default!
'1'
%%%% ¡gui!
g = pf.get('G');
pr = PP_LayerID('EL', pf, 'PROP', PFMultiplexBinaryGraph.LAYER, ...
    'G', g, ...
    varargin{:});

%% ¡methods!
function p_out = draw(pf, varargin)

    pf.p = draw@PFMultiGraph(pf, varargin{:});
    % axes
    pf.h_axes = pf.get('ST_AXIS').h();

    % output
    if nargout > 0
        p_out = pf.p;
    end
end
function h = plotAdjacency(pf)
    
    g = str2double(pf.get('G'));
    if isnan(g)
        g = pf.get('G');
    end
    [l, ls] = g.layernumber();
    total_l = ls(1); % total multi-layers
    % choosen values
    l = str2double(pf.get('LAYER'));
    d = str2double(pf.get('DT'));
    % get correct index matrix
    index = total_l * (d - 1) + l;
    multiplex = g.get('A'); 
    correct_graph = multiplex{index, index};
    
    % plot
    if pf.get('ST_ADJACENCY').get('BINARY')
        h = pf.plotb(correct_graph);
    elseif pf.get('ST_ADJACENCY').get('HIST')
        h = pf.hist(correct_graph);
    else
        h = pf.plotw(correct_graph);
    end
end