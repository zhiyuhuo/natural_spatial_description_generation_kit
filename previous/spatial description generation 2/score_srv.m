function res = score_srv(srv, node)

r = 0;
namesrv = [srv.nameA '_' srv.nameB];
namenode = [node.nameA '_' node.nameB];

if strcmp(namesrv, namenode) == 1
    name = namesrv;
    
    if strcmp(name, 'rotation_rotation')
        d = abs(get_rot(srv.outdirw, node.outdirw));
        if d <= node.indirw
            r = 1;
        elseif d < pi / 4
            r = (pi/4 - d) / (pi/4);
        else
            r = 0;
        end
    else
        r = ( [node.outdirw node.indirw] * [srv.outdirw srv.indirw]' + node.distw * srv.distw' ) / 2;
    end
end

res = r;

end