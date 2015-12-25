function res = make_obj_vector(px, py, dx, dy)

res = [];

for x = px-dx/2 : 0.1 : px+dx/2
    for y = py-dy/2 : 0.1 : py+dy/2
        res = [res, [x, y]'];
    end
end



end