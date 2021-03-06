function res = change_dct(nodes, feature)

keyset = keys(nodes)

res.nameA = feature.nameA;
res.nameB = feature.nameB;

if (strcmp(res.nameA, 'rotation') == 1)

    res.outdirw = (feature.outdirw + node.outdirw) / 2; 
    res.indirw = abs(feature.outdirw - node.outdirw);
    res.distw = 0;
    
else
    
    res.outdirw = max([feature.outdirw; node.outdirw]);
    res.indirw = max([feature.indirw; node.indirw]);
    res.distw = max([feature.distw; node.distw]);

end

end