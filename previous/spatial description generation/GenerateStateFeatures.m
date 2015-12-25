clear;
close all;
clc;

lib = {};
worldstatedirset = ls(sprintf('worldstate/'));
for n = 1:10 
    for nn = 3:size(worldstatedirset, 1)
        worldstatedir = worldstatedirset(nn, 1:length(num2str(n))+6);
        if ~isempty(strfind(worldstatedir, [num2str(n), '-']))
            fname = ['worldstate/' worldstatedir];
            data = load(fname);
            bagset = data.bagset;
            for i = 1:length(bagset)
                bag = bagset(i);
                disp([n i]);
                [ni featurebagset labelv keystates] = generate_training_features_from_a_bag(bag);
                lib{end+1} = {ni, featurebagset, labelv, keystates};
            end
        end
    end
end

fname = sprintf('features.mat', n);
save(fname, 'lib');