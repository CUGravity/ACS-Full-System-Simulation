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




