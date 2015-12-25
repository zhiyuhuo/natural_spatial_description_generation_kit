function res = Gaussian(u, d, x)
% res = 1 / sqrt(2 * pi * power(d, 2)) * exp(-0.5 * power(x - u, 2) / power(d, 2));
res = exp(-0.5 * power(x - u, 2) / power(d, 2));
end