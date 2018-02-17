% tether length
% state 1 is the main central satellite
start_time = 0;
orbitalState_i = [6.786e6 0 0 , 0 7.67e3 0];
% in meters, m/s, n/a, rad/s
state1_i = [ 0 0 0 , 0 0 0 , 0 0 0 1 , 0.1 0 0 ]';
state2_i = [ 0 0 (teth_length+side1Dim(1)/2+centerDim(3)/2+10*eps) , 0 -.1 0 , ...
    0.5 -.5 -.5 -.5 , 0.1 0 0 ]';
state3_i = [ 0 0 -(teth_length+side1Dim(1)/2+centerDim(3)/2+10*eps), 0 .1 0 , ...
    0.5 -.5 0.5 0.5 , 0.1 0 0 ]';

state1_i_rotation = quat2dcm([state1_i(10),state1_i(7:9)']);
state2_i_rotation = quat2dcm([state2_i(10),state2_i(7:9)']);
state3_i_rotation = quat2dcm([state3_i(10),state3_i(7:9)']);

% Operating modes
OpModes = [0 0 0];
OpTimes = [0 1 2];

SeperationTime = 15;
