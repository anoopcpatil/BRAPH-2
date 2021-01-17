% test quantiles

%% Test 1: Test scalar input
M = 1e+2;
values = cell(1, M);
for i = 1:1:size(values, 2)
    values{i} = 10 * (i - 1) / (M - 1);
end
Q = quantiles(values, 10);
assert(isequal(round(Q{1}), 0:1:10), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])

M = 1e+5;
values = cell(1, M);
for i = 1:1:size(values, 2)
    values{i} = 10 * rand();
end
Q = quantiles(values, 10);
assert(isequal(round(Q{1}), 0:1:10), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])

%% Test 2: Test vector input
M = 1e+2;
values = cell(1, M);
for i = 1:1:size(values, 2)
    values{i} = 10 * ones(3, 1) * (i - 1) / (M - 1);
end
Q = quantiles(values, 10);
assert(all(cellfun(@(x) isequal(round(x), 0:1:10), Q)), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])
   
M = 1e+5;
values = cell(1, M);
for i = 1:1:size(values, 2)
    values{i} = 10 * rand(3, 1);
end
Q = quantiles(values, 10);
assert(all(cellfun(@(x) isequal(round(x), 0:1:10), Q)), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])

%% Test 2: Test matrix input
M = 1e+2;
values = cell(1, M + 1);
for i = 1:1:size(values, 2)
    values{i} = 10 * ones(3) * (i - 1) / (M - 1);
end
Q = quantiles(values, 10);
assert(all(all(cellfun(@(x) isequal(round(x), 0:1:10), Q))), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])

M = 1e+5;
values = cell(1, M + 1);
for i = 1:1:size(values, 2)
    values{i} = 10 * rand(3);
end
Q = quantiles(values, 10);
assert(all(all(cellfun(@(x) isequal(round(x), 0:1:10), Q))), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])