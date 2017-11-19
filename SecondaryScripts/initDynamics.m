% Initialize dyanmics parameters and variabels for use in
%all dynamic configurable systems


%% Single Link Simscape Model
% Cubesats
centerDim = [ 10 10 20 ]/100;
centerMass = 4*(2/3);
side1Dim = [ 10 10 5 ]/100;
side1Mass = 4*(0.5/3);
side2Dim = [ 10 10 5 ]/100;
side2Mass = 4*(0.5/3);

% Tether
teth_radius = .005;
teth_length = 1;
teth_numLinks = 6;
teth_density = 1;
spring1L = 10*eps;
spring1ks = 10;
spring1kd = 0.1;
spring2L = 0;
spring2ks = 10;
spring2kd = 0.1;

% Stabilizing tether
s_teth_radius = .005;     
s_teth_length = .5;
s_teth_density = 1;
s_spring1L = 0;
s_spring1ks = 1;
s_spring1kd = .1;
s_spring2L = 0;
s_spring2ks = 1;
s_spring2kd = .1;

% Kane damper
kane_radius = (10/100)/2;
kane_height = (5/100)/4;
kane_d = 0.1;
kane_density = 1000;

% Earth properties
m_earth = 5.972e24;
r_earth = 6378.1e3;

Earth.Px = 0;
Earth.Py = 0;
Earth.Pz = 0;
Earth.Vx = 0;
Earth.Vy = 0;
Earth.Vz = 0;
