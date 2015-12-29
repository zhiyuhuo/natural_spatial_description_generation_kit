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
xmlDoc = xmlread('149template.xml');

for n = 1:length(chunknamedic)
    IDArray = xmlDoc.getElementsByTagName(chunknamedic{n});
    for i = 0 : IDArray.getLength-1   
        %   1,2,3,4
        childnodes = IDArray.item(i).getChildNodes;
        for j = 0 : childnodes.getLength-1  
            chldnodeName = childnodes.item(j).getNodeName;
            for n1 = 1:length(chunknamedic)
                if strcmp(chldnodeName,chunknamedic{n1}) == 1
                    if j+1 < (childnodes.getLength-1)/2
                        mx(n, n1, 2) = mx(n, n1, 2) + 1;
                        mx(n1, n, 3) = mx(n1, n, 3) + 1;
                    else
                        mx(n, n1, 1) = mx(n, n1, 1) + 1;
                        mx(n1, n, 4) = mx(n1, n, 4) + 1;                       
                    end
                end
            end
        end
        
        %   5
        siblingleftnodeName = IDArray.item(i).getPreviousSibling.getNodeName;
        for n1 = 1:length(chunknamedic)
            if strcmp(siblingleftnodeName,chunknamedic{n1}) == 1
                mx(n, n1, 5) = mx(n, n1, 5) + 1;
            end
        end
        
        %   6
        siblingrightnodeName = IDArray.item(i).getNextSibling.getNodeName;
        for n1 = 1:length(chunknamedic)
            if strcmp(siblingrightnodeName,chunknamedic{n1}) == 1
                mx(n, n1, 6) = mx(n, n1, 6) + 1;
            end
        end
    end 
end




    