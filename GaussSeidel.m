function [X] = GaussSeidel(A,b)
%[X] = GaussSeidel(A,b): Calculates system of linear equations by using an
%iterative method.
%   This code finds the solution to a system of simultaneous linear
%   equation using Gauss_Seidel Method.
%   Input A = sparse matrix
%   Input b = possibly a sparse vector
%   Output X must satisfy the formula Av = b

%   Version 1: Created 06/14/2010. Author: Mohammad Y. Saadeh
%   This MATLAB function m-file can be used to create the animation for the
%   solar system over a period of three years

%=========================================================================%
%Internal Parameters

n = length(b);
X = zeros(n,1);
Error_eval = ones(n,1);

%=========================================================================%

%Error Checking: To ensure the correct values were inputted into function.
if (nargin ~= 2), error('Incorrect number of input arguments.'); end

% Check if the matrix A is diagonally dominant
for i = 1:n
    j = 1:n;
    j(i) = [];
    B = abs(A(i,j));
    Check(i) = abs(A(i,i)) - sum(B); % Is the diagonal value greater than the remaining row values combined?
    if Check(i) < 0
        fprintf('The matrix is not strictly diagonally dominant at row %2i\n\n',i)
    end
end

% Start the Iterative method
iteration = 0;
while max(Error_eval) > 0.001
    iteration = iteration + 1;
    Z = X;  % save current values to calculate error later
    for i = 1:n
        j = 1:n; % define an array of the coefficients' elements
        j(i) = [];  % eliminate the unknow's coefficient from the remaining coefficients
        Xtemp = X;  % copy the unknows to a new variable
        Xtemp(i) = [];  % eliminate the unknown under question from the set of values
        X(i) = (b(i) - sum(A(i,j) * Xtemp)) / A(i,i);
    end
    Xsolution(:,iteration) = X;
    Error_eval = sqrt((X - Z).^2);
end

%Display Results
GaussSeidelTable = [1:iteration;Xsolution]';
MaTrIx = [A X b];

%Error Checking: To ensure the correct values were outputted from function.
if (nargout ~= 1), error('Incorrect number of output arguments.'); end

end

