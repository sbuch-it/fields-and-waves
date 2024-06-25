%	M-File: wave2
%
%	This program shows a progressive wave 
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
A=30;
f=(1e8)/(2*pi);
t=0;
ep_r=2.25;
phi=0;
mu0=4*pi*1e-7;
ep0=1e-9/36/pi;

%   Previous calculations
sigma = 0;
phir=phi*pi/180;
c=3e8/sqrt(ep_r);
lambda=c/f;
beta=2*pi/lambda;
omega=2*pi*f;
Z=sqrt(1j*omega*mu0/(sigma+1j*omega*ep_r*ep0));

%	Performs the calculation of E(z,t)
z=0:4*lambda/100:4*lambda;
E=A*cos(omega*t-beta*z+phir);


%	Generates initial graphic (figure plot)
plot(z,E,'LineWidth',2)
axis([0 4*lambda -2*A 2*A])
fasorE = A*exp(j*(-beta*z+phir));
plot(z,E,z,abs(fasorE),'r','LineWidth',2)
% Sets scaling for the x- and y-axes on the current plot,
% axis([xmin xmax ymin ymax])
grid
xlabel('z (m)')
ylabel('E(z,t) (V/m)')
pause

%	Calculate and draw in a loop every moment to see the movement
t=0:1/(40*f):10/f;
for n=1:length(t);
	E=A*cos(omega*t(n)-beta*z+phir);
	plot(z,E,'LineWidth',2)
    fasorE = A*exp(j*(-beta*z+phir));
    plot(z,E,z,abs(fasorE),'r','LineWidth',2)
	axis([0 4*lambda -2*A  2*A])
	grid
	title('Progressive wave');
    xlabel('z (m)')
    ylabel('E(z,t) (V/m)')
	M(:,1)=getframe;	
end


%	Average power density
Pav=(A^2*cos(angle(Z))/2/abs(Z)).*ones(1,length(z));
figure();
plot(z,Pav,'LineWidth',2)
grid
title('Average power density');
xlabel('z (m)');
ylabel('P_{av}(z) (W/m^2)');

