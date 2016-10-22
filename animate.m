% Animate the bouncing ball (the "good" way)
%

figure;

hold on;
c1 = plot3(0,0,0,'.k','MarkerSize',40); hold on;
c2 = plot3(0,0,0,'.k','MarkerSize',40); hold on;
c3 = plot3(0,0,0,'.k','MarkerSize',40); hold on;

axis( [-1 1 -1 1])

timeArr = c(1).signal1.Time;
r1 = c(1).signal1.Data(:,1:3);
r2 = c(2).signal1.Data(:,1:3) - r1;
r3 = c(3).signal1.Data(:,1:3) - r1;
r1 = r1 - r1;

tic % Start the clock
aT = 0;

while aT < timeArr(end)
   
    c1x = interp1(timeArr,r1(:,1),aT);
    c1y = interp1(timeArr,r1(:,2),aT);
    c1z = interp1(timeArr,r1(:,3),aT);
    c1.XData = c1x;
    c1.YData = c1y;
    c1.ZData = c1z;
    
    c2x = interp1(timeArr,r2(:,1),aT);
    c2y = interp1(timeArr,r2(:,2),aT);
    c2z = interp1(timeArr,r2(:,3),aT);
    c2.XData = c2x;
    c2.YData = c2y;
    c2.ZData = c2z;
    
    c3x = interp1(timeArr,r3(:,1),aT);
    c3y = interp1(timeArr,r3(:,2),aT);
    c3z = interp1(timeArr,r3(:,3),aT);
    c3.XData = c3x;
    c3.YData = c3y;
    c3.ZData = c3z;   
    
%     axis( [ min([c1x c2x c3x]) max([c1x c2x c3x]) ...
%         min([c1y c2y c3y]) max([c1y c2y c3y]) ...
%         min([c1z c2z c3z]) max([c1z c2z c3z]) ] );
    
    drawnow;
    
    aT = toc;
   
end






