% refresh enviroment
% bdclose('all');
close all;
clear;
clc;

% add 2ndary scripts and initialize parameters
addpath('SecondaryScripts');
initSimulink;
initACS;
initDynamics;
initSensors;
initKalmanFilter;

% Which configuration to run
configFirst;
% t_end = OpTimes(end)+0;
t_end = 1;
% start timer
tic;
% Run simulation
sim('Main');

% Display simulation time
disp(['Simulation ran in ',num2str(toc-10,'%.2f'),' seconds']);
% Takes ~10 seconds from clicking "Run" until start of sim
disp(['Simulation ran ',num2str((toc-10)/t_end,'%.1f'),...
    ' times slower than real-time']);

% Animations and plotting
% plotRun;