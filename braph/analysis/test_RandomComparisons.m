% test RandomComparison
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

randomComparison_class_list =  RandomComparison.getList();

%% Test 1 Instantiation
for i = 1:1:length(randomComparison_class_list)
    % setup
    randomComparison_class = randomComparison_class_list{i};
    subject_class = RandomComparison.getSubjectClass(randomComparison_class);
    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
    group = Group(subject_class, {sub1, sub2, sub3});
    
    % act
    randomcomparison = RandomComparison.getRandomComparison(randomComparison_class, ...
        'rc1', ...
        atlas, ...
        {group group}, ...
        'setting name', 'setting value');
    
    % assert
    assert(~isempty(randomcomparison), ...
        ['BRAPH:' randomComparison_class ':Instantiation'], ...
        [randomComparison_class ' instantiation fail.'])
    
end

%% Test 2: Static Functions
for i = 1:1:length(randomComparison_class_list)
    
    % setup
    randomComparison_class = randomComparison_class_list{i};
    subject_class = RandomComparison.getSubjectClass(randomComparison_class);
    sub1 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 1);
    sub2 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 2);
    sub3 = Subject.getSubject(subject_class, repmat({atlas}, 1, Subject.getBrainAtlasNumber(subject_class)), 'SubjectID', 3);
    group = Group(subject_class, {sub1, sub2, sub3});
    
    % act
    randomcomparison = RandomComparison.getRandomComparison( ...
        randomComparison_class, ...
        'rc1', ...
        atlas, ...
        {group group});
    
    % assert
    assert(isequal(randomcomparison.getClass(), randomComparison_class), ...
        ['BRAPH:' randomComparison_class ':StaticFunctions'], ...
        [randomComparison_class 'getClass() fail.']) 
    assert(ischar(randomcomparison.getName()), ...
        ['BRAPH:' randomComparison_class ':StaticFunctions'], ...
        [randomComparison_class 'getName() fail.']) 
    assert(ischar(randomcomparison.getDescription()), ...
        ['BRAPH:' randomComparison_class ':StaticFunctions'], ...
        [randomComparison_class ' getDescription() fail.']) 
    assert(~isempty(randomcomparison.getBrainAtlasNumber()), ...
        ['BRAPH:' randomComparison_class ':StaticFunctions'], ...
        [randomComparison_class 'getAtlasesNumber() fail.'])
    assert(ischar(randomcomparison.getAnalysisClass()), ...
        ['BRAPH:' randomComparison_class ':StaticFunctions'], ...
        [randomComparison_class '.getAtlasesNumber() fail.'])
    assert(ischar(randomcomparison.getSubjectClass()), ...
        ['BRAPH:' randomComparison_class ':StaticFunctions'], ...
        [randomComparison_class '.getAtlasesNumber() fail.'])
end