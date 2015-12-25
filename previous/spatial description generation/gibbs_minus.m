function res = gibbs_minus(node, feature)


res.nameA = feature.nameA;
res.nameB = feature.nameB;

if (strcmp(res.nameA, 'rotation') == 1)

    res.outdirw = node.outdirw; 
    d = node.outdirw - feature.outdirw;
    while d > pi
        d = d - 2*pi;
    end
    while d < -pi
        d = d + 2*pi;
    end
    res.indirw = min([abs(d) - node.indirw,node.indirw]);
    res.distw = 0;
    
else
    
    res.outdirw = min([feature.outdirw; node.outdirw]);
    res.indirw = min([feature.indirw; node.indirw]);
    res.distw = min([feature.distw; node.distw]);

end

end