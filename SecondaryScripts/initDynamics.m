% Initialize dyanmics parameters and variabels for use in
%all dynamic configurable systems

%% Dynamics by hand

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
teth_length = 2;
teth_density = 1;
spring1L = 0;
spring1ks = 10;
spring1kd = .1;
spring2L = 0;
spring2ks = 10;
spring2kd = .1;
%stabilizing tether
s_teth_radius = .005;     
s_teth_length = .5;
s_teth_density = 1;
s_spring1L = 0;
s_spring1ks = 1;
s_spring1kd = .1;
s_spring2L = 0;
s_spring2ks = 1;
s_spring2kd = .1;


