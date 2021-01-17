% test GraphWU

%% Test 1: Constructor
A = rand(randi(10));
g = GraphWU(A);

A = dediagonalize(A);
A = semipositivize(A);
A = symmetrize(A);
A = standardize(A);

assert(isequal(g.getA(), A), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_ERR], ...
    'GraphWU is not constructing well')

%% Test 2: Randomize degree distribution preservation
A = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

g = GraphWU(A);
r_g = g.randomize();

d_g = Degree(g).getValue();
d_rg = Degree(r_g).getValue();
d_g = sort(d_g{1});
d_rg = sort(d_rg{1});
hist_g = histcounts(d_g, 1:5);
hist_rg = histcounts(d_rg, 1:5);

assert(isequal(d_g, d_rg), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_FUNC], ...
    'GraphWU randomize is not working.')

assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_FUNC], ...
    'GraphWU randomize is not working.')

%% Test 3: Static randomize function degree distribution preservation
A = [ 0 1 0 1 0;
    1 0 0 0 1;
    0 0 0 1 0;
    1 0 0 0 1;
    0 1 1 0 0;
    ];

B = max(A, transpose(A));

r_A = GraphWU.randomize_A(B);
g = GraphWU(B);
r_g = GraphWU(r_A);
d_g = Degree(g).getValue();
d_rg = Degree(r_g).getValue();
d_g = sort(d_g{1});
d_rg = sort(d_rg{1});
hist_g = histcounts(d_g, 1:5);
hist_rg = histcounts(d_rg, 1:5);

assert(isequal(d_g, d_rg), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_FUNC], ...
    'GraphWU randomize is not working.')

assert(isequal(hist_g, hist_rg), ...
    [BRAPH2.STR ':GraphWU:' BRAPH2.BUG_FUNC], ...
    'GraphWU randomize_A is not working.')