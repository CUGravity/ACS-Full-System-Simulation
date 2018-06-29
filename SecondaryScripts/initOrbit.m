%%% Init file for Orbital Propagator

close all
clear
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% READ ME FOR SATELLITE INPUT (inclination and altitude variations)
% n = case #           path
%   1               ISS: alt = 408, I = 51
%   2               I = 0, alt = 450
%   3               I = 0, alt = 550
%   4               I = 0, alt = 650
%   5               I = 30, alt = 450
%   6               I = 30, alt = 550
%   7               I = 30, alt = 650
%   8               I = 60, alt = 450
%   9               I = 60, alt = 550
%   10              I = 60, alt = 650
%   11              I = 90, alt = 450
%   12              I = 90, alt = 550
%   13              I = 90, alt = 650
%   14              geomagnetic equatorial: I = 9.63, alt = 450
%   15              geomagnetic equatorial: I = 9.63, alt = 550
%   16              geomagnetic equatorial: I = 9.63, alt = 650
%   17              geomagnetic polar: I = 99.63, alt = 450
%   18              geomagnetic polar: I = 99.63, alt = 550
%   19              geomagnetic polar: I = 99.63, alt = 650
%   20              SSO am: alt = 450
%   21              SSO am: alt = 550
%   22              SSO am: alt = 650
%   20              SSO pm: alt = 450
%   21              SSO pm: alt = 550
%   22              SSO pm: alt = 650
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% COLUMN ORDER FOR THE FILES
% 1     day (of month)
% 2     month
% 3     year
% 4     hour
% 5     minute
% 6     second
% 7     x position (ECEF)
% 8     y position (ECEF)
% 9     z position (ECEF)
% 10    x velocity (ECEF)
% 11    y velocity (ECEF)
% 12    z velocity (ECEF)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = input('Enter the orbit number you would like to simulate.  ');

% load satellite information from input value
switch n
    case 1 
        sat = xlsread('ISS.csv');
    case 2
        sat = xlsread('Equator1.csv');
    case 3
        sat = xlsread('Equator2.csv');
    case 4
        sat = xlsread('Equator3.csv');
    case 5 
        sat = xlsread('30inc1.csv');
    case 6 
        sat = xlsread('30inc2.csv');
    case 7 
        sat = xlsread('30inc3.csv');
    case 8 
        sat = xlsread('60inc1.csv');
    case 9 
        sat = xlsread('60inc2.csv');
    case 10 
        sat = xlsread('60inc3.csv');
    case 11 
        sat = xlsread('90inc1.csv');
    case 12
        sat = xlsread('90inc2.csv');
    case 13
        sat = xlsread('90inc3.csv');
    case 14
        sat = xlsread('GME1.csv');
    case 15
        sat = xlsread('GME2.csv');
    case 16
        sat = xlsread('GME3.csv');
    case 17
        sat = xlsread('GMP1.csv');
    case 18
        sat = xlsread('GMP2.csv');
    case 19
        sat = xlsread('GMP3.csv');
    case 20
        sat = xlsread('SSOam1.csv');
    case 21
        sat = xlsread('SSOam2.csv');
    case 22
        sat = xlsread('SSOam3.csv');
    case 23
        sat = xlsread('SSOpm1.csv');
    case 24
        sat = xlsread('SSOpm2.csv');
    case 25
        sat = xlsread('SSOpm3.csv');
    otherwise
        error('Simulation requires valid satellite number: 1-25')
end

% find size 
[m, ~] = size(sat);

% store satellite time data
days = sat(:,1);
mons = sat(:,2);
yrs = sat(:,3);
hrs = sat(:,4);
mins = sat(:,5);
secs = sat(:,6);
utc = [yrs mons days hrs mins secs];

% store satellite state data
rECEF = sat(:,7:9).';
vECEF = sat(:,10:12).';

% specify time step used in Simulink
dt = (hrs(2)-hrs(1))*3600 + (mins(2)-mins(1))*60 + secs(2)-secs(1); % [sec]

% initialize number of time steps taken per day
DT = 86400/dt;

% initialize ECI frame components
rECI = zeros( size(rECEF) );
vECI = zeros( size(rECEF) );

% initialize rotation rate of Earth and corresponding cross product matrix
omega = 2*pi/86400;
omegaX = [0 -omega 0; omega 0 0; 0 0 0];

% transform from ECEF to ECI
for i = 1:DT
    % find angle between frames
    th = omega*(hrs(i)*3600 + mins(i)*60 + sec(i));
    
    % set rotation matrix
    R = [cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
    
    % transform position from ECEF to ECI
    rECI(:,i:DT:end) = R*rECEF(:,i:DT:end);
    
    % transform velocity from ECEF to ECI
    vECI(:,i:DT:end) = R*vECEF(:,i:DT:end) + omegaX*rECI(:,i:DT:end);
end

% transpose state for timeseries initialization
rECI = rECI.';
vECI = vECI.';

% store state into timeseries
r = timeseries( rECI, 0:dt:(m-1)*dt, 'Name', 'Position' );
v = timeseries( vECI, 0:dt:(m-1)*dt, 'Name', 'Velocity' );

% store UTC into timeseries
UTC = timeseries( utc, 0:dt:(m-1)*dt, 'Name', 'UTC' );

% 
% % verify????
% len = 1e3;
% r1 = rECEF(:,1:len).';
% v1 = vECEF(:,1:len).';
% r2 = rECI(1:len,:);
% v2 = vECI(1:len,:);
% tt = r.Time(1:len);
% 
% figure
% clf
% subplot(3,1,1)
% plot(tt, r1(:,1))
% subplot(3,1,2)
% plot(tt, r1(:,2))
% subplot(3,1,3)
% plot(tt, r1(:,3))
% 
% 
% figure
% clf
% subplot(3,1,1)
% plot(tt, r2(:,1))
% subplot(3,1,2)
% plot(tt, r2(:,2))
% subplot(3,1,3)
% plot(tt, r2(:,3))
% 
% 
% figure
% clf
% subplot(3,1,1)
% plot(tt, sqrt(r1(:,1).^2+r1(:,2).^2+r1(:,3).^2))
% subplot(3,1,2)
% plot(tt, sqrt(r2(:,1).^2+r2(:,2).^2+r2(:,3).^2))
% subplot(3,1,3)
% plot(tt, sqrt(r2(:,1).^2+r2(:,2).^2+r2(:,3).^2)-sqrt(r1(:,1).^2+r1(:,2).^2+r1(:,3).^2))
% 
% 
% figure
% clf
% subplot(3,1,1)
% plot(tt, v1(:,1))
% subplot(3,1,2)
% plot(tt, v1(:,2))
% subplot(3,1,3)
% plot(tt, v1(:,3))
% 
% 
% figure
% clf
% subplot(3,1,1)
% plot(tt, v2(:,1))
% subplot(3,1,2)
% plot(tt, v2(:,2))
% subplot(3,1,3)
% plot(tt, v2(:,3))
% 
% 
% figure
% clf
% subplot(3,1,1)
% plot(tt, sqrt(v1(:,1).^2+v1(:,2).^2+v1(:,3).^2))
% subplot(3,1,2)
% plot(tt, sqrt(v2(:,1).^2+v2(:,2).^2+v2(:,3).^2))
% subplot(3,1,3)
% plot(tt, sqrt(v2(:,1).^2+v2(:,2).^2+v2(:,3).^2)-sqrt(v1(:,1).^2+v1(:,2).^2+v1(:,3).^2))
