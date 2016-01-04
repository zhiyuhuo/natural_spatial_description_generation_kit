%
clc;
clear;
close all;
%

data = load('xls_data.mat');
data = data.data;

rdts = data.chunkrdtlist;
contents = data.chunkcontentlist;

rdttypes = unique(rdts);



for i = 1:length(rdttypes)
    ids = find(strcmp(rdts, rdttypes{i}) == 1)
    
end