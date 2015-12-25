function res = get_rot(strangle, dstangle)

res = dstangle - strangle;
while res > pi
    res = res - 2*pi;
end
while res < -pi
    res = res + 2*pi;
end

end