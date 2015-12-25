clc;
clear;
close all;
%

numpath = 5;
numtrip = 3;
footprint = load(['Footprint Set\footprint-' num2str(numpath) '-' num2str(numtrip) '.mat']);
path = footprint.footprint;
immap = imread('maproom.bmp');
% imshow(immap);

for n = 1:length(path)
    fpt = path{n};
    robostate = fpt{4};
    pose = robostate{2};
    xy = pose([1 2]);
    
    x = xy(1);
    y = xy(2);
    
    u = round((x + 10) / 0.04);
    v = round((10 - y) / 0.04);
    
    for i = -2:2
        immap(v+i, u, 1) = 255;
        immap(v, u+i, 1) = 255;
    end
end

imshow(immap);
