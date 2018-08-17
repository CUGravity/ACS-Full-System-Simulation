%% File Description
%{
Team:       CU Artificial Gravity CubeSat
Updated:    2018-07
Update by:  Aaron Sandoval

Description:
Root script to run CUAG flight computer and dynamics simulation. Calls
several secondary scripts to initialize variables and runs Main.slx
Simulink model. Optionally, plots attitude and estimation results after
simulation is complete.
%}
%% Script
% refresh enviroment
% bdclose('all');
close all;
clear;
clc;

% add 2ndary scripts and initialize parameters
addpath('SecondaryScripts');

%% Initialize Workspace Variables
initSimulink;
[r_N, v_N, B_N, UTC] = initOrbit(2); % Change arg to select orbit
initDynamics;
initACS;
initSensors;
initKalmanFilter;
initattitude;

% Initial conditions
configFirst;
t_end = 10;

%% Run Simulation
% start timer
tic;
sim('Main');

%% Display Results
disp(['Simulation ran in ',num2str(toc,'%.2f'),' seconds']);
% Takes ~10 seconds from clicking "Run" until start of sim
disp(['Simulation ran ',num2str((toc)/t_end,'%.1f'),...
    ' times slower than real-time']);

% Animations and plotting
% plotRun;
