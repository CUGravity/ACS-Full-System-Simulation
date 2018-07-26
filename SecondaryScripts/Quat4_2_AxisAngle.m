%% File Description
%{
Author:     Aaron Sandoval
Team:       CU Artificial Gravity CubeSat
Project:    Undeployed-Mode Attitude Control

Description:
Converts between attitude representations.
%}

function [a, phi] = Quat4_2_AxisAngle(q4)
phi = acos(q4(4))*2;
s = sin(phi/2);
a = q4(1:3)/s;
end