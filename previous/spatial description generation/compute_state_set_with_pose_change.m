function [featurebagset, poselist]= compute_state_set_with_pose_change(ni, stateset)

%the states are time sequence
poselist = [];
%extract OR entity; The OR entity keep the same with the alternate CR entities:
state1 = stateset{1};
ORpose = state1{2};
ORv = get_robot_entity(ORpose);
ORdir = ORpose(3);
ORname = 'OR';

OR.vec = ORv;
OR.dir = ORdir;
OR.name = ORname;

%get the room information
roomname = '';
if strcmp(ni{1}, 'non') == 1
    if ORpose(2) > 1.6
        roomname = 'bedroom';   
    elseif ORpose(2) < -1.5
        roomname = 'livingroom';
    else
        roomname = 'hallway';
    end 
    
end

%world state from 1 to end
nthSTATE = 1;
featurebagset = {};

state = stateset{length(stateset)};

%% get entities
entitieslist = {OR};
entitiesnamelist = {OR.name};
golist = state{1};
rpose = state{2};

Rposelist = [];
for x = ORpose(1)-2:ORpose(1)+2
    for y = ORpose(2)-2:ORpose(2)+2
        for th = 0:pi/4:pi*7/4
            Rposelist = [Rposelist; x y th];
        end
    end
end
poselist = Rposelist;

for n = 1:size(Rposelist, 1)
    %extract CR entity
    [v dir name] = get_robot_entity(Rposelist(n,:));
    CR.vec = v;
    CR.dir = dir;
    CR.name = 'CR';
    entitieslist{end + 1} = CR;
    entitiesnamelist{end + 1} = CR.name;

    %extract GO entities
    for i = 1:length(golist)
        if golist(i) > 0
            [v dir name] = get_go_entity(golist(i));
            MO.vec = v;
            MO.dir = dir;
            MO.name = name;

            dist2CR = get_distance_between_two_entities(CR, MO);
            [dirhg disthg] = get_spatial_relation_B_to_A(CR.vec, MO.vec, CR.dir);
            [outdirw indirw] = direction_weights(dirhg);
            if dist2CR < 2 && outdirw(1) > 0   
                entitieslist{end + 1} = MO;
                entitiesnamelist{end + 1} = name;
            end
        end
    end

    %extract Wall entities
    if length(roomname) > 0 && strcmp(roomname, 'hallway') ~= 1
        [v dir name] = get_wall_entity(roomname);
        W.vec = v;
        W.dir = dir;
        W.name = name;
        entitieslist{end + 1} = W;
        entitiesnamelist{end + 1} = name;
    end

    %extract Room entities
    [v dir name] = get_wall_entity('bedroom');
    Ws.vec = v;
    Ws.dir = dir;
    Ws.name = 'bedroom';
    entitieslist{end + 1} = Ws;
    entitiesnamelist{end + 1} = Ws.name;

    [v dir name] = get_wall_entity('livingroom');
    Ws.vec = v;
    Ws.dir = dir;
    Ws.name = 'livingroom';
    entitieslist{end + 1} = Ws;
    entitiesnamelist{end + 1} = Ws.name;

    %select kept entities
    niroom = '';
    niobj = '';
    niref = '';
    nidir = '';
    nitar = '';

    if strcmp(ni{1}, 'non') == 0
        niroom = ni{1};
    end

    if strcmp(ni{3}, 'non') == 0
        niref = ni{3};
    end

    if strcmp(ni{5}, 'non') == 0
        nitar = ni{5};
    end

    relatedentities = {OR, CR};

    for i = 1:length(entitieslist)
        ent = entitieslist{i};
        if strcmp(ent.name, niroom) == 1
            relatedentities{end+1} = ent;
        end

        if strcmp(ent.name, niref) == 1
            %ent.name = 'ref';
            relatedentities{end+1} = ent;
        end

        if strcmp(niref, 'room') == 1
            if strcmp(ent.name, 'wall') == 1
                %ent.name = 'ref';
                relatedentities{end+1} = ent;
            end           
        end

        if strcmp(ent.name, nitar) == 1
            %ent.name = 'tar';
            relatedentities{end+1} = ent;
        end
    end

    %% compute the spatial relation between entities in entities list
    featurebag = get_spatial_relations_in_entities_list(relatedentities);
    featurebagset{end+1} = featurebag;  
disp(n);
pause(0.01);
end





end