function res = read_navigation_instruction(cmdbuck)

r = {};
for i = 1:length(cmdbuck)
    c = [];
    linecell = {};
    tline = cmdbuck{i};
    L = length(tline);
    k = 1;
    while (k <= L)
        if strcmp(tline(k), ' ') == 1
            k = k + 1;
            linecell{end+1} = c;
            c = [];
        else
            c = [c tline(k)];
            k = k + 1;
        end
    end
    if length(c) > 0
        linecell{end+1} = c;
    end
    r{end+1} = linecell;
end

blank = [];
for i = 1:length(r)
    c = r{i};
    l = 0;
    for j = 1:length(c)
        l = l + length(c{j});
    end
    if l == 0
        blank(end+1) = i;
    end
end

res = r(setdiff([1:length(r)], blank));

end