clc;
clear;
close all;
%

worldstatedirset = ls(sprintf('worldstate/'));
for n = 1:10 
    for nn = 3:size(worldstatedirset, 1)
        worldstatedir = worldstatedirset(nn, 1:length(num2str(n))+6);
        if ~isempty(strfind(worldstatedir, [num2str(n), '-']))
            footprint = {};
            fname = ['worldstate/' worldstatedir];
            tag = fname(12:end-4);
            data = load(fname);
            bagset = data.bagset;
            for i = 1:length(bagset)
                bag = bagset(i);
                [ni featurebagset labelv keystates] = generate_training_features_from_a_bag(bag);
                disp([n i]);
                for j = 1:length(featurebagset)
                    footprint{end+1} = {ni, featurebagset{j}, labelv(j), keystates{j}};
                end
            end
            routefilename = sprintf('Footprint Set/footprint-%s.mat', tag);
            save(routefilename, 'footprint');
        end
    end
end



