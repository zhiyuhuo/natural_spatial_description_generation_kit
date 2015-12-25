function [dirhg disthg] = get_spatial_relation_B_to_A(vA, vB, dirA)

hof = hof_vector_with_angle(vA, vB, dirA);
dirhg = hof(2,:);

A = vA;
B = vB;
d = zeros(1, length(A)*length(B));
D = size(d, 1);
t = 1;
d = [];
% for i = 1:length(A)
%     for j = 1:length(B)
%         d(t) = norm(A(:,i) - B(:,j));
%         t = t + 1;
%     end
% end

for i = 1:length(B)
    db = [];
    for j = 1:length(A)
        db = [db norm(A(:,j) - B(:,i))];
    end
    d(t) = min(db);
    t = t + 1;
end

disthg = histc(d, 0 : 0.1 : 9.9);
disthg = disthg / length(B);

end