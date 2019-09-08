function [Z] = CrankNicolsonHeat(N,k,len) %[Z] = CrankNicolsonHeat(300,0.0005,2) if you want to run it!
%[Storage,Z] = CrankNicolsonHeat(N,k,len):
%   Detailed explanation goes here
%   Input N = number of divisions to be made over entire solid
%   Input k = the time interval between different sets of values
%   Input len = length of the solid
%   Output Z = set of data (temperatures at given points for all calculated
%   times.

%   Version 1: Created 23/04/17. Author: D. Gormley
%   This function

%=========================================================================%
%Internal Parameters
h = len/N;      %The spatial divisions
r = k/(h^2);    %Simplifying the expression
x = [-1+h:h:1-h]';%The matrix of spatial coordinates
u = (2*x)+1;    %The initial conditions

%=========================================================================%

%Error Checking: To ensure the correct values were inputted into function.
if (nargin ~= 3), error('Incorrect number of input arguments.'); end

%Create sparse matrices A1 and A2
e = ones(N-1,1);
A1 = spdiags([-(r/2)*e (1+r)*e -(r/2)*e],[-1 0 1],N-1,N-1);
A2 = spdiags([(r/2)*e (1-r)*e (r/2)*e],[-1 0 1],N-1,N-1);

%Create a vector b = b2-b1, independent of j for given boundary conditions
b = [-1*r; zeros(N-3,1); 3*r];

%Recursion to be solved: A1u(j+1) = A2u(j)+b+k

Storage = zeros(N-1,300);    %set data aside for the first 15 time steps

Storage(:,1)=u;         %put interior point values into first column
%solutions to the first step

for count = 2:300
    vtemp = k+(A2*u)+b;
    
    u = GaussSeidel(A1,vtemp);  %solve by iteration
    
    Storage(:,count)=u; %place current interior point values into current 
    %column as identified by count
end

Z= [-1*ones(1,300);Storage;3*ones(1,300)];   %append known boundary values 
%to either end of interior solutions

%Call function to give it 
CreateAnimation(Z,N,k,len);

%Error Checking: To ensure the correct values were outputted from function.
if (nargout ~= 1), error('Incorrect number of output arguments.'); end

end

