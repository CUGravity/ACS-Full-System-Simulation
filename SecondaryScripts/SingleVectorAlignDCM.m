%% File Description
%{
Name:       Aaron Sandoval
Course:     MAE 5710 - Applied Dynamics
Created: 2018-02-27
Updated: 2018-02-27

Description:
This function creates a DCM from an underspecified set of constraints,
namely the alignment of a single vector in body and reference frames. A
second vector is generated randomly, and the two are used with the TRIAD
estimation method to generate a DCM.
%}

%% Function Definition
function Q_N_B = SingleVectorAlignDCM(v_N, v_B)
if(~isequal(size(v_N),[3,1]) || ~isequal(size(v_B),[3,1]))
    error('Input has wrong dimensions');
end
vecs_N = [v_N,rand(3,1)];
vecs_B = [v_B,rand(3,1)];
Q_N_B = triad(vecs_N,vecs_B)';