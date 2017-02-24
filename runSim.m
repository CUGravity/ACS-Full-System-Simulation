% bdclose('all')
%
close all;
clear;
clc;

tic;
%
addpath('SecondaryScripts');
initSimulink;
initACS;

configFirst;

t_end = OpTimes(end)+10;
sim('Main');

%
disp(['Simulation ran in ',num2str(toc,'%.2f'),' seconds']);

plotRun(stateArr,actuationCmds,'all');