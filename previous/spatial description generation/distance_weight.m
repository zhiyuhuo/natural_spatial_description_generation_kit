function res = distance_weight(disthg)

distw = [0 0 0 0];
distw(1) = disthg(1);

for i = 2:100
    distw(2) = distw(2) + disthg(i) * Gaussian(10, 5, i);
    distw(3) = distw(3) + disthg(i) * Gaussian(25, 5, i);
    distw(4) = distw(4) + disthg(i) * Gaussian(60, 10, i);
end

if sum(distw(2:end)) > 0
    distw(2:end) = distw(2:end) / sum(distw(2:end)) * sum(disthg(2:end)) / sum(disthg);
end


res = distw;


end