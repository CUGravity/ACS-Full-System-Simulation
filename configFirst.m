
% 2 is the main central satellite
state1_i = [ 6.7e6 0 0 , 0 7.6e3 0 , 0 0 0 1 , 0 0 1 ]';
state2_i = [ 6.7e6 0 0 , 0 7.6e3 0 , 0 0 0 1 , 0 1 0 ]';
state3_i = [ 6.7e6 0 0 , 0 7.6e3 0 , 0 0 0 1 , 1 0 0 ]';

solarpanel1_i = [ 0 0 pi/2 0 ];
solarpanel2_i = [ 0 0 pi/2 0 ];

% Operating modes

OpModes = [0 0 0];
OpTimes = [0 10 20];

SeperationTime = 15;
SolarDeployTime = 10;