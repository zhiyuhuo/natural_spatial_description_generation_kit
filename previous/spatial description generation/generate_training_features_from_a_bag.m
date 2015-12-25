function [ni featureset labelv keystates] = generate_training_features_from_a_bag(bag)

keystates = {};
bag = bag{1};
n = bag{1};
ni = cell(1, 5);
for i = 1:5
    str = n{i};
    if strcmp(str, 'N/A') == 1
        str = 'non';
    end
    ni{i} = str;
end
if strcmp(ni{5}(1:3), 'N/A') == 1
	ni{5} = 'non';
else
    %ni{5} = ni{5}(1:end-1);
end
disp(ni);
worldstate = bag{2};

stateset = {worldstate{1}};
for i = 2:length(worldstate)
    laststate = stateset{end};
    currstate = worldstate{i};
    if length(currstate{1}) ~= length(laststate{1}) || norm(currstate{1}-laststate{1}) ~= 0 || norm(currstate{2}-laststate{2}) ~= 0
        stateset{end+1} = worldstate{i};
    end
end
% stateset = {stateset{1}, stateset{length(stateset)}};

stateset = worldstate;

[featureset labelv] = get_worldstate_feature_set(ni, stateset);
keystates = stateset;

end