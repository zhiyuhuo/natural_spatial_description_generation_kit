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

rdtcontentdic = containers.Map();

for i = 1:length(rdttypes)
    ids = find(strcmp(rdts, rdttypes{i}) == 1);
    rdtcontentdic(rdttypes{i}) = contents(ids);
end

rdtcontentSTR = '';
keyset = keys(rdtcontentdic)
for i = 1:length(keyset)
    disp(rdtcontentdic(keyset{i}))
    str = [keyset{i} ': '];
    group = rdtcontentdic(keyset{i});
    for j = 1:length(group)
        str = [str group{j} ','];
    end
    rdtcontentSTR = [rdtcontentSTR str char(10)];
end

save('rdtcontentdic.mat', 'rdtcontentdic');

fid = fopen('rdtcontent.txt','wt');
fprintf(fid, '%s', rdtcontentSTR);
fclose(fid);