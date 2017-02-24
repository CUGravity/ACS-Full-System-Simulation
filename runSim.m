
%
close all;
clear;
clc;

tic;
%
initSimulink;
initACS;

configFirst;

t_end = OpTimes(end)+10;
sim('Main');

%
disp(['Simulation ran in ',num2str(toc,'%.2f'),' seconds']);

plotRun(stateArr,actuationCmds,'all');