function res = inside_direction_weights(dirhg)

dir = [ 0 0 0 0 ];
h = dirhg(180:end);

if sum(h) > 0
    for i = 1:90
        dir(1) = dir(1) + h(i) * Gaussian(45, 10, i);
    end
    for i = 45:135
        dir(2) = dir(2) + h(i) * Gaussian(90, 10, i);
    end
    for i = 90:180
        dir(3) = dir(3) + h(i) * Gaussian(135, 10, i);
    end
    for i = 135:180
        dir(4) = dir(4) + h(i) * Gaussian(181, 10, i);
    end
    for i = 1:45
        dir(4) = dir(4) + h(i) * Gaussian(1, 10, i);
    end
    
    dir = dir / sum(dir) * sum(h)/sum(dirhg);
    
else
    dir = [0 0 0 0];
end
res = dir;

end