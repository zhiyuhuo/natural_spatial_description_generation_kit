function [v dir name] = get_go_entity(fid)

lib = load('id_parameter_map.mat');
map = lib.idparametermap;
fidstr = num2str(fid);
f = map(fidstr);
%disp(f.name)
%disp(f.pose)
%disp(f.dim)
if (strcmp(f.name, 'bed') == 1)
end

v = [];
if (f.pose(3) <0 || f.pose(3) == 0 || f.pose(3) == 180)
    v = make_obj_vector(f.pose(1), f.pose(2), f.dim(1), f.dim(2));
else
    v = make_obj_vector(f.pose(1), f.pose(2), f.dim(2), f.dim(1));
end
dir = f.pose(3) * pi / 180;
name = f.name;

