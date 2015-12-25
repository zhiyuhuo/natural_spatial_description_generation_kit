function [v dir name] = get_wall_entity(roomname)

walldim = [[2.4, 8, 9.3, 0.2];
            [-2.3, 4.67, 0.2, 6.67];
            [2.4, 1.33, 9.3, 0.2];
            [7, 4.67, 0.2, 6.67];
            [0.6, -7.9, 5.6, 0.2];
            [3.4, -4.82, 0.2, 6.6];
            [0.6, -1.3, 5.6, 0.2];
            [-2.2, -4.82, 0.2, 6.6]];

v = [];
dir = -1;
name = '';
if strcmp(roomname, 'bedroom') == 1
    for i = 1:4
        v = [v, make_large_obj_vector(walldim(i,1), walldim(i,2), walldim(i,3), walldim(i,4))];
    end
    name = 'wall';
    dir = 270 * pi / 180;
elseif strcmp(roomname, 'livingroom') == 1
    for i = 5:8
        v = [v, make_large_obj_vector(walldim(i,1), walldim(i,2), walldim(i,3), walldim(i,4))];
    end
    name = 'wall';
    dir = 90 * pi / 180;
end

end