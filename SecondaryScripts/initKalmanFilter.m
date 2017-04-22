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

a = [3; -2; 1]/norm([3; -2; 1]);
phi = 0.156;
q0 = [a*sin(phi/2); cos(phi/2)];
w0 = a*0.001;

x0 = [0;
    0;
    6978000;
    0;
    7558;
    0;
    0;
    0;
    0;
    w0;
    q0];

JD = 2457857.916667;
JD_GPS0 = 2457857.5;

% Number of leap seconds since start of GPS (current as of 2014)
UTC_leap_seconds_wrt_GPS = 0;

% GPS time at sim start [s]
sim_start_time = (JD - JD_GPS0) * 24*60*60 - UTC_leap_seconds_wrt_GPS;



