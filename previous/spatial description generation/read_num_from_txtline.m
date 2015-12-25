function res = read_num_from_txtline(tline)

c = [];
linecell = {};
L = length(tline);
i = 1;
res = [];
while (i <= L)
    if strcmp(tline(i), ' ') == 1
        i = i + 1;
        res = [res str2num(c)];
        c = [];
    else
        c = [c tline(i)];
        i = i + 1;
    end
end
res = [res str2num(c)];

end