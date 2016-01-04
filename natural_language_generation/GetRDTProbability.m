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
relationtypes = unique(pairrelationlist);

rdtkeysprob = containers.Map;
pairkeyuniqueset = unique(pairkeylist);
rdtkeyrelationprobSTR = '';
for i = 1:length(pairkeyuniqueset)
    keyrdtset = find(strcmp(pairkeylist, pairkeyuniqueset{i}) == 1);
    str = [pairkeyuniqueset{i} ':'];
    for j = 1:length(keyrdtset)
        str = [str '   ' pairrelationlist{keyrdtset(j)}];
    end
    disp(str); 
    
    L = length(keyrdtset);
    p = zeros(1, length(relationtypes));
    keyrdtrelationlist = pairrelationlist(keyrdtset);
    for j = 1:length(relationtypes)
        p(j) = length(find(strcmp(keyrdtrelationlist, relationtypes{j}) == 1)) / L;
    end   
    
    rdtkeyrelationprobSTR = [rdtkeyrelationprobSTR pairkeyuniqueset{i} ': ' num2str(p) char(10)];
    
    rdtkeysprob(pairkeyuniqueset{i}) = p;
end

rdtkeyrelationprob.relationprob = rdtkeysprob;
rdtkeyrelationprob.relationtypes = relationtypes;
save('rdtkeyrelationprob.mat', 'rdtkeyrelationprob');

fid = fopen('rdtkeyrelationprob.txt','wt');
fprintf(fid, '%s', rdtkeyrelationprobSTR);
fclose(fid);



