clc;
clear;
close all;
%

numpath = 1;
numtrip = 3;

footprint = load(['Footprint Set\footprint-' num2str(numpath) '-' num2str(numtrip) '.mat']);
path = footprint.footprint;

stateo = path{1}{4};
for n = 2:length(path)
    statec = path{n}{4};
    featurebag = get_state_featurebag(stateo, statec);
end