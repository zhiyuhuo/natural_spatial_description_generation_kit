function res = get_distance_between_two_entities(ent1, ent2)

vec1 = ent1.vec;
vec2 = ent2.vec;

dmin = 100;

for i = 1:size(vec1, 2)
    for j = 1:size(vec2, 2)
        d = norm(vec1(:,i) - vec2(:,j));
        if d < dmin
            dmin = d;
        end
    end
end

res = dmin;

end