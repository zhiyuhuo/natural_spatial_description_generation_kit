clear;
close all;
clc;

%
features = load('features.mat');
lib = features.lib;

cmdnameset = {};
for i = 1:length(lib)
    cmdcell = lib{i}{1};
    cmdname = [cmdcell{1} '_' cmdcell{2} '_' cmdcell{3} '_' cmdcell{4} '_' cmdcell{5}];
    cmdnameset{end+1} = cmdname;
end
cmdnamevocab = unique(cmdnameset);

spnameset = {};
for i = 1:length(lib)
    statecell = lib{i}{2};
    for j = 1:length(statecell)
        bagcell = statecell{j};
        for k = 1:length(bagcell)
            sp = bagcell{k};
            spname = [sp.nameA '_' sp.nameB];
            spnameset{end+1} = spname;
        end
    end
end

spnamevocab = unique(spnameset);

vocabulary.cmd = cmdnamevocab;
vocabulary.sp = spnamevocab;

save('vocab_cmd_sp', 'vocabulary');
