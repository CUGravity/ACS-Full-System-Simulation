function plotRun(stateArr,actuationCmds,toPlot)
%

plotStates(stateArr,toPlot);

plotCmds(actuationCmds,toPlot);

if strcmp(toPlot,'all') || strcmp(toPlot,'Orbits')
    %     plotOrbit(stateArr);
end

end

function plotStates(stateArr,toPlot)

if strcmp(toPlot,'Cubes') || strcmp(toPlot,'all') || strcmp(toPlot,'States')
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
end
end

function plotCmds(actuationCmds,toPlot)

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

end

function plotOrbit(stateArr)

% Plot orbit
figure; hold on; axis equal;
r = 6.371e6;

c1 = stateArr.Cube1State;
c2 = stateArr.Cube2State;
c3 = stateArr.Cube3State;

[x,y,z] = sphere; surf(x*r,y*r,z*r,z*0+1);

plot3(c1.r_N.Data(:,1),c1.r_N.Data(:,2),c1.r_N.Data(:,3),'k');
plot3(c2.r_N.Data(:,1),c2.r_N.Data(:,2),c2.r_N.Data(:,3),'k');
plot3(c3.r_N.Data(:,1),c3.r_N.Data(:,2),c3.r_N.Data(:,3),'k');

end