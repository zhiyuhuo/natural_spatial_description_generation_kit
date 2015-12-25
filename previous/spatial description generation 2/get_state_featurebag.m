function featurebag = get_state_featurebag(stateo, statec)

%the states are time sequence

%extract OR entity; The OR entity keep the same with the alternate CR
%entities:
ORpose = stateo{2};
ORv = get_robot_entity(ORpose);
ORdir = ORpose(3);
ORname = 'OR';

OR.vec = ORv;
OR.dir = ORdir;
OR.name = ORname;

%get the room information
roomname = '';
if ORpose(2) > 1.6
    roomname = 'bedroom';   
elseif ORpose(2) < -1.5
    roomname = 'livingroom';
else
    roomname = 'hallway';
end 
    
%% get current state entities
entitieslist = {OR};
entitiesnamelist = {OR.name};

golist = statec{1};
rpose = statec{2};

%extract CR entity
[v dir name] = get_robot_entity(rpose);
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
        if (dist2CR < 1.5 && outdirw(1) > outdirw(3)) || (dist2CR < 1 && outdirw(1) > 0)
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

featurebag = get_spatial_relations_in_entities_list(entitieslist);

end