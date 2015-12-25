function [v dir name] = get_robot_entity(pose)
v = make_obj_vector(pose(1), pose(2), 0.3, 0.3);
dir = pose(3);
name = 'robot';