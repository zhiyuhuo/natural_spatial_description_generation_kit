clc;
clear;
close all;
%
for n = 1:10
    
%n = ;
taskdirset = ls(sprintf('Human Demo Rec 2/%d/', n));
for T = 3:size(taskdirset, 1)
    timedir = taskdirset(T,:);
    flcmd = sprintf('Human Demo Rec 2/%d/%s/cmd - %d.out', n, timedir, n);
    flfr = sprintf('Human Demo Rec 2/%d/%s/fr - %d.out', n, timedir, n);
    flpose = sprintf('Human Demo Rec 2/%d/%s/pose - %d.out', n, timedir, n);

    bagset = {};
    
    cmdbuck = {};
    frbuck = {};
    posebuck = {};

    % read cmd file
    fid = fopen(flcmd);
    tline = fgets(fid);
    while ischar(tline)
        if length(tline) > 2
            cmdbuck{end+1} = tline;
        end
        disp(tline);
        tline = fgets(fid);
    end
    fclose(fid);
    cmdset = read_navigation_instruction(cmdbuck);

    % read fr file
    fid = fopen(flfr);
    tline = fgets(fid);
    while ischar(tline)
        frlist = read_num_from_txtline(tline);
        frbuck{end+1} = frlist;
        disp(tline)
        tline = fgets(fid);
    end
    fclose(fid);

    % read pose file
    fid = fopen(flpose);
    tline = fgets(fid);
    while ischar(tline)
        poselist = read_num_from_txtline(tline);
        posebuck{end+1} = poselist;
        disp(tline)
        tline = fgets(fid);
    end
    fclose(fid);

    bag = {};
    name = {};
    currcmd = cmdset{1};
    indexset = [];
    head = 0;
    tail = 0;
    cmdindexset = [];

    i = 1;
    while strcmp(currcmd, 'f') ~= 1
        if isempty(currcmd)
            continue;
        end

        if length (currcmd) > 3
            head = i;
        elseif strcmp (currcmd{1}, 'r') == 1
            tail = i;
            indexset = [indexset; [head tail]];
        end

        i = i + 1;
        currcmd = cmdset{i};
    end

    for i = 1:size(indexset, 1)
        head = indexset(i, 1);
        cmd = cmdset{head};
        tail = indexset(i, 2);
        worldstate = {};
        for j = head:tail
            worldstate{end + 1} = {frbuck{j}, posebuck{j}};
        end
        bag = {cmd, worldstate};
        bagset{end+1} = bag;
    end
    
    fname = sprintf('worldstate/%d-%d.mat', n, T);
    save(fname, 'bagset');
end

end