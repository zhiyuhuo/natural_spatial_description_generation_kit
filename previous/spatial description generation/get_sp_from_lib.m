function res = get_sp_from_lib(ni, spname, idx)

dirset = ls('feather sets for commands');
for n = 1 : (size(dirset, 1)-2)
    cmdspcategories = load(sprintf('feather sets for commands/c%d.mat', n));
    if strcmp(ni, cmdspcategories.cmdN) == 1
        spcategoryset = cmdspcategories.spcategoryset;
        for j = 1:length(spcategoryset)
            spcategory = spcategoryset{j};
            if ~isnumeric(spcategory)
                if strcmp(spname, spcategory{1}{1})
                    for k = 1:length(spcategory)
                        res = spcategory{idx};
                        return;
                    end
                end
            end
        end
    end
end


end