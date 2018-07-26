%% File Description
%{
Author:     Aaron Sandoval
Team:       CU Artificial Gravity CubeSat
Project:    Undeployed-Mode Attitude Control

Description:
Converts between attitude representations. Returns the DCM which performs
the rotation by +phi. That is, it returns Q_B_N if the basis from which the
rotation is made is n_i.
%}

function DCM = Axis_Angle2DCM(a, phi)
[three, ~] = size(a);
if(three~=3)
    b = transpose(a);
else
    b = a;
end
[three, one] = size(b);
if(three~=3 || one ~= 1)
    error('a has wrong # of terms');
end
b = b/norm(b);
DCM = eye(3)*cos(phi) + (1-cos(phi))*b*transpose(b) - sin(phi)*crs(b);