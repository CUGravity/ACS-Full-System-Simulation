% Initialize dyanmics parameters and variabels for use in
%all dynamic configurable systems


% Simscape Model
%% Cubesats Solid Blocks
% centerDim = [ 10 10 20 ]/100;
% centerMass = 4*(2/3);
% side1Dim = [ 10 10 5 ]/100;
% side1Mass = 4*(0.5/3);
% side2Dim = [ 10 10 5 ]/100;
% side2Mass = 4*(0.5/3);

%% Cubesats CAD Blocks
%From CAD model as of beginning of Spring 2018
centerDim = [ 10.4 10.4 23.1 ]/100;
centerMass = 2.7719;
side1Dim = [ 10 10 6.124 ]/100;
side1Mass = 0.3283;
side2Dim = [ 10 10 6.124 ]/100;
side2Mass = 0.3283;

%% Tether Geometry
teth_radius = .005; %Eric Grohn, 2017 says 0.00025 m
teth_radius_actual = .00025;
teth_area = pi*teth_radius_actual^2;
teth_length = 1;
teth_length_dyn = [0 teth_length]; %Debugging, tether length timeseries
teth_numLinks = 3; %Change when changing number of links in tether block

%% Tether Mechanical Properties
teth_density = 1; % Arbitrary?
teth_modulus = 172e9; %[N/m^2] Dyneema: Axial modulus of elasticity 
teth_damping = 0; % Assume that majority of damping occurs in linear damper
teth_k = teth_area*teth_modulus/teth_length;
    % Effective stiffness of full tether, formerly set to arbitrary 10 N/m
teth_link_k = teth_k*teth_numLinks; % Discretized stiffness of link joints
teth_lo = 30; %Purpose unknown, came from initACS 

%% Single Link Model Tether Parameters
spring1L = 10*eps;
spring1ks = 10; % [N/m] Arbitrary, much slower than real, makes fast sims
spring1kd = 1; % [Ns/m] Arbitrary, much slower than real, makes fast sims
spring2L = 0;
spring2ks = 10;
spring2kd = 0.1;
% [Total length, link-wise stiffness, link-wise damping]

%% Stabilizing tether
s_teth_radius = .005;     
s_teth_length = .5;
s_teth_density = 1;
s_spring1L = 0;
s_spring1ks = 1;
s_spring1kd = .1;
s_spring2L = 0;
s_spring2ks = 1;
s_spring2kd = .1;

%% Kane damper
kane_radius = (10/100)/2;
kane_height = (5/100)/4;
kane_d = 0.1;
kane_density = 1000;

%% Earth properties
m_earth = 5.972e24;
r_earth = 6378.1e3;

Earth.Px = 0;
Earth.Py = 0;
Earth.Pz = 0;
Earth.Vx = 0;
Earth.Vy = 0;
Earth.Vz = 0;
