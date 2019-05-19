%%%% full script of values used in CU AGCS simulation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initSimulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% time
freq = 80;      % in Hz
st = 1/freq;    % sample time
homeClock = clock;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initOrbit %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r_N, v_N, B_N, UTC


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initDynamics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Cubesats CAD Blocks
%From CAD model as of beginning of Spring 2018
centerDim = [ 10.4 10.4 23.1 ]/100;
centerMass = 2.7719;
side1Dim = [ 10 10 6.124 ]/100;
side1Mass = 0.3283;
side2Dim = [ 10 10 6.124 ]/100;
side2Mass = side1Mass;

%% Tether Geometry
teth_radius = .005; % Usd only for graphics visibility
teth_radius_actual = .00025;%Real tether radius, Eric Grohn, 2017
teth_area = pi*teth_radius_actual^2;
teth_length = 1; % Set freely
teth_numLinks = 3; %Change when changing number of links in tether block

%% Tether Mechanical Properties
teth_density = 1000; % A vague guess
teth_modulus = 172e9; %[N/m^2] Dyneema: Axial modulus of elasticity 
teth_damping = 0; % TBD, damping in axial tether mode, get from manufacturer?
teth_k = teth_area*teth_modulus/teth_length;
    % Effective axial stiffness of full tether
teth_link_k = teth_k*teth_numLinks; % Discretized stiffness of link joints
teth_lo = 30; %Purpose unknown, came from initACS 

%% Linear damper
linearDamper_k = 500;
linearDamper_c = 50;
% 2018-07: Lumped axial stiffness of tether in with linear damper.
% teth_series_k is the combined stiffness. Joints between tether links are
% modeled as infinitely stiff to improve solution speed.
teth_series_k = (1/linearDamper_k + 1/teth_k)^(-1);

%% Single Link Model Tether Parameters
%%%%%%%%%%%%%%%%%%%%%%%%% OBSOLETE DYNAMICS MODEL %%%%%%%%%%%%%%%%%%%%%%%%
% spring1L = 10*eps;
% spring1ks = 10; % [N/m] Arbitrary, much slower than real, makes fast sims
% spring1kd = 1; % [Ns/m] Arbitrary, much slower than real, makes fast sims
% spring2L = 0;
% spring2ks = 10;
% spring2kd = 0.1;
% [Total length, link-wise stiffness, link-wise damping]

%% Stabilizing tether
% No longer including stabilizing tether in design per David's analysis
% s_teth_radius = .005;     
% s_teth_length = .5;
% s_teth_density = 1;
% s_spring1L = 0;
% s_spring1ks = 1;
% s_spring1kd = .1;
% s_spring2L = 0;
% s_spring2ks = 1;
% s_spring2kd = .1;

%% Kane damper
kane_radius = (10/100)/2;
kane_height = (5/100)/4;
kane_d = 0.0000002; % Needs analysis+optimization for max damping
kane_density = 1000;
kane_inertia = [8.83e-8 0 0; 0 8.83e-8 0; 0 0 1.755e-7];
kane_inertiaProducts = [kane_inertia(1,2), kane_inertia(1,3), kane_inertia(2,3)];
kane_mass = 8.85e-5;

%% Undeployed Inertias
% Total spacecraft inertia including EndSats
I_UD = [0.032808359, 0.000617048, 0.000049185; ...
    0.000617048, 0.032531573, 0.000060042; ...
    0.000049185, 0.000060042, 0.007799591]; %[I_xx, I_yy, I_zz]
invI_UD = inv(I_UD);
mass_UD = 3.5081; % Undeployed mass
COM_UD = 1e-3*[-3.1 -4.1 5.6]; % Center of mass offset from geometric center

%% Sat2 - CenterSat
I_2_B = [0.015485, 0, 0; ...
    0, 0.015670, 0; ...
    0, 0, 0.006180]; %[I_xx, I_yy, I_zz]
invI_2_B = inv(I_2_B);
mass_2 = 2.7719; % CenterSat mass
COM_2 = 1e-3*[5.4 6.3 -3.9]; % Center of mass offset from geometric center

%% Torque Coils
% Max current for each coil oriented normal to each body vector. No current
% allowed for b1 since no coil exists oriented normal to that direction.
% The maximum values were taken from old code in the TorqueCoilManagement
% block. The source of these values is unknown to Aaron, the author.
currentMax_B = [0;0.8;0.2];
sat2CoilArea = 0.8*[0.02; 0.02; 0.01];
sat2n = [0; 100; 100];
% magMomentMax_B is an estimate of the achievable magnetic moment envelope
% attainable with the coil configuration and limitations. Used in
% TorqueCoilManagement block to saturate the coil currents and torque
magMomentMax_B = sat2CoilArea.*sat2n.*currentMax_B;

%% Coil design and Power consumption
sat2WireLength = 0.8*sat2n.*[0.6; 0.6; 0.4]; % Approx path lengths
sat2WireRadius = 0.5e-3*[0.4039; 0.4039; 0.40390]; % 26 gauge
sat2WireArea = pi*sat2WireRadius.^2;
sat2WireResistivity = 1.724e-8*[1; 1; 1]; % Copper resistivity
sat2Resistance = sat2WireLength.*sat2WireResistivity./sat2WireArea;

