function [M] = CreateAnimation(Z,N,k,len)
%[M] = CreateAnimation(Z,N): Creates the visualistion for the results.
%   This function takes in the set of data and the number of data sets and
%   creates plots and an animation to convey the results.
%   Input Z = set of data
%   Input N = number of data sets
%   Output M = animation

%   Version 1: Created 25/04/17. Author: D. Gormley
%   This MATLAB function creates the visualistion of the results.

%=========================================================================%
%Internal Parameters
FrameNumber = 300;
h = len/N;      %The spatial divisions
%r = k/(h^2);    %Simplifying the expression
%x = [-1+h:h:1-h]';%The matrix of spatial coordinates

%=========================================================================%

%Error Checking: To ensure the correct values were inputted into function.
if (nargin ~= 4), error('Incorrect number of input arguments.'); end

%Different colours mark the passage of time for 2D plot
figure
plot([-1:h:1],Z)
title('Two Dimensional Plot of all Data Points');
xlabel('Distance (arb. units)');
ylabel('Temperature (\circ C)');

%Plotting a 3D representation of the data
figure
[T,X]=meshgrid([0:k:(FrameNumber-1)*k],[-1:h:1]);
%Makes the axes have the correct range
surf(T,X,Z,'LineStyle','none')

hold on
handlecolor = pcolor(T,X,Z) %flat surface plot beneath
ZZ = get(handlecolor,'ZData') - 4;
set(handlecolor,'ZData',ZZ);
axis([0 0.15 -1 1 -4 3])
colormap hot %uses more yellow and red

title('Colour Schematic of Temperature of solid')
xlabel('Time (arb. units)'), ylabel('Distance (arb. units)'), zlabel('Temperature (\circ C)')
set(handlecolor, 'LineStyle', 'none') %turn off boundary lines
colorbar

% Use VideoWriter to create a suitable video object ready to receive data.
VideoObject = VideoWriter('HeatEquation.avi');
open(VideoObject);

for count = 1:FrameNumber
    %Setting up the axis and then removing it
    handlefig = figure('Position',[100 100 850 600]);
    plot([-1:h:1],Z(:,count));
    title('Animation of the Two Dimensional Temperature Changes');
    xlabel('Distance (arb. units)');
    ylabel('Temperature (\circ C)');
    
    %Get the frame and add it into the video
    current_frame = getframe(handlefig);
    writeVideo(VideoObject,current_frame);
    
    %In this implementation the figure is closed after all the planets of
    %the frame have been added to the video.
    close(handlefig)

end


end

