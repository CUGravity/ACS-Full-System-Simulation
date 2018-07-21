
% COORDINATES SYSTEM: Z IS ALLIGNED ALONG THE TETHER DIRECTION

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
% spinAxis_B = [0.7806 0.6250 0]'; % Max principal axis

% UD Spin-up Controller
epsilon_UD_spinUp = .01;
kp_UD_spinUp = epsilon_UD_spinUp^2*.05; % Un-deployed detumble controller POSSIBLY = 0
kd_UD_spinUp = epsilon_UD_spinUp*0.025; % Un-deployed detumble controller
spinAxis_B = [1 0 0]; % Intended spin axis is always in body x direction

%% Tether
% Moved to initDynamics with other tether property initializations

%% PLACEHOLDERS
counter = 0; % Purpose unknown
% km = kp;
% A = sat1.Ax;
% n = sat1.nx;



%