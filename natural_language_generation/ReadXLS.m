clc;
clear;
close all;
%

[num,txt,raw] = xlsread('raw_dataset.xlsx');

chunknamelist = txt(2:size(txt, 1),2);   
rawchunkcontent = txt(2:end,3);
rawrdt = txt(2:end, 4:8);
chunkcontentlist = cell(size(rawrdt,1),1);
chunkrdtlist = cell(size(rawrdt,1),1);

%get content
for i = 1:size(rawchunkcontent, 1)
    str = rawchunkcontent{i,:};
    sent = {};
    wd = '';
    for k = 1:length(str)
        if strcmp(str(k), ' ') == 1
            sent{end+1} = wd;
            wd = '';
        else
            wd(end+1) = str(k);
        end
    end
    sent{end+1} = wd;
    sent = sent(2:end);
    content = [];
    for k = 2:2:length(sent)
        content = [content ' ' sent{k}];
    end
    content = content(2:end);
    chunkcontentlist{i} = content;
end

%get rdt
for i = 1:size(rawrdt, 1)
    cmd = rawrdt(i,:);
    for k = 1:length(cmd)
        if strcmp(cmd(k),'N/A') == 1 
            cmd{k} = 'non';
        end
    end
    if strcmp(cmd(1),'non') == 0
        chunkrdtlist{i,1} = cmd{1};
    elseif strcmp(cmd(2),'non') == 0
        chunkrdtlist{i,1} = cmd{2};
    else
        chunkrdtlist{i,1} = [cmd{3} '_' cmd{4} '_' cmd{5}];
    end
end

chunknamedic = unique(chunknamelist);

data.chunknamedic = chunknamedic;
data.chunknamelist = chunknamelist;
data.chunkcontentlist = chunkcontentlist;
data.chunkrdtlist = chunkrdtlist;
save('xls_data.mat', 'data');






