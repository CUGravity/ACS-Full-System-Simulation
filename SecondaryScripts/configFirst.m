% tether length
% state 1 is the main central satellite
start_time = 0;
% orbitalState_i = [6.786e6 0 0 , 0 7.67e3 0];
% in meters, m/s, n/a, rad/s


%% Attitude ICs
w0_N = 1e-1*[1 0 0];
% w0_N = 1*1e-2*[4.825    -0.421    0.321];
% q4_0 = [0.4297    -0.3163    0.2303    0.8667]';
% q4_0 = [.0 0 -.005+sqrt(2)/2 sqrt(2)/2+.005]';
% q4_0 = [0.1 0.2 -0.15 .9]';
% q4_0 = [sqrt(2)/2 .02 .02 sqrt(2)/2-.02]';
q4_0 = [0 0 0 1]';

%% Attitude Commands
% q4_cmd_init: Initial attitude command. If omega_cmd_N == 0, then this is
% a static attitude regulation command. Else, q4_cmd is updated with omega.
% q4_cmd_init = [sqrt(2)/2 0 0 sqrt(2)/2]';
q4_cmd_init = [0 0 0 1]';
% q4_cmd_init = [4 -3 4 .2]';
% q4_cmd_init = [1 -3 -4 .2]';
omega_cmd_N = 1*[1 0 0]';
Q_cmd_N_B = quat2dcm([q4_cmd_init(4); q4_cmd_init(1:3)]')';

%% Simulink IC Variables
% Units: meters, m/s, UNITLESS, rad/s
state1_i = [ 0 0 0 , 0 0 0 , q4_0', w0_N]'; % MidSat, NOT ENDSAT (violates convention)
state2_i = [ 0 0 (teth_length+side1Dim(1)/2+centerDim(3)/2+10*eps) , 0 -.1 0 , ...
    0.5 -.5 -.5 -.5 , w0_N ]';
state2_i(4:6) = cross(state2_i(11:13), state2_i(1:3));
state3_i = [ 0 0 -(teth_length+side1Dim(1)/2+centerDim(3)/2+10*eps), 0 .1 0 , ...
    0.5 -.5 0.5 0.5 , w0_N ]';
state3_i(4:6) = cross(state3_i(11:13), state3_i(1:3));

state1_i_rotation = quat2dcm([state1_i(10),state1_i(7:9)']);
state2_i_rotation = quat2dcm([state2_i(10),state2_i(7:9)']);
state3_i_rotation = quat2dcm([state3_i(10),state3_i(7:9)']);

% Operating modes
OpModes = [0 0 0];
OpTimes = [0 1 2];

SeperationTime = 15;
