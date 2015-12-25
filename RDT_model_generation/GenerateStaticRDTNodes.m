clc;
clear;
close all;
%

dctlib = load('staticaldctlib.mat');
dctlib = dctlib.staticaldctlib;
dctnames = keys(dctlib);

numpath = 5;
numtrip = 3;
footprint = load(['Footprint Set\footprint-' num2str(numpath) '-' num2str(numtrip) '.mat']);
path = footprint.footprint;

nc = length(path);
cmdlist = {};
nolist = [];

firstpathunit = path(1);
lastpathunit = path(end);

stateo = firstpathunit{1}{4};
statec = lastpathunit{1}{4};

wsf = get_state_featurebag(stateo, statec);
for nm = 1:length(dctnames)
    dct = dctlib(dctnames{nm});
    sc = score_wsf(wsf, dct);
    wsfscorelist(nm) = sc;
    disp(dctnames{nm});
    disp(sc);
end

