function res = get_spatial_relations_in_entities_list(relatedentities)
%%% in this function the features are represented by graphics
spatialfeatureset = {};
entitieslist = relatedentities;
%%%%%   -   One to One  -   Feature%%%%%
%% robot rotation
dirOR = 0;
dirCR = 0;
robotrotation = 0;
for i = 1:length(entitieslist)
    if strcmp(entitieslist{i}.name, 'OR') == 1
        dirOR = entitieslist{i}.dir;
    elseif strcmp(entitieslist{i}.name,'CR') == 1
        dirCR = entitieslist{i}.dir;
    end
end
robotrotation = dirCR - dirOR;
if robotrotation < -pi
    robotrotation = robotrotation + 2 * pi;
elseif robotrotation > pi
    robotrotation = robotrotation - 2 * pi;
end
f.nameA = 'rotation';
f.nameB = 'rotation';
f.spdir = [robotrotation];
f.spdist = 0;
f.outdirw = [robotrotation];
f.indirw = 0;
f.distw = 0;

spatialfeatureset{end + 1} = f;

for i = 1:length(entitieslist)
    entA = entitieslist{i};
    if entA.dir >= 0
        for j = 1:length(entitieslist)
            if i ~= j
                entB = entitieslist{j};
                
                if strcmp(entA.name, 'bed') == 1 && strcmp(entB.name, 'table') == 1
                    huozhiyu = 1;
                end
                
                [dirhg disthg] = get_spatial_relation_B_to_A(entA.vec, entB.vec, entA.dir);
                f.nameA = entA.name;
                f.nameB = entB.name;
                
                f.spdir = dirhg;
                f.spdist = disthg;
                % f.outdirw = outside_direction_weights(dirhg);
                % f.indirw = inside_direction_weights(dirhg);
                [outdirw indirw] = direction_weights(dirhg);
                f.outdirw = outdirw;
                f.indirw = indirw;
                f.distw = distance_weight(disthg);
                
                if strcmp(entA.name, 'bed') == 1 && strcmp(entB.name, 'table') == 1
                    huozhiyu = 1;
                end
                
                if norm(f.indirw) > 0
                end
                
                spatialfeatureset{end+1} = f;
            end
        end
    end
end


res = spatialfeatureset;
end