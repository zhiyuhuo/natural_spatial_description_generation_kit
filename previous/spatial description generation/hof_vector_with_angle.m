function res = hof_vector_with_angle(a, b, atheta)

a2 = a;
ca = [mean(a(1, :)); mean(a(2, :))];
a2(1, :) = a2(1, :) - ca(1);
a2(2, :) = a2(2, :) - ca(2);

b2 = b;
b2(1, :) = b2(1, :) - ca(1);
b2(2, :) = b2(2, :) - ca(2);

dth = atheta - pi / 2;

for i = 1:length(a2)
	x = a2(1, i);
	y = a2(2, i);
    a2(1,i) = x * cos(dth) + y * sin(dth);
    a2(2,i) = -x * sin(dth) + y * cos(dth);
end

for i = 1:length(b2)
	x = b2(1, i);
	y = b2(2, i);
    b2(1,i) = x * cos(dth) + y * sin(dth);
    b2(2,i) = -x * sin(dth) + y * cos(dth);
end

%res = hof_vector(a2, b2);
res = histogram_of_forces(a2, b2);

end