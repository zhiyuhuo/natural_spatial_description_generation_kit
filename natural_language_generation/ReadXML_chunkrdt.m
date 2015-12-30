clc;
clear;
close all;
%

data = load('xls_data.mat');
data = data.data;
chunknamedic = data.chunknamedic;
chunknamelist = data.chunknamelist;
chunkcontentlist = data.chunkcontentlist;
chunkrdtlist = data.chunkrdtlist;

%relation types A to B
relationtypes = {'parent_left', 'parent_right', 'child_left', 'child_right', 'sibling_left', 'sibliing_right'};
mx = zeros(length(chunkrdtlist), length(chunkrdtlist), length(relationtypes));
xmlDoc = xmlread('149template.xml');

rdtpairlist = {};

for n = 1:length(chunknamedic)
    nodename = chunknamedic{n};
    IDArray = xmlDoc.getElementsByTagName(chunknamedic{n});
    for i = 0 : IDArray.getLength-1   
        %   1,2,3,4
        childnodes = IDArray.item(i).getChildNodes;
        text = get_xml_node_content(childnodes);
        rdt = get_rdt_from_content(nodename, text, chunknamelist, chunkcontentlist, chunkrdtlist);
        
        for j = 0 : childnodes.getLength-1  
            childnodename = childnodes.item(j).getNodeName;
            for n1 = 1:length(chunknamedic)
                if strcmp(childnodename,chunknamedic{n1}) == 1
                    subchildnodes = childnodes.item(j).getChildNodes;
                    text1 = get_xml_node_content(subchildnodes);
                    rdt1 = get_rdt_from_content(childnodename, text1, chunknamelist, chunkcontentlist, chunkrdtlist);
                    if j+1 < (childnodes.getLength-1)/2
%                         mx(n, n1, 2) = mx(n, n1, 2) + 1;
%                         mx(n1, n, 3) = mx(n1, n, 3) + 1;
                          rdtpairlist{end+1} = {rdt, rdt1, 'parent_right'};
                          rdtpairlist{end+1} = {rdt1, rdt, 'child_left'};
                    else
%                         mx(n, n1, 1) = mx(n, n1, 1) + 1;
%                         mx(n1, n, 4) = mx(n1, n, 4) + 1;  
                          rdtpairlist{end+1} = {rdt, rdt1, 'parent_left'};
                          rdtpairlist{end+1} = {rdt1, rdt, 'child_right'};
                    end
                end
            end
        end
        
        %   5
        siblingleftnodeName = IDArray.item(i).getPreviousSibling.getNodeName;
        for n1 = 1:length(chunknamedic)
            if strcmp(siblingleftnodeName,chunknamedic{n1}) == 1
                subchildnodes = IDArray.item(i).getPreviousSibling.getChildNodes;
                text1 = get_xml_node_content(subchildnodes);
                rdt1 = get_rdt_from_content(childnodename, text1, chunknamelist, chunkcontentlist, chunkrdtlist);
%                 mx(n, n1, 5) = mx(n, n1, 5) + 1;
                rdtpairlist{end+1} = {rdt1, rdt, 'sibling_left'};
            end
        end
        
        %   6
        siblingrightnodeName = IDArray.item(i).getNextSibling.getNodeName;
        for n1 = 1:length(chunknamedic)
            if strcmp(siblingrightnodeName,chunknamedic{n1}) == 1
                subchildnodes = IDArray.item(i).getPreviousSibling.getChildNodes;
                text1 = get_xml_node_content(subchildnodes);
                rdt1 = get_rdt_from_content(childnodename, text1, chunknamelist, chunkcontentlist, chunkrdtlist);
%                 mx(n, n1, 6) = mx(n, n1, 6) + 1;
                rdtpairlist{end+1} = {rdt1, rdt, 'sibling_right'};
            end
        end
    end 
end

save('rdtpairlist.mat', 'rdtpairlist');





    