function frames = makeTestData(max,anglexy,sangle)
x = 1:1:1*max;
y = 1:max;
x = x.*cosd(anglexy);
y = y.*sind(anglexy);
sangle = deg2rad(sangle);
figure (10)
for i = 1:length(x)
    plot([x(i), x(i)],[y(i),y(i)],'k.','LineWidth',10,'MarkerSize',50);
    axis([0 100 0 100]);
    frames(i) = getframe;
end
