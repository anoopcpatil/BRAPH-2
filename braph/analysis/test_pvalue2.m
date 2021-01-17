% test pvalue2

%% Test 1: Test scalar input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 10 * (i - 1) / (M - 1) - 5;
end

observed_difference = 4;
P2 = pvalue2(observed_difference, random_differences);
assert(isequal(round(100 * P2), 20), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in pvalue2 calculation'])

observed_difference = 6;
P2 = pvalue2(observed_difference, random_differences);
assert(isequal(round(100 * P2), 0), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in pvalue2 calculation'])

%% Test 2: Test vector input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 10 * ones(3, 1) * (i - 1) / (M - 1) - 5;
end

observed_difference = 4 * ones(3, 1);
P2 = pvalue2(observed_difference, random_differences);
assert(all(round(100 * P2) == 20), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in pvalue2 calculation'])

observed_difference = 6 * ones(3, 1);
P2 = pvalue2(observed_difference, random_differences);
assert(all(round(100 * P2) == 0), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])

%% Test 2: Test matrix input
M = 1e+3;
random_differences = cell(1, M);
for i = 1:1:size(random_differences, 2)
    random_differences{i} = 10 * ones(3) * (i - 1) / (M - 1) - 5;
end

observed_difference = 4 * ones(3);
P2 = pvalue2(observed_difference, random_differences);
assert(all(all(round(100 * P2) == 20)), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in pvalue2 calculation'])

observed_difference = 6 * ones(3);
P2 = pvalue2(observed_difference, random_differences);
assert(all(all(round(100 * P2) == 0)), ...
    ['BRAPH:quantiles:error'], ...
    ['Error in quantile calculation'])