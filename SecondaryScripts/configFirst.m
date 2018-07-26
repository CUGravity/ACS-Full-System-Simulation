%% File Description
%{
Team:       CU Artificial Gravity CubeSat
Updated:    2018-07
Update by:  Aaron Sandoval

Description:
Sets initial conditions for attitude states and commands. Not yet capable
of calculating arbitrary deployed-mode IC sets from a given MidSat quat.
All terms in ECI coordinates.
%}
start_time = 0;

%% Attitude ICs
%{
Sets initials state targets for all satellites. Be careful with changing
values using deployed dynamics. Simulation is currently only setup to
handle
q4_0 = [0 0 0 1]
w0_N in [1 0 0] direction
Undeployed dynamics can handle any ICs.
%}
w0_N = 1e-2*[2 0 0];
q4_0 = [0 0 0 1]';

%% Attitude Commands
%{
This section defines the commanded attitude. The switch case must be
manually changed depending on the ACS state. This must be automated to
change with the state machine later.

q4_cmd_init: Initial attitude command. If omega_cmd_N == 0, then this is
% a static attitude regulation command. Else, q4_cmd is updated with omega.
Case Control:
1:  Static attitude commands (detumble mode, other att. regulation)
2:  Non-zero spin command (pointing, spin-up)
%}
att_cmd_case = 1;
switch(att_cmd_case)
    case 1 % Attitude regulation, omega_cmd = 0
        q4_cmd_init = [0 0 0 1]';
        omega_cmd_N = [0 0 0]';
    case 2 % Non-zero commanded spin
%         q_cmd is dependent on and must be consistent with spinAxis_B and
%         omega_cmd_N. This case defines an inital q_cmd such that the spin
%         axis is aligned in the commanded direction
        omega_cmd_N = 1e-1*[1 1 -.6]'; % MODIFY DEPENDING ON ACS STATE
        q4_cmd_init = dcm2quat(SingleVectorAlignDCM(...
            omega_cmd_N, spinAxis_B.').').';
        q4_cmd_init = [q4_cmd_init(2:4); q4_cmd_init(1)];
end
Q_cmd_N_B = quat2dcm([q4_cmd_init(4); q4_cmd_init(1:3)]')';

%% Simulink IC Variables
% Units: meters, m/s, UNITLESS, rad/s
state1_i = [ 0 0 0 , 0 0 0 , q4_0', w0_N]'; % MidSat, NOT ENDSAT (violates convention)
q4_0_Cube2 = [0.5 -.5 -.5 -.5]'; % Only compatible with deployed q4_0=[0 0 0 1]
q4_0_Cube3 = [0.5 -.5 0.5 0.5]'; % Only compatible with deployed q4_0=[0 0 0 1]
state2_i = [ 0 0 (teth_length+side1Dim(1)/2+centerDim(3)/2+10*eps) , 0 -.1 0 , ...
    q4_0_Cube2' , w0_N ]';
state2_i(4:6) = cross(state2_i(11:13), state2_i(1:3));
state3_i = [ 0 0 -(teth_length+side1Dim(1)/2+centerDim(3)/2+10*eps), 0 .1 0 , ...
    q4_0_Cube3' , w0_N ]';
state3_i(4:6) = cross(state3_i(11:13), state3_i(1:3));

state1_i_rotation = quat2dcm([state1_i(10),state1_i(7:9)']);
state2_i_rotation = quat2dcm([state2_i(10),state2_i(7:9)']);
state3_i_rotation = quat2dcm([state3_i(10),state3_i(7:9)']);

% Operating modes
OpModes = [0 0 0];
OpTimes = [0 1 2];

SeperationTime = 30000; % Controls when FC changes from UD to Dep algorithms
