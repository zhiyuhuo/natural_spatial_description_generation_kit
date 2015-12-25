function res = diff_sp(dir1, dist1, dir2, dist2) % get the difference from 2 to 1
res = [0 0 0];

if length(dir1) > 1

    h = zeros(1, 181);
    for i = 1:length(dir1(1:181))
        for j = 1:length(dir2(1:181))
            if dir2(j) > 0 && dir1(i) > 0
                m = dir2(j) + dir1(i);
                d = j - i;
                if j - i >= 90
                    d = d - 180;
                elseif j - i < -90
                    d = d + 180;
                end           
                if (d < -89 || d > 90)
                end               
                h(d + 90 + 1) =  h(d + 90 + 1) + m;
            end
        end
    end
    res(1) = (sum((h / sum(h)).*(1:181)) - 91) * 2;
    
    dir1b = dir1(182:end);
    dir2b = dir2(182:end);
    h = zeros(1, 181);
    for i = 1:length(dir1b(1:181))
        for j = 1:length(dir2b(1:181))
            if dir2b(j) > 0 && dir1b(i) > 0
                m = dir2b(j) + dir1b(i);
                d = j - i;
                if j - i >= 90
                    d = d - 180;
                elseif j - i < -90
                    d = d + 180;
                end           
                if (d < -89 || d > 90)
                end               
                h(d + 90 + 1) =  h(d + 90 + 1) + m;
            end
        end
    end
    res(2) = (sum((h / sum(h)).*(1:181)) - 91) * 2;
    

    ds = zeros(1, 200);
    for i = 1:length(dist1)
        for j = 1:length(dist1)         
            if dist2(j) > 0 && dist1(i) > 0
                m = dist1(i) * dist2(j);
                d = j - i;
                ds(d + 100) =  ds(d + 100) + m;
            end
        end
    end
    res(3) = (sum((ds/sum(ds)).*(1:200)) - 100);

end

end