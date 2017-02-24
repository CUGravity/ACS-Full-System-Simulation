function plotRun(stateArr,actuationCmds,toPlot)
%

plotStates(stateArr,toPlot);

plotCmds(actuationCmds,toPlot);

if strcmp(toPlot,'all') || strcmp(toPlot,'Orbits')
%     plotOrbit(stateArr);
end

if strcmp(toPlot,'all') || strcmp(toPlot,'Animate')
%     animate;
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

if strcmp(toPlot,'Panels') || strcmp(toPlot,'all') || strcmp(toPlot,'States')
    p1 = stateArr.SolarPanelState.panel1;
    p2 = stateArr.SolarPanelState.panel2;
    
    p = [ p1 p2 ];
    
    for i = 1:length(p)
        figure; hold on; box on;
        plot(p(i));
        legend('Theta','Theta_dot','Phi','Phi_dot');
        title(['panel ',num2str(i),': Orientation over time']);
    end
    
end

end

function plotCmds(actuationCmds,toPlot)

c1 = actuationCmds.Cube1_PWM_cmds;
c2 = actuationCmds.Cube2_PWM_cmds;
c3 = actuationCmds.Cube3_PWM_cmds;

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