
% COORDINATES SYSTEM: Z IS ALLIGNED ALONG THE TETHER DIRECTION

%% Constants
mewE = 3.986004418e14; % m^3/s/s

%% Controller
kp = 1;
kd = 1;

%% Tether
teth_k = 10; % Effective spring constant
teth_lo = 30; 

%% Connected full system
zl = 3*0.01; %2U
xyl = 1*0.01; %2U
m = 4; % in kg
I_undeployed=[m*(zl^2+xyl^2)/12 0 0 ; ...
        0 m*(zl^2+xyl^2)/12 0 ; ...
        0 0 m*(2*xyl^2)/12 ] + 1e-6*(rand(3)-0.5);
I_undeployed = inv(I_undeployed);

%% Connected full system - SOLAR PANEL DEPLOYED
zl = 3*0.01; %2U
xyl = 1*0.01; %2U
m = 4;
I_solar=[m*(zl^2+xyl^2)/12 0 0 ; ...
        0 m*(zl^2+xyl^2)/12 0 ; ...
        0 0 m*(2*xyl^2)/12 ] + 1e-6*(rand(3)-0.5);
I_solar = I_solar.*[1.5 0 0 ; 0 1.5 0 ; 0 0 0.9 ];
I_solar_inv = inv(I_solar);

%% Sat2 - Middle Central Satellite
zl = 2*0.01; %2U
xyl = 1*0.01; %2U
m = 4*2/3;
I_2=[m*(zl^2+xyl^2)/12 0 0 ; ...
        0 m*(zl^2+xyl^2)/12 0 ; ...
        0 0 m*(2*xyl^2)/12 ] + 1e-6*(rand(3)-0.5);
I_2_inv = inv(I_2);

sat2.nx = 100;
sat2.ny = 100;
sat2.nz = 100;
sat2.Ax = 0.02;
sat2.Ay = 0.02;
sat2.Az = 0.01;

%% Sat1 - Side Satellite
zl = 0.5*0.01; %2U
xyl = 1*0.01; %2U
m = 4*1/6;
I_1=[m*(zl^2+xyl^2)/12 0 0 ; ...
        0 m*(zl^2+xyl^2)/12 0 ; ...
        0 0 m*(2*xyl^2)/12 ] + 1e-6*(rand(3)-0.5);
I_1_inv = inv(I_1);

sat1.nx = 100;
sat1.ny = 100;
sat1.nz = 100;
sat1.Ax = 0.005;
sat1.Ay = 0.005;
sat1.Az = 0.01;

%% Sat3 - Side Satellite
zl = 0.5*0.01; %2U
xyl = 1*0.01; %2U
m = 4*1/6;
I_3=[m*(zl^2+xyl^2)/12 0 0 ; ...
        0 m*(zl^2+xyl^2)/12 0 ; ...
        0 0 m*(2*xyl^2)/12 ] + 1e-6*(rand(3)-0.5);
I_3_inv = inv(I_3);

sat3.nx = 100;
sat3.ny = 100;
sat3.nz = 100;
sat3.Ax = 0.005;
sat3.Ay = 0.005;
sat3.Az = 0.01;

%% PLACEHOLDERS
counter = 0;
km = kp;
A = sat1.Ax;
n = sat1.nx;



%