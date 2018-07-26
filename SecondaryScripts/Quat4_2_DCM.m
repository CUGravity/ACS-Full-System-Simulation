%% File Description
%{
Author:     Aaron Sandoval
Team:       CU Artificial Gravity CubeSat
Project:    Undeployed-Mode Attitude Control

Description:
Converts between attitude representations.
%}

function Q_B_N = Quat4_2_DCM(q4)
[a,phi] = Quat4_2_AxisAngle(q4);
Q_B_N = Axis_Angle2DCM(a,phi);
end