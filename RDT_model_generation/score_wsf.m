function res = score_wsf(wsf, dct)

scorearray = zeros(1, length(dct));
for i = 1:length(dct)
    for j = 1:length(wsf)
        namedctsrv = [dct{i}.nameA '_' dct{i}.nameB];
        namewsfsrv = [wsf{j}.nameA '_' wsf{j}.nameB];
        if strcmp(namedctsrv, namewsfsrv) == 1
            r = score_srv(wsf{j}, dct{i});
            scorearray(i) = r;
            break;
        end
    end
end

res = min(scorearray);

end