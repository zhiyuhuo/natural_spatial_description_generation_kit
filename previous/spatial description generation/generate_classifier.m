function res = generate_classifier(spsetpos, spsetneg)

rotation = 0;
spdir = zeros(1, 362);
spdist = zeros(1, 100);
name = '';

if ~isnumeric(spsetpos{1})
    for i = 1:length(spsetpos)
        sp = spsetpos{i};
        spdir = spdir + sp.spdir;
        spdist = spdist + sp.spdist;
    end
    spdir = spdir / length(spsetpos);
    spdist = spdist / length(spsetpos);
    name = [sp.nameA '_' sp.nameB];
        
    res = {name, {spdir, spdist}};
else
    for i = 1:length(spsetpos)
        sp = spsetpos{i};
        rotation = rotation + sp;
    end
    rotation = rotation / length(spsetpos);   
    name = 'rotation';
    
    res = {name, rotation}
end

end