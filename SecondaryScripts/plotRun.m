% plotRun(stateArr,actuationCmds,toPlot)
%
close all;

%% state
c1 = stateArr.Cube1State;
c2 = stateArr.Cube2State;
c3 = stateArr.Cube3State;
c = [ c1 c2 c3 ];

for i = 1:3
    figure; hold on; box on;
    plot(c(i).r_N);
    legend('rx','ry','rz');
    title(['c',num2str(i),': Position over time']);
    
    figure; hold on; box on;
    plot(c(i).v_N);
    legend('vx','vy','vz');
    title(['c',num2str(i),': Velocity over time']);
    
    figure; hold on; box on;
    plot(c(i).q_BN);
    legend('q1','q2','q3','q4');
    title(['c',num2str(i),': Quaternions over time']);
    
    figure; hold on; box on;
    plot(c(i).w_BN);
    legend('wx','wy','wz');
    title(['c',num2str(i),': Rotation Rate over time']);
end
%% estimated state

r_N_est = stateEstimation.r_N_est;
v_N_est = stateEstimation.v_N_est;
q_BN_est = stateEstimation.q_BN_est;
w_BN_est = stateEstimation.w_BN_est;

figure; hold on; box on;
plot(r_N_est);
legend('rx','ry','rz');
title('center est position');

figure; hold on; box on;
plot(v_N_est);
legend('vx','vy','vz');
title('center est velocity');

figure; hold on; box on;
plot(q_BN_est);
legend('q1','q2','q3','q4');
title('center est attitude');

figure; hold on; box on;
plot(w_BN_est);
legend('wx','wy','wz');
title('center est angular velocity');

%% cmds
centerPWM = actuationCmds.CenterCube_PWM_cmds;
motorReel = actuationCmds.MotorReelRates;
burnCmds = actuationCmds.BurnCmd;
acsSafe = actuationCmds.ACSSafeMode;

figure; hold on; box on;
plot(centerPWM);
legend('PWM x','PWM y','PWM z');
title('centerPWM Commands');

figure; hold on; box on;
plot(burnCmds);
legend('Wire 1','Wire 2','Wire 3','Wire 4');
title('Burn Wire Commands');

figure; hold on; box on;
plot(motorReel);
legend('Reel 1','Reel 2');
title('Motor Reel Commands');

figure; hold on; box on;
plot(acsSafe);
title('ACS Safe Mode');


%% Plot orbit
% figure; hold on; axis equal;
% r = 6.371e6;
%
% c1 = stateArr.Cube1State;
% c2 = stateArr.Cube2State;
% c3 = stateArr.Cube3State;
%
% [x,y,z] = sphere; surf(x*r,y*r,z*r,z*0+1);
%
% plot3(c1.r_N.Data(:,1),c1.r_N.Data(:,2),c1.r_N.Data(:,3),'k');
% plot3(c2.r_N.Data(:,1),c2.r_N.Data(:,2),c2.r_N.Data(:,3),'k');
% plot3(c3.r_N.Data(:,1),c3.r_N.Data(:,2),c3.r_N.Data(:,3),'k');
