function res = histogram_of_forces(A, B)
% the spatial relation B to A

hof = zeros(1, 180*2);
hofg = zeros(1, 180*2);

xminA = min(A(1,:));
xmaxA = max(A(1,:));
yminA = min(A(2,:));
ymaxA = max(A(2,:));

Bout = 0;

for i = 1:length(B)
    xB = B(1, i);
    yB = B(2, i);
    
    if xB >= xminA && xB <= xmaxA && yB >= yminA && yB <= ymaxA
        Bout = Bout + 1;
    end
    
    for j = 1:length(A)
        xA = A(1, j);
        yA = A(2, j);      
        if xA == xB && yA == yB
            hof(181:end) = hof(181:end) + 1;
            hofg(181:end) = hofg(181:end) + 1 / power(0.05, 2);
        else      
            anglerad = atan2(yB - yA, xB - xA);
            if anglerad < 0
                anglerad = anglerad + 2 * pi;
            end
            if anglerad >= 2*pi
                anglerad = anglerad - 2 * pi;
            end
            
            angledegree = floor(anglerad * 180 / pi / 2) + 1;

            if xB >= xminA && xB <= xmaxA && yB >= yminA && yB <= ymaxA
                angledegree = angledegree + 180;
            end

            hof(angledegree) = hof(angledegree) + 1;
            dist = norm([xA-xB, yA-yB]);
            if dist < 0.05
                dist = 0.05;
            end
            hofg(angledegree) = hofg(angledegree) + 1 / power(dist, 2);
        end
    end
end

% for i = 1:length(A)
%     xA = A(1, i);
%     yA = A(2, i);
%     for j = 1:length(B)
%         xB = B(1, j);
%         yB = B(2, j);
%       
%         if xA == xB && yA == yB
%             hof(181:end) = hof(181:end) + 1;
%             hofg(181:end) = hofg(181:end) + 1 / power(0.05, 2);
%         else      
%             angleradorigin = atan2(yB - yA, xB - xA);
%             anglerad = angleradorigin;
%             if anglerad < 0
%                 anglerad = anglerad + 2 * pi;
%             end
%             
%             if anglerad >= 2*pi
%                 anglerad = anglerad - 2 * pi;
%             end
%             
%             angledegree = floor(anglerad * 180 / pi / 2) + 1;
%             
%             if angledegree == 181
%             end
% 
%             if xB >= xminA && xB <= xmaxA && yB >= yminA && yB <= ymaxA
%                 angledegree = angledegree + 180;
%                 Bout = Bout + 1;
%             end
% 
%             hof(angledegree) = hof(angledegree) + 1;
%             dist = norm([xA-xB, yA-yB]);
%             hofg(angledegree) = hofg(angledegree) + 1 / power(dist, 2);
%         end
%     end
% end
if sum(hof(1:180)) > 0
    hof(1:180) = hof(1:180) / sum(hof(1:180)) * (length(B)-Bout) / length(B);
end

if sum(hof(181:end)) > 0
    hof(181:end) = hof(181:end) / sum(hof(181:end)) * Bout / length(B);
end

if sum(hofg(1:180)) > 0
    hofg(1:180) = hofg(1:180) / sum(hofg(1:180)) * (length(B)-Bout) / length(B);
end

if sum(hof(181:end)) > 0
    hofg(181:end) = hofg(181:end) / sum(hofg(181:end)) * Bout / length(B);
end

% hof = hof / sum(abs(hof));
% hofg = hofg / sum(abs(hofg));

res = [hof; hofg];

end