function res = diff_sp2(dir1, dist1, dir2, dist2)

dirh1 = 1;
diri1 = 0;
for i = 2:180
    dir2new = [dir2(i:181) dir(1:i)];
    dh = sum(abs(dir2new - dir1));
    if dh < dirh1
        diri1 = i;
    end
end

if j - i >= 90
    d = d - 180;
elseif j - i < -90
    d = d + 180;
end 
rh1 = 1 - (1 - dh) * (1 - dh);

end