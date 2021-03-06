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
    clauses = contents(ids);
    clauses = clauses(find(~cellfun(@isempty,clauses)));
    [ucontents b] = unique(clauses);
    [mb c] = max(b)
    clause = clauses{c};
    rdtcontentdic(rdttypes{i}) = clause;
    
end

rdtcontentSTR = '';
keyset = keys(rdtcontentdic)
for i = 1:length(keyset)
    disp(rdtcontentdic(keyset{i}))
    str = [keyset{i} ': ' rdtcontentdic(keyset{i})];
    rdtcontentSTR = [rdtcontentSTR str char(10)];
end

save('rdtcontentdic.mat', 'rdtcontentdic');

fid = fopen('rdtcontent.txt','wt');
fprintf(fid, '%s', rdtcontentSTR);
fclose(fid);