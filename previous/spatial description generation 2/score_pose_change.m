function res = score_pose_change(poseo, posec)

po = poseo(1:2);
pc = posec(1:2);

to = poseo(3);
tc = posec(3);

dist = norm(po - pc);
rot = get_rot(to, tc);

r = 0;
if dist < 1.5
    r = 1;
elseif dist > 1.5 && dist < 2 && rot < 0.5 * pi
    r = 1;
elseif dist > 2 && rot < 0.25 * pi
    r = exp(2-dist);
else
    r = 0;
end

res = r;
end