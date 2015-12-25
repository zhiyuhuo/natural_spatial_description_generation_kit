clc;
clear;
close all;
%

lib = load('features.mat');
lib = lib.lib;

vocabulary = load('vocab_cmd_sp.mat');
cmdset = vocabulary.vocabulary.cmd;
cmdtrialdataset = {};

for i = 1:length(cmdset)
    sampleset = {};
    for j = 1:length(lib)
        trial = lib{j};
        cmd = trial{1};
        cmdstr = [cmd{1} '_' cmd{2} '_' cmd{3} '_' cmd{4} '_' cmd{5}];
        samples = trial{2};
        labels = trial{3};
        states = trial{4};
        if strcmp(cmdset{i}, cmdstr) == 1
            for k = 1:length(samples);
                sample = {samples{k}, labels(k), states{k}};
                sampleset{end+1} = sample;
            end
        end
    end
    cmdtrialdataset{end+1} = {cmdset{i}, sampleset};
end

save('cmd_trial_dataset.mat', 'cmdtrialdataset');






