function [outdirw indirw] = direction_weights(dirhg)

outdir = [ 0 0 0 0 ];
h = dirhg(1:180);
D = 22;

if sum(h) > 0
    for i = 1:90
        outdir(1) = outdir(1) + h(i) * Gaussian(45, D, i);
    end
    for i = 45:135
        outdir(2) = outdir(2) + h(i) * Gaussian(90, D, i);
    end
    for i = 90:180
        outdir(3) = outdir(3) + h(i) * Gaussian(135, D, i);
    end
    for i = 135:180
        outdir(4) = outdir(4) + h(i) * Gaussian(181, D, i);
    end
    for i = 1:45
        outdir(4) = outdir(4) + h(i) * Gaussian(1, D, i);
    end
    
else
    outdir = [0 0 0 0];
end

indir = [ 0 0 0 0 ];
h = dirhg(181:end);

if sum(h) > 0
    for i = 1:90
        indir(1) = indir(1) + h(i) * Gaussian(45, D, i);
    end
    for i = 45:135
        indir(2) = indir(2) + h(i) * Gaussian(90, D, i);
    end
    for i = 90:180
        indir(3) = indir(3) + h(i) * Gaussian(135, D, i);
    end
    for i = 135:180
        indir(4) = indir(4) + h(i) * Gaussian(181, D, i);
    end
    for i = 1:45
        indir(4) = indir(4) + h(i) * Gaussian(1, D, i);
    end
    
else
    indir = [0 0 0 0];
end

outdirw = outdir / (sum(outdir) + sum(indir));
indirw = indir / (sum(outdir) + sum(indir));

end











