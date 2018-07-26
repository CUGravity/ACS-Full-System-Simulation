%% File Description
%{
Author:     Aaron Sandoval
Team:       CU Artificial Gravity CubeSat
Project:    Undeployed-Mode Attitude Control
Created:    2018-03
Updated:    2018-05

Description:
Triad is a basic attitude estimation algorithm using two vector
measurements. Not for use as actual flight estimation, only as a utility.
%}
%% FUnction Definition
function Q_BN = triad(v_N, v_B)
%%%% NOT YET VALIDATED %%%%
% if(~isequal(size(vN),[3,2]) || ~isequal(size(vB),[3,2]))
%     error('Input has wrong dimensions');
% end
% v1N = vN(:,1); v1N = v1N / norm(v1N);
% v2N = vN(:,2); v2N = v2N / norm(v2N);
% v1B = vB(:,1); v1B = v1B / norm(v1B);
% v2B = vB(:,2); v2B = v2B / norm(v2B);
% MN2 = cross(v1N, v2N); MN2 = MN2 / norm(MN2);
% MN3 = cross(v1N, MN2); MN3 = MN3 / norm(MN3);
% MB2 = cross(v1B, v2B); MB2 = MB2 / norm(MB2);
% MB3 = cross(v1B, MB2); MB3 = MB3 / norm(MB3);
% MN = [v1N, MN2, MN3];
% MB = [v1B, MB2, MB3];
% Q_BN = MB*MN';

% if(~isequal(size(v_N),[3,2]) || ~isequal(size(v_B),[3,2]))
%     error('Input has wrong dimensions');
% end
% % v2_N = cross(v_N,rand(3,1));
% % v2_B = cross(v_B,rand(3,1));
% v_N = [v_N,v2_N];
% v_B = [v_B,v2_B];

%% function Q_N_B = triad(vecs_N,vecs_B)
if(~isequal(size(v_N),[3,2]) || ~isequal(size(v_B),[3,2]))
    error('Input has wrong dimensions');
end
v1N = v_N(:,1); v1N = v1N / norm(v1N);
v2N = v_N(:,2); v2N = v2N / norm(v2N);
v1B = v_B(:,1); v1B = v1B / norm(v1B);
v2B = v_B(:,2); v2B = v2B / norm(v2B);
MN2 = cross(v1N, v2N); MN2 = MN2 / norm(MN2);
MN3 = cross(v1N, MN2); MN3 = MN3 / norm(MN3);
MB2 = cross(v1B, v2B); MB2 = MB2 / norm(MB2);
MB3 = cross(v1B, MB2); MB3 = MB3 / norm(MB3);
MN = [v1N, MN2, MN3];
MB = [v1B, MB2, MB3];
Q_BN = MB*MN';
end