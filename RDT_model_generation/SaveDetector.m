%
clc;
clear;
close all;
%

detectorlib = load('detectorlib.mat');
detectorlib = detectorlib.detectorlib;

dctnames = keys(detectorlib);
for i = 1:length(dctnames)
    disp(dctnames{i});
end

dynamicaldctnames = {'non_non_move_front_non', ...
                    'non_non_move_left_non', ...
                    'non_non_move_right_non'};
                
staticaldctnames = {'non_non_bed_left_table', ...
                    'non_non_bed_right_table',...
                    'non_non_chair_beside_table',...
                    'non_non_couch_front_table',...
                    'non_non_couch_right_table',...
                    'non_non_robot_left_table',...
                    'non_non_robot_right_table',...
                    'non_non_room_center_non',...
                    'non_non_wall_front_non'};
                
dynamicaldctlib = containers.Map();
for i = 1:length(dynamicaldctnames)
    dynamicaldctlib(dynamicaldctnames{i}) = detectorlib(dynamicaldctnames{i});
end

staticaldctlib = containers.Map();
for i = 1:length(staticaldctnames)
    staticaldctlib(staticaldctnames{i}) = detectorlib(staticaldctnames{i});
end

save('dynamicaldctlib', 'dynamicaldctlib');
save('staticaldctlib', 'staticaldctlib');