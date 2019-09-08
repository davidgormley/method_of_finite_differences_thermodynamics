%pdepe Interface

%help pdepe

m = 0;
N = 40;
len = 2;
h = len/N;
FrameNumber = 300;

k = 0.0005;

xmesh = [-1:h:1]; %where do the boundaries occur
tspan = [0:k:299*k];  %times at which solution to be calculated

%Each row is a time at which fct calculated
sol = pdepe(m,@mypde_description,@mypde_ic,@mypde_bc,xmesh,tspan);

sol = sol';

%Different colours mark the passage of time
%Different colours mark the passage of time for 2D plot
figure
plot(xmesh,sol)
title('Two Dimensional Plot of all Data Points Using the pdepe Command');
xlabel('Distance (arb. units)');
ylabel('Temperature (\circ C)');


%Plotting a 3D representation of the data
figure
[T,X]=meshgrid([0:k:(FrameNumber-1)*k],[-1:h:1]);
%Makes the axes have the correct range
surf(T,X,sol,'LineStyle','none')

hold on
handlecolor = pcolor(T,X,sol) %flat surface plot beneath
ZZ = get(handlecolor,'ZData') - 4;
set(handlecolor,'ZData',ZZ);
axis([0 0.15 -1 1 -4 3])
colormap hot %uses more yellow and red

title('Colour Schematic of Temperature of solid Using the pdepe Command')
xlabel('Time (arb. units)'), ylabel('Distance (arb. units)'), zlabel('Temperature (\circ C)')
set(handlecolor, 'LineStyle', 'none') %turn off boundary lines
colorbar