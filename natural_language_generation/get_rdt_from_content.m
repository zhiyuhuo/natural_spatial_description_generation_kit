function res = get_rdt_from_content(chunkname, chunkcontent, namelist, contentlist, rdtlist)

s1 = find(strcmp(namelist, chunkname) == 1);
s2 = find(strcmp(contentlist, chunkcontent) == 1);

if isempty(s2)
    scorelist = zeros(length(contentlist), 1);
    for i = 1:length(contentlist)
        scorelist(i) = levenshtein(chunkcontent, contentlist{i});
    end
    [scoremin imin] = min(scorelist);
    s2 = imin;
end

s = intersect(s1, s2);
if strcmp(chunkname, '#text') == 1
    s = s2;
end

if ~isempty(s)
    srdt = rdtlist{s};
    res = srdt;
else
    res = '';
end

end