%% Sat1 - EndSat -Z
I_1_B = [0.000456, 0, 0; ...
    0, 0.000469, 0; ...
    0, 0, 0.000719]; %[I_xx, I_yy, I_zz]
invI_1_B = inv(I_1_B);
mass_1 = 0.3283; % EndSat1 mass
COM_1 = 1e-3*[5.1 2.6 11.4]; % Center of mass offset from geometric center

%% Sat3 - EndSat +Z
I_3_B = I_1_B; % Inertia matrix
invI_3_B = inv(I_1_B);
mass_3 = mass_1; % EndSat3 mass
COM_3 = COM_1; % Center of mass offset from geometric center

%% Earth properties
m_earth = 5.972e24;
r_earth = 6378.1e3;

Earth.Px = 0;
Earth.Py = 0;
Earth.Pz = 0;
Earth.Vx = 0;
Earth.Vy = 0;
Earth.Vz = 0;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initACS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Constants
mewE = 3.986004418e14; % m^3/s/s

%% Attitude Control Gains
% maxTorqueMagnitude = 2.5e-5; % Estimate of max torque attainable, used in
% old saturation model
kp = 1;% OBSOLETE
kd = 0.5;% OBSOLETE

% Detumble Controller
% kp_UD_detumble = 1e-4; % Un-deployed detumble controller
kd_UD_detumble = 6e-3; % Un-deployed detumble controller

% Slew Controller
epsilon_UD_slew = .01;
kp_UD_slew = epsilon_UD_slew^2*.01; % Un-deployed detumble controller POSSIBLY = 0
kd_UD_slew = epsilon_UD_slew*.3; % Un-deployed detumble controller
spinAxis_B = [1 0 0]; % Intended spin axis is always in body x direction
omega_spinUp_MAG = 0.05; % Slew controller OVERRIDES magnitude of omega

% UD Spin-up Controller
epsilon_UD_spinUp = .01;
kp_UD_spinUp = epsilon_UD_spinUp^2*.05; % Un-deployed detumble controller POSSIBLY = 0
kd_UD_spinUp = epsilon_UD_spinUp*0.025; % Un-deployed detumble controller

%% Tether
% Moved to initDynamics with other tether property initializations

%% PLACEHOLDERS
counter = 0; % Purpose unknown
% km = kp;
% A = sat1.Ax;
% n = sat1.nx;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initSensors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initKalmanFilter %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% State Array: 16x1
% x
% xdot 
% xddot % Will be edited out (we might not care)
% thetadot
% q
deltaT = 0.00001; % Size increment of time (may need to be changed) 
a = deltaT/2;

% linearizePlant;
% A = [1 0 0 deltaT 0 0 0 0 0 0 0 0 0 0 0 0;
%     0 1 0 0 deltaT 0 0 0 0 0 0 0 0 0 0 0;
%     0 0 1 0 0 deltaT 0 0 0 0 0 0 0 0 0 0;
%     0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0;
%     0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0;
%     0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0;
%     0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
%     0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0;
%     0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0;
%     0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0;
%     0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
%     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];

A = eye(16,16);
B = zeros(16,1);
C = blkdiag(eye(3,3),zeros(3,3),eye(10,10));
H = C;

Q_k = zeros(16,16);
w_k = zeros(16,1);
u_k = zeros(16,1);
Z_k = zeros(16,1);
R_k = zeros(13,13);

R = R_k;

ax = [3; -2; 1]/norm([3; -2; 1]);

% a = [1; 0; 0];
% Rate = 0; % 0.1
Rate = 0.1;

phi = 0.156;
q0 = [ax*sin(phi/2); cos(phi/2)];
w0 = ax*Rate;

GM = 3.986e14;
v0 = sqrt(GM/6978000);

x0 = [0;
    0;
    6978000;
    0;
    v0;
    0; 
    0;
    0;
    0;
    w0;
    q0];

JD = 2457857.916667;
JD_GPS0 = 2457857.5;

orbit_length = 2*pi*(6978000)/v0;

% Number of leap seconds since start of GPS (current as of 2014)
UTC_leap_seconds_wrt_GPS = 0;

% GPS time at sim start [s]
sim_start_time = (JD - JD_GPS0) * 24*60*60 - UTC_leap_seconds_wrt_GPS;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initattitude %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%init torque model

%positions
[r_timeseries,v_timeseries, B_N, UTC] = initOrbit(2);
r1 = r_timeseries.data(:,1);
r2 = r_timeseries.data(:,2);
r3 = r_timeseries.data(:,3);

%GG parameters
G = 6.67*10^-11;
I1 = 0.0154852983;
I2 = 0.0156707;
I3 = 0.00618;
M_E = 5.972*10^24;

%MT parameters
M1 = 0.00506;
M2 = 0.00509;
M3 = 0.00447;

%AD parameters
p = 8.43*10^-12;
cd = 2.2;
Ab = 0.09;
rcp1 = -0.0031;
rcp2 = -0.0041;
rcp3 = 0.0056;

%SRP parameters
flux = 1366;
c = 3*10^8;
q = 0.6;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%% configFirst %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


