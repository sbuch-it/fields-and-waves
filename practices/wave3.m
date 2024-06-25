%	M-File: wave3
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
mu0=4*pi*1e-7;
ep0=1e-9/36/pi;
A=5;
t=0;
alfa=0.2;
beta=0.2;
sigma=2.5;
f=alfa^2/(pi*mu0*sigma);
ep_r=2;
phi=0;

%   Previous calculations
phir=phi*pi/180;
omega=2*pi*f;
Z=sqrt(1j*omega*mu0/(sigma+1j*omega*ep_r*ep0)); % Good conductor approach
gamma=1j*omega*mu0/Z;
alfa=real(gamma);
beta=imag(gamma);
gamma = alfa + j*beta;
c=omega/beta;
lambda=2*pi/beta;

%	Performs the calculation of E(z,t)
z=0:4*lambda/100:4*lambda;
E=A.*exp(-alfa*z).*cos(omega*t-beta*z+phir);
fasor=A*exp(-alfa*z+1j*(-beta*z+phir));

%	Generates initial graphic (figure plot)
plot(z,E,z,abs(fasor),'LineWidth',2)
axis([0 4*lambda -2*A 2*A])
% Sets scaling for the x- and y-axes on the current plot,
% axis([xmin xmax ymin ymax])
grid
xlabel('z (m)')
ylabel('E(z,t) (V/m)')
pause

%	Calculate and draw in a loop every moment to see the movement
t=0:1/(100*f):4/f;
for n=1:length(t);
	E=A.*exp(-alfa*z).*cos(omega*t(n)-beta*z+phir);
	plot(z,E,z,abs(fasor),'LineWidth',2)
	axis([0 4*lambda -2*A  2*A])
	grid
	title('Progressive wave within a medium with losses');
    xlabel('z (m)')
    ylabel('E(z,t) (V/m)')
	M(:,1)=getframe;	
end

%   Average power density
Pav=A^2*exp(-2*alfa*z)*cos(angle(Z))/2/abs(Z);
figure
plot(z,Pav,'LineWidth',2)
grid
title('Average power density');
xlabel('z (m)');
ylabel('P_{av}(z) (W/m^2)');

