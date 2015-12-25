function res = draw_score_map(poseset, scoreset)

map = zeros(500, 500, 3);
dirset = [1 0; 1 -1; 0 -1; -1 -1; -1 0; -1 1; 0 1; 1 1];
for i = 1:length(scoreset)

    pose = poseset(i,:);
    score = scoreset(i);
    
    x = pose(1);
    y = pose(2);
    th = pose(3);
    
    xi = round(x / 0.04 + 250);
    yi = round(250 - y / 0.04);
    
%     map(yi-2:yi+2, xi-2:xi+2, 1) = 255;
    map(yi, xi, 1) = 255;
    thi = round(th / (pi/4)) + 1;
%     map(yi + 0*dirset(thi,2), xi + 0*dirset(thi,1), 2) = 255;
%     map(yi + 1*dirset(thi,2), xi + 1*dirset(thi,1), 2) = round(255 * score);
%     if score < 0.5
%         score = 0;
%     end
    
    map(yi + 2*dirset(thi,2), xi + 2*dirset(thi,1), 2) = round(255 * score);
    
end

imshow(map);

end