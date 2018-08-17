%init torque model

%positions
[r_timeseries,v_timeseries, B_N, UTC] = initOrbit(2);
r1 = r_timeseries.data(:,1);
r2 = r_timeseries.data(:,2);
r3 = r_timeseries.data(:,3);

%GG parameters
G = 6.67*10^-11;
I1 = 0.0154852983;
I2 = 0.0156707;
I3 = 0.00618;
M_E = 5.972*10^24;

%MT parameters
M1 = 0.00506;
M2 = 0.00509;
M3 = 0.00447;

%AD parameters
p = 8.43*10^-12;
cd = 2.2;
A = 0.09;
rcp1 = -0.0031;
rcp2 = -0.0041;
rcp3 = 0.0056;

%SRP parameters
flux = 1366;
c = 3*10^8;
q = 0.6;
