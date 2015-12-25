clc;
clear;
close all;
%

folderlist = ls('Mats\');
detectorlib = containers.Map();

for n = 3:size(folderlist, 1)
    fdname = [];
    ep = 0;
    if ~isempty(find(folderlist(n,:) == ' ', 1))
        ep = find(folderlist(n,:) == ' ');
    else
        ep = length(folderlist(n,:))+1;
    end  
    fdname = folderlist(n,1:ep(1)-1);
    fddirectory = ['Mats\' fdname '\'];
    flist = ls(fddirectory);
    detector = {};
    for k = 3:size(flist, 1)
        fname = [];
        ep2 = 0;
        if ~isempty(find(flist(k,:) == ' ', 1))
            ep2 = find(flist(k,:) == ' ');
        else
            ep2 = length(flist(k,:))+1;
        end  
        fname = flist(k,1:ep2(1)-1);
        node = load(['Mats\' fdname '\' fname]);
        node = node.node;
        detector{end+1} = node;
    end
    detectorlib(fdname) = detector;
end

detectornames = keys(detectorlib);
save('detectorlib.mat', 'detectorlib');