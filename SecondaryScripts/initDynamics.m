%% File Description
%{
Team:       CU Artificial Gravity CubeSat
Updated:    2018-07
Update by:  Aaron Sandoval

Description:
Initializes variables involved in the dynamics blocks, including
dimensions, mechanical properties, mass properties, and torque coil
properties
%}

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
I_mom_ROW = [0.032808359 0.032531573 0.007799591]; %[I_xx, I_yy, I_zz]
I_prod_ROW = [0.000617048 0.000049185 0.000060042]; %[I_xy, I_xz, I_yz]
I_prod = [0 I_prod_ROW(1) I_prod_ROW(2); 0 0 I_prod_ROW(3); 0 0 0];
I_prod = I_prod + I_prod';
I_UD = diag(I_mom_ROW) + I_prod; % Inertia matrix
invI_UD = inv(I_UD);
mass_UD = 3.5081; % Undeployed mass
COM_UD = 1e-3*[-3.1 -4.1 5.6]; % Center of mass offset from geometric center

%% Sat2 - CenterSat
I_2_mom_ROW = [0.015485 0.015670 0.006180]; %[I_xx, I_yy, I_zz]
I_2_prod_ROW = [0 0 0]; %[I_xy, I_xz, I_yz]
I_2_prod = [0 I_2_prod_ROW(1) I_2_prod_ROW(2); 0 0 I_2_prod_ROW(3); 0 0 0];
I_2_prod = I_2_prod + I_2_prod';
I_2_B = diag(I_2_mom_ROW) + I_2_prod; % Inertia matrix
invI_2_B = inv(I_2_B);
mass_2 = 2.7719; % CenterSat mass
COM_2 = 1e-3*[5.4 6.3 -3.9]; % Center of mass offset from geometric center

%% Torque Coils
% Max current for each coil oriented normal to each body vector. No current
% allowed for b1 since no coil exists oriented normal to that direction.
% The maximum values were taken from old code in the TorqueCoilManagement
% block. The source of these values is unknown to Aaron, the author.
currentMax_B = [0;0.8;0.2];
sat2.nx = 0;
sat2.ny = 100;
sat2.nz = 100;
sat2.Ax = 0.02;
sat2.Ay = 0.02;
sat2.Az = 0.01;
sat2CoilArea = 0.8*[sat2.Ax; sat2.Ay; sat2.Az];
sat2n = [sat2.nx; sat2.ny; sat2.nz];
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
I_1_mom_ROW = [0.000456 0.000469 0.000719]; %[I_xx, I_yy, I_zz]
I_1_prod_ROW = [0 0 0]; %[I_xy, I_xz, I_yz]
I_1_prod = [0 I_1_prod_ROW(1) I_1_prod_ROW(2); 0 0 I_1_prod_ROW(3); 0 0 0];
I_1_prod = I_1_prod + I_1_prod';
I_1_B = diag(I_1_mom_ROW) + I_1_prod; % Inertia matrix
invI_1_B = inv(I_1_B);
mass_1 = 0.3283; % EndSat1 mass
COM_1 = 1e-3*[5.1 2.6 11.4]; % Center of mass offset from geometric center

%% Sat3 - EndSat +Z
I_3_mom_ROW = I_1_mom_ROW;
I_3_prod_ROW = I_1_prod_ROW;
I_3_prod = I_1_prod;
I_3_B = diag(I_1_mom_ROW) + I_1_prod; % Inertia matrix
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
