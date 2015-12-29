function res = get_xml_node_content(childnodes)

res = '';

for n = 0 : childnodes.getLength-1 
    childnodename = childnodes.item(n).getNodeName;
    if length(childnodename) <= 3
        text = childnodes.item(n).getTextContent;
        res = [res ' ' char(text)];
    end
end

res = res(2:end);

end