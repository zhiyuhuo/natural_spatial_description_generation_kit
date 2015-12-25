function res = dist_hg(vA, vB)

A = vA;
B = vB;
d = zeros(length(A)*length(B), 1);
D = size(d, 1);
t = 1;
for i = 1:length(A)
    for j = 1:length(B)
        d(t) = norm(A(:,i) - B(:,j));
        t = t + 1;
    end
end
p = [length(find(d < 0))/D, length(find(d <= 1.5))/D, length(find(d <= 2.5 & d > 1.5))/D, length(find(d >= 2.5))/D];
res = p;
end