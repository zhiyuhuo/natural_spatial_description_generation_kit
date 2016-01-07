clc;
clear;
close all;
%

data = load('xls_data.mat');
data = data.data;
chunknamedic = data.chunknamedic;

%relation types A to B
relationtypes = {'parent_left', 'parent_right', 'child_left', 'child_right', 'sibling-left', 'sibliing-right'};
mx = zeros(length(chunknamedic), length(chunknamedic), length(relationtypes));
xmlDoc = xmlread('static_descriptions.xml');
namepairlist = {};

for n = 1:length(chunknamedic)
    nodename = chunknamedic{n};
    IDArray = xmlDoc.getElementsByTagName(chunknamedic{n});
    for i = 0 : IDArray.getLength-1   
        %   1,2,3,4
        childnodes = IDArray.item(i).getChildNodes;
        for j = 0 : childnodes.getLength-1  
            childnodename = childnodes.item(j).getNodeName;
            for n1 = 1:length(chunknamedic)
                if strcmp(childnodename,chunknamedic{n1}) == 1
                    if j+1 < (childnodes.getLength-1)/2
                        mx(n, n1, 2) = mx(n, n1, 2) + 1;
                        mx(n1, n, 3) = mx(n1, n, 3) + 1;
                        
                        namepairlist{end+1} = {nodename, childnodename, 'parent_right'};
                        namepairlist{end+1} = {childnodename, nodename, 'child_left'};
                    else
                        mx(n, n1, 1) = mx(n, n1, 1) + 1;
                        mx(n1, n, 4) = mx(n1, n, 4) + 1;     
                        
                        namepairlist{end+1} = {nodename, childnodename, 'parent_left'};
                        namepairlist{end+1} = {childnodename, nodename, 'child_right'};
                    end
                end
            end
        end
        
        %   5
        siblingleftnodename = IDArray.item(i).getPreviousSibling.getNodeName;
        for n1 = 1:length(chunknamedic)
            if strcmp(siblingleftnodename,chunknamedic{n1}) == 1
                mx(n, n1, 5) = mx(n, n1, 5) + 1;
                namepairlist{end+1} = {siblingleftnodename, nodename, 'sibling_left'};
            end
        end
        
        %   6
        siblingrightnodename = IDArray.item(i).getNextSibling.getNodeName;
        for n1 = 1:length(chunknamedic)
            if strcmp(siblingrightnodename,chunknamedic{n1}) == 1
                mx(n, n1, 6) = mx(n, n1, 6) + 1;
                namepairlist{end+1} = {siblingrightnodename, nodename, 'sibling_right'};
            end
        end
    end 
end

save('namepairlist.mat', 'namepairlist');




    