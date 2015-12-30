function res = get_rdt_from_content(chunkname, chunkcontent, namelist, contentlist, rdtlist)

s1 = find(strcmp(namelist, chunkname) == 1);
s2 = find(strcmp(contentlist, chunkcontent) == 1);
s = intersect(s1, s2);

if ~isempty(s)
    srdt = rdtlist{s};
    res = srdt;
else
    res = '';
end

end