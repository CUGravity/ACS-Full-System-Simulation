%%% File Description
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
%%% Script
% refresh enviroment
% bdclose('all');
close all;
clear;
clc;

% add 2ndary scripts and initialize parameters
addpath('SecondaryScripts');

%%% Initialize Workspace Variables
initSimulink;
[r_N, v_N, B_N, UTC] = initOrbit(2); % Change arg to select orbit
initDynamics;
initACS;
initSensors;
initKalmanFilter;
initattitude;

% % % % add orbital data to data dictionary
% % % myDictionaryObj = Simulink.data.dictionary.open('MainDataDictionary.sldd');
% % % dDataSectObj = getSection(myDictionaryObj,'Design Data');
% % % % otherSec = getSection(myDictionaryObj,'Other');
% % % setValue(getEntry(dDataSectObj,'r_N'),r_N.Time)
% % % setValue(getEntry(dDataSectObj,'v_N'),v_N.Time)
% % % setValue(getEntry(dDataSectObj,'B_N'),B_N.Time)
% % % % % otherSec.addEntry('OrbitTime', r_N.Time.');
% % % % otherSec.addEntry('RN', r_N.Data.');
% % % % otherSec.addEntry('VN', v_N.Data.');
% % % % otherSec.addEntry('BN', B_N.Data.');
% % % % % setValue(getEntry(otherSec,'Orbit_time'),r_N.Time.')
% % % % setValue(getEntry(otherSec,'RN'),r_N.Data.')
% % % % setValue(getEntry(otherSec,'VN'),v_N.Data.')
% % % % setValue(getEntry(otherSec,'BN'),B_N.Data.')
% % % % addEntry(dDataSectObj,'r_N',[r_N.Data])
% % % % addEntry(dDataSectObj,'v_N',[v_N.Data])
% % % % addEntry(dDataSectObj,'B_N',[B_N.Data])


% Initial conditions
configFirst;
t_end = 10;

%%% Run Simulation
% start timer
tic;
% sim('NEW_MAIN');
sim('NEW_MAIN_noDD');
% sim('Main');

%%% Display Results
disp(['Simulation ran in ',num2str(toc,'%.2f'),' seconds']);
% Takes ~10 seconds from clicking "Run" until start of sim
disp(['Simulation ran ',num2str((toc)/t_end,'%.1f'),...
    ' times slower than real-time']);

% Animations and plotting
plotRun;
