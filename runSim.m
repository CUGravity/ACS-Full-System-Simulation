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
t_end = 10;
% start timer
tic;
% Run simulation
sim('Main');
% display simulation time
disp(['Simulation ran in ',num2str(toc,'%.2f'),' seconds']);

% animations and plotting
plotRun;