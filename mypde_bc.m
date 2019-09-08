function [pl,ql,pr,qr] = mypde_bc(xl,ul,xr,ur,t)
% [pl,ql,pr,qr]=mypde_bc(xl,ul,xr,ur,t): generates boundary conditions
% for mypde_description
% created: 20/03/13
% author: P.F. Curran

%Change pl and pr from +-2 to +1 and -3 from BC! Okay?
pl = ul+1;
ql=0;
pr = ur-3;
qr=0;

end

