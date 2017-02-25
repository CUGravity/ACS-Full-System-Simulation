% refresh enviroment
% bdclose('all');
close all;
clear;
clc;
% start timer
tic;

% add 2ndary scripts and initialize parameters
addpath('SecondaryScripts');
initSimulink;
initACS;
initDynamics;
initSensors;

% Which configuration to run
configFirst;
t_end = OpTimes(end)+100;
% Run simulation
sim('Main');

% display simulation time
disp(['Simulation ran in ',num2str(toc,'%.2f'),' seconds']);
% animcations and plotting
plotRun(stateArr,actuationCmds,'all');