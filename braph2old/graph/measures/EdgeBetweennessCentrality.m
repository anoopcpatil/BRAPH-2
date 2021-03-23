classdef EdgeBetweennessCentrality < Measure
    % EdgeBetweennessCentrality Edge betweenness centrality measure
    % EdgeBetweennessCentrality provides the edge betweenness centrality of a graph for 
    % binary undirected (BU),  binary directed (BD), weighted undirected (WU) 
    % and weighted directed (WD) graphs. 
    %
    % It is calculated as the fraction of all shortest paths in the graph
    % that pass through a given node within a layer. Edges with high values of betweenness
    % centrality participate in a large number of shortest paths. 
    % 
    % EdgeBetweennessCentrality methods:
    %   EdgeBetweennessCentrality   - constructor
    %
    % EdgeBetweennessCentrality methods (Static)
    %   getClass                    - returns the edge betweenness centrality class
    %   getName                     - returns the name of edge betweenness centrality measure
    %   getDescription              - returns the description of edge betweenness centrality measure
    %   getAvailableSettings        - returns the settings available to the class
    %   getMeasureFormat            - returns the measure format
    %   getMeasureScope             - returns the measure scope
    %   getParametricity            - returns the parametricity of the measure
    %   getMeasure                  - returns the edge betweenness centrality class
    %   getCompatibleGraphList      - returns a list of compatible graphs
    %   getCompatibleGraphNumber    - returns the number of compatible graphs
    %
    % See also Measure, GraphBD, GraphBU, GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU. 
    methods
        function m = EdgeBetweennessCentrality(g, varargin)          
            % EDGEBETWEENNESSCENTRALITY(G) creates edge betweenness centrality with default measure properties.
            % G is a graph (e.g, an instance of GraphBD, GraphBU,
            % GraphWD, GraphWU, MultiplexGraphBU, MultiplexGraphBD,
            % MultiplexGraphWU or MultiplexGraphWD). 
            %   
            % See also Measure, Graph, GraphBD, GraphBU, GraphWD, GraphWU, MultiplexGraphBD, MultiplexGraphBU, MultiplexGraphWD, MultiplexGraphWU.
            
            m = m@Measure(g, varargin{:});
        end
    end
    methods (Access=protected)
        function edge_betweenness_centrality = calculate(m)
            % CALCULATE calculates the edge betweenness centrality value of a
            % graph.
            %
            % EDGEBETWEENNESSCENTRALITY = CALCULATE(M) returns the value of the edge betweenness centrality 
            % of a graph.
            
            g = m.getGraph();  % graph from measure class
            A = g.getA();  % adjency matrix of the graph
            N = g.nodenumber(); 
            
            edge_betweenness_centrality = cell(g.layernumber(), 1);
            connectivity_type =  g.getConnectivityType(g.layernumber());
            for li = 1:1:g.layernumber()
                if g.is_graph(g)
                    Aii = A;
                    connectivity_layer = connectivity_type;
                else
                    Aii = A{li, li};
                    connectivity_layer = connectivity_type(li, li);
                end
                
                if connectivity_layer == Graph.WEIGHTED  % weighted graphs
                    edge_betweenness_centrality_layer = m.getWeightedCalculation(Aii);
                else  % binary graphs
                    edge_betweenness_centrality_layer = m.getBinaryCalculation(Aii);
                end
                edge_betweenness_centrality(li) = {edge_betweenness_centrality_layer};
            end   
        end
        function binary_edge_betweenness_centrality = getBinaryCalculation(m, A)      
            % GETBINARYCALCULATION calculates the edge betweenness centrality value of a binary adjacency matrix
            %
            % BINARY_EDGE_BETWEENNESS_CENTRALITY = GETBINARYCALCULATION(m, A) returns the value
            % of the edge betweenness centrality of a binary adjacency matrix A.

            n = length(A);
            BC = zeros(n,1);  % vertex betweenness
            EBC = zeros(n);  % edge betweenness
            for u=1:n
                D = false(1, n); D(u) = 1;  % distance from u
                NP = zeros(1, n); NP(u) = 1;  % number of paths from u
                P = false(n);  % predecessors
                Q = zeros(1, n); q = n;  % order of non-increasing distance
                Gu = A;
                V = u;
                while V
                    Gu(:, V) = 0;  % remove remaining in-edges
                    for v = V
                        Q(q) = v; q = q-1;
                        W = find(Gu(v, :));  % neighbours of v
                        for w = W
                            if D(w)
                                NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
                                P(w, v) = 1;  % v is a predecessor
                            else
                                D(w) = 1;
                                NP(w) = NP(v);  % NP(u->w) = NP of new path
                                P(w, v) = 1;  % v is a predecessor
                            end
                        end
                    end
                    V = find(any(Gu(V, :), 1));
                end
                if ~all(D)  % if some vertices unreachable,
                    Q(1:q) = find(~D);  % ...these are first-in-line
                end
                DP = zeros(n, 1);  % dependency
                for w=Q(1:n-1)
                    BC(w) = BC(w) + DP(w);
                    for v = find(P(w, :))
                        DPvw = (1+DP(w)).*NP(v)./NP(w);
                        DP(v) = DP(v) + DPvw;
                        EBC(v, w) = EBC(v, w) + DPvw;
                    end
                end
            end
            binary_edge_betweenness_centrality = EBC;
            binary_edge_betweenness_centrality(isnan(binary_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
        end
        function weighted_edge_betweenness_centrality = getWeightedCalculation(m, A)
            % GETWEIGHTEDCALCULATION calculates the edge betweenness centrality value of a weighted adjacency matrix
            %
            % WEIGHTED_EDGE_BETWEENNESS_CENTRALITY  = GETWEIGHTEDCALCULATION(m, A)
            % returns the value of the edge betweenness centrality of a weighted 
            % adjacency matrix A.
            
            n = length(A);   
            BC = zeros(n,1);  % vertex betweenness
            EBC = zeros(n);  % edge betweenness 
            for u=1:n
                D = inf(1, n); D(u) = 0;  % distance from u
                NP = zeros(1, n); NP(u) = 1;  % number of paths from u
                S = true(1, n);  % distance permanence (true is temporary)
                P = false(n);  % predecessors
                Q = zeros(1, n); q = n;  % order of non-increasing distance
                G1 = A;
                V = u;
                while 1
                    S(V) = 0;  % distance u->V is now permanent
                    G1(:, V) = 0;  % no in-edges as already shortest
                    for v = V
                        Q(q) = v; q = q-1;
                        W = find(G1(v, :));  % neighbours of v
                        for w = W
                            Duw = D(v) + G1(v, w);  % path length to be tested
                            if Duw < D(w)  % if new u->w shorter than old
                                D(w) = Duw;
                                NP(w) = NP(v);  % NP(u->w) = NP of new path
                                P(w,: ) = 0;
                                P(w, v) = 1;  % v is the only predecessor
                            elseif Duw == D(w)  % if new u->w equal to old
                                NP(w) = NP(w) + NP(v);  % NP(u->w) sum of old and new
                                P(w, v) = 1;  % v is also a predecessor
                            end
                        end
                    end
                    minD = min(D(S));
                    if isempty(minD), break  % all nodes reached, or
                    elseif isinf(minD)  % ...some cannot be reached:
                        Q(1:q) = find(isinf(D)); break	 % ...these are first-in-line
                    end
                    V = find(D == minD);
                end
                DP=zeros(n, 1);  % dependency
                for w = Q(1:n-1)
                    BC(w) = BC(w) + DP(w);
                    for v = find(P(w,:))
                        DPvw = (1+DP(w)).*NP(v)./NP(w);
                        DP(v) = DP(v) + DPvw;
                        EBC(v, w) = EBC(v, w) + DPvw;
                    end
                end
            end
            weighted_edge_betweenness_centrality = EBC;
            weighted_edge_betweenness_centrality(isnan(weighted_edge_betweenness_centrality)) = 0;  % Should return zeros, not NaN
        end
    end
    methods (Static)
        function measure_class = getClass()
            % GETCLASS returns the measure class 
            %            
            % MEASURE_CLASS = GETCLASS() returns the class of the edge betweenness centrality measure.
            %
            % See also getName(), getDescription(). 
            
            measure_class = 'EdgeBetweennessCentrality';
        end
        function name = getName()
            % GETNAME returns the measure name
            %
            % NAME = GETNAME() returns the name of the edge betweenness centrality measure.
            %
            % See also getClass(), getDescription(). 
            
            name = 'Edge Betweenness Centrality';
        end
        function description = getDescription()
            % GETDESCRIPTION returns the edge betweenness centrality description 
            %
            % DESCRIPTION = GETDESCRIPTION() returns the description of the
            % edge betweenness centrality measure.
            %
            % See also getList(), getCompatibleGraphList().
            
            description = [ ...
                'The edge betweenness centrality of a graph is ' ...
                'the fraction of all shortest paths in the ' ...
                'graph that pass through a given edge within a layer. ' ...
                'Edges with high values of betweenness centrality ' ...
                'participate in a large number of shortest paths. ' ...
                ];
        end
        function available_settings = getAvailableSettings()
            % GETAVAILABLESETTINGS returns the setting available to EdgeBetweennessCentrality
            %
            % AVAILABLESETTINGS = GETAVAILABLESETTINGS() returns the
            % settings available to EdgeBetweennessCentrality. Empty Array in this case.
            % 
            % See also getCompatibleGraphList()
            
            available_settings = {};
        end
        function measure_format = getMeasureFormat()
            % GETMEASUREFORMAT returns the measure format of EdgeBetweennessCentrality
            %
            % MEASURE_FORMAT = GETMEASUREFORMAT() returns the measure format
            % of edge betweenness centrality measure (BINODAL).
            %
            % See also getMeasureScope.
            
            measure_format = Measure.BINODAL;
        end
        function measure_scope = getMeasureScope()
            % GETMEASURESCOPE returns the measure scope of EdgeBetweennessCentrality
            %
            % MEASURE_SCOPE = GETMEASURESCOPE() returns the
            % measure scope of edge betweenness centrality measure (UNILAYER).
            %
            % See also getMeasureFormat.
            
            measure_scope = Measure.UNILAYER;
        end
        function parametricity = getParametricity()
            % GETPARAMETRICITY returns the parametricity of EdgeBetweennessCentrality
            %
            % PARAMETRICITY = GETPARAMETRICITY() returns the
            % parametricity of edge betweenness centrality measure (NONPARAMETRIC).
            %
            % See also getMeasureFormat, getMeasureScope.
            
            parametricity = Measure.NONPARAMETRIC;
        end
        function list = getCompatibleGraphList()
            % GETCOMPATIBLEGRAPHLIST returns the list of compatible graphs
            % with EdgeBetweennessCentrality 
            %
            % LIST = GETCOMPATIBLEGRAPHLIST() returns a cell array 
            % of compatible graph classes to edge betweenness centrality. 
            % The measure will not work if the graph is not compatible. 
            %
            % See also getCompatibleGraphNumber(). 
            
            list = { ...
                'GraphBD', ...
                'GraphBU', ...
                'GraphWD', ...
                'GraphWU' ...
                'MultiplexGraphBD', ...
                'MultiplexGraphBU', ...
                'MultiplexGraphWD', ...
                'MultiplexGraphWU' ...
                };
        end
        function n = getCompatibleGraphNumber()
            % GETCOMPATIBLEGRAPHNUMBER returns the number of compatible
            % graphs with EdgeBetweennessCentrality 
            %
            % N = GETCOMPATIBLEGRAPHNUMBER() returns the number of
            % compatible graphs to edge betweenness centrality.
            % 
            % See also getCompatibleGraphList().
            
            n = Measure.getCompatibleGraphNumber('EdgeBetweennessCentrality');
        end
    end
end
