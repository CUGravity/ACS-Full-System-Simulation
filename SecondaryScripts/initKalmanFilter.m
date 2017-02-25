function initKalmanFilter
A = eye(16,16);
B = zeros(16,1);
C = blkdiag(eye(3,3),zeros(3,3),eye(10,10));
H = C;

Q_k = zeros(16,16);
w_k = zeros(16,1);
u_k = zeros(16,1);
Z_k = zeros(16,1);
R_k = zeros(13,13);
