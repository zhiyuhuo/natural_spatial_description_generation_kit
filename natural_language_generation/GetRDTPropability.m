%
clc;
clear;
close all;
%

rdtpairlist = load('rdtpairlist.mat');
rdtpairlist = rdtpairlist.rdtpairlist;

pairkeylist = {};
pairrelationlist = {};


for n = 1:length(rdtpairlist)
    
    pairkeylist{end+1} = [rdtpairlist{n}{1} '-' rdtpairlist{n}{2}];
    pairrelationlist{end+1} = rdtpairlist{n}{3};
    
end

pairkeyuniqueset = unique(pairkeylist);
for i = 1:length(pairkeyuniqueset)
    keyrdtset = find(strcmp(pairkeylist, pairkeyuniqueset{i}) == 1);
    str = [pairkeyuniqueset{i} ':'];
    for j = 1:length(keyrdtset)
        str = [str '   ' pairrelationlist{keyrdtset(j)}];
    end
    disp(str);
end