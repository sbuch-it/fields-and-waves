%	M-File: wave1
%	This program shows a progressive wave as a function of z for a
%	fixed moment
%
%	Variables:
%	A			Initial amplitude
%	f           frequency (Hz)
%   omega       angular frequency (rad/s)
%   t           time instant (s)
%	ep_r        relative permittivity of the medium
%	phi         phase (degrees)
%	phir        phase (radians)
%	c           wave speed (m/s)
%	lambda      wavelength (m)
%	beta        constant phase (1/m)
%	E           electric field function E(z,t)
%	z           position (m)

clc   % clear the command window
clear % removes all variables from the workspace

%	Initialize the variables
A=1;
f=1e9;
t=0;
ep_r=2;
phi=0;

%   Previous calculations
phir=phi*pi/180;
c=3e8/sqrt(ep_r);
lambda=c/f;
beta=2*pi/lambda;
omega=2*pi*f;

%	Performs the calculation of E(z,t)
z=0:4*lambda/100:4*lambda;
E=A*cos(omega*t-beta*z+phir);

%	Generates graphic (figure plot)
plot(z,E,'LineWidth',2)
axis([0 4*lambda -2*A 2*A])
% Sets scaling for the x- and y-axes on the current plot,
% axis([xmin xmax ymin ymax])

grid
title(['Progressive wave in the instant t = ',num2str(t),' s'])
xlabel('z (m)')
ylabel('E(z,t) (V/m)')


