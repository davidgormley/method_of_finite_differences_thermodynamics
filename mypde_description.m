function [c,f,s] = mypde_description(x,t,u,dudx)
%[c,f,s]=pde_description(x,t,u,dudx) describes the partial differential 
%equation to be solved
% created: 20/03/13
% author: P.F. Curran

c=1;
f=x+dudx;
s=0;

end