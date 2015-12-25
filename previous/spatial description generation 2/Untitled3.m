clc;
clear;
close all;
%

dctlib = load('detectorlib.mat');
dctlib = dctlib.detectorlib;
dctnames = keys(dctlib);

numpath = 5;
numtrip = 3;
footprint = load(['Footprint Set\footprint-' num2str(numpath) '-' num2str(numtrip) '.mat']);
path = footprint.footprint;

nc = length(path);
cmdlist = {};
nolist = [];

while nc > 1
    
    framec = path{nc};
    statec = framec{4};
    disp('------------');
    disp(statec{2});
    scorelast = 1;
    for no = nc-1: -1 : 1
        score = 0;
        frameo = path{no};
        stateo = frameo{4};
        wsf = get_state_featurebag(stateo, statec);
        wsfscorelist = zeros(1, length(dctnames));

        for nm = 1:length(dctnames)
            dct = dctlib(dctnames{nm});
            wsfscorelist(nm) = score_wsf(wsf, dct);
        end

        [wsfscore b] = max(wsfscorelist);
        posescore = score_pose_change(stateo{2}, statec{2});
        score = wsfscore * posescore;
        disp([num2str(no), ': ', dctnames{b}, ' ', num2str(wsfscore), ' ', num2str(posescore), ' --- ', num2str(score)]);
        disp(stateo{2});
        
        if score < scorelast && score < 0.75
            nc = no;
            disp(['--: ' num2str(no), ': ', dctnames{b}, ' ', num2str(wsfscore), ' ', num2str(posescore), ' --- ', num2str(score)]);
            disp(stateo{2});
            disp('--: ');
            break;
        end
        scorelast = score;
    end
    
end