function res = gibbs_add(node, feature)

res.nameA = feature.nameA;
res.nameB = feature.nameB;

if (strcmp(res.nameA, 'rotation') == 1)

    res.outdirw = (feature.outdirw + node.outdirw) / 2; 
    res.indirw = max(abs(feature.outdirw - node.outdirw), 0.1);
    res.distw = 0;
    
else
    
    res.outdirw = max([feature.outdirw; node.outdirw]);
    res.indirw = max([feature.indirw; node.indirw]);
    res.distw = max([feature.distw; node.distw]);

end

end