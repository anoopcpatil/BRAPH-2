%% ¡header!
SeededRandomness < ConcreteElement (sr, randomizer) generates a random number.

%%% ¡description!



%% ¡props_update!

%%% ¡prop!
ELCLASS (constant, string) is the class of the randomizer.
%%%% ¡default!
'SeededRandomness'



%% ¡props!

%%% ¡prop!
RANDOM_NUMBER (result, scalar) is a random number.
%%%% ¡calculate!
value = rand();


%% ¡tests!

%%% ¡test!
Simple test
%%%% ¡code!
sr1 = SeededRandomness()
sr2 = SeededRandomness()

assert(sr1.get('RANDOM_NUMBER') == sr1.get('RANDOM_NUMBER')) 
assert(sr2.get('RANDOM_NUMBER') == sr2.get('RANDOM_NUMBER')) 
assert(sr1.get('RANDOM_NUMBER') ~= sr2.get('RANDOM_NUMBER')) 