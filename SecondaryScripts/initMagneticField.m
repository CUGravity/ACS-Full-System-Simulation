%% File Description
%{
Author:     Aaron Sandoval
Team:       CU Artificial Gravity CubeSat
Project:    Undeployed-Mode Attitude Control
Created:    2018-03
Updated:    2018-07

Description:
This script calculates a magnetic field timeseries corresponding to an
input timeseries of locations.

Conventions:
The input is assumed to be in ECI coordinates
Outpout in ECI coordinates
UTC corresponds to the time at simulation t=0
%}
%% Function definition
function B_N = initMagneticField(r_N, UTC)

nSteps = size(r_N.Time,1);
t = r_N.Time;

%% Initial Conditions
% baseYear = 2015;
% year = 4.25 + 12/(24*365); % Decimal years past 2015-01-01, HARD-CODED
DT_0 = datetime(UTC); % datetime at simulation t=0

rT_N = r_N.Data(:,1:3); %Instantaneous position
DT = DT_0 + seconds(t); % Current datetime
DV = datevec(DT);
decYear = decyear(DV);

rT_LLA = eci2lla(rT_N, DV);
height = rT_LLA(:,3);
lat = rT_LLA(:,1);
lon = rT_LLA(:,2);
% Calculates all DCMs between frames and transposes them as necessary
Q_ECEF_NED = permute(dcmecef2ned(lat,lon), [2 1 3]);
Q_ECI_ECEF = permute(dcmeci2ecef('IAU-2000/2006',DV), [2 1 3]);

B_NED = zeros(nSteps,3);
B_ECI = zeros(nSteps,3);
for i = 1:nSteps
    [B_NED(i,:),~,~,~,~] = wrldmagm(height(i), lat(i), lon(i), decYear(i)); % units: nT
    B_ECI(i,:) = (Q_ECI_ECEF(:,:,i)*Q_ECEF_NED(:,:,i)*B_NED(i,:)'*1e-9)'; % nanoTesla to Tesla
end
B_N = timeseries(B_ECI, t, 'Name', 'Magnetic Field');


end