%	M-File: wave4
%
%	This program represents the general solution of the wave equation
%	(variation along Z) in a lossless medium
%
%	Variables:
%	A and B     initial amplitudes of the progressive waves
%	phase1d     phase in degrees of the wave +z
%	phase2d     phase in degrees of the wave -z
%	f           frequency (Hz)
%	omega       angular frequency (rad/s)
%   t           time instant (s)
%	ep_r        relative permittivity of the medium
%   lambda      wavelength (m)
%   beta        phase constant (1/m)
%   E           electric field function E(z,t)
%   z           position (m)

clc   % clear the command window
clear % removes all variables from the workspace

%   Command input of variable values
disp('General solution of the wave equation')
disp('(Lossless medium)')
disp(' ')

E01=input('enter the amplitude of A:  ');
fase1d=input('enter the phase of A (degrees): ');
fase1=fase1d*pi/180;

E02=input('enter the amplitude of B:  ');
fase2d=input('enter the phase of B (degrees): ');
fase2=fase2d*pi/180;

f=input('enter the frequency (Hz):  ');
ep_r=input('enter the relative permittivity of the medium: ');

disp(' ')


%	Initialize the variables
t=0;
c=3e8/sqrt(ep_r);
lambda=c/f;
beta=2*pi/lambda;
omega=2*pi*f;

%	Performs the calculation of E(z,t)
zmax=2*lambda;
z=0:zmax/200:zmax;
E=E01*cos(omega*t-beta*z+fase1)+E02*cos(omega*t+beta*z+fase2);
fasor=E01*exp(1j*(-beta*z+fase1))+E02*exp(1j*(beta*z+fase2));

%	Generates initial graphic (figure plot)
plot(z,E,'LineWidth',2)
C=abs(E01)+abs(E02);
axis([0 zmax -C C])
% axis function sets scaling for the x- and y-axes on the current plot,
% axis([xmin xmax ymin ymax])
grid
xlabel('z(m)')
ylabel('E(z,t)')
pause

%	Calculate and draw in a loop every moment to see the movement
t=0:1/(40*f):10/f;
for n=1:length(t);
    E=E01*cos(omega*t(n)-beta*z+fase1)+E02*cos(omega*t(n)+beta*z+fase2);
	plot(z,E,z,abs(fasor),'k',z,-abs(fasor),'k--','LineWidth',2)
    axis([0 2*lambda -C C])
	grid
	xlabel('z(m)');
	ylabel('E(z,t)');
	M(:,1)=getframe;	
end

