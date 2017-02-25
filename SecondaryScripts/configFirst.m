% tether length
teth_length = 1; % meters
% state 1 is the main central satellite
orbitalState_i = [6.7e6 0 0 , 0 7.6e3 0];
% in meters, m/s, n/a, rad/s
state1_i = [ 0 0 0 , 0 0 0 , 0 0 0 1 , 1 0 0 ]';
state2_i = [ 0 0 1 , 0 0 0 , 0 0 0 1 , 0 0 0 ]';
state3_i = [ 0 0 -1 , 0 0 0 , 0 0 0 1 , 0 0 0 ]';

state1_i_rotation = quat2dcm([state1_i(10),state1_i(7:9)']);
state2_i_rotation = quat2dcm([state2_i(10),state2_i(7:9)']);
state3_i_rotation = quat2dcm([state3_i(10),state3_i(7:9)']);

% Operating modes
OpModes = [0 0 0];
OpTimes = [0 2 4];

SeperationTime = 15;
SolarDeployTime = 10;