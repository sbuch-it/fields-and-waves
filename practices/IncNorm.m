%	M-File: IncNorm
%
%	Esta rutina representa las ondas que se forman en los medios 1 y 2
%   como resultado de la incidencia normal a la discontinuidad 
%	(propagación en z)
%	This program represents the waves formed in the mediua 1 and 2 
%	as a result of normal incidence on a flat discontinuity located at z=0
%	(incident wave propagation on Z)
%
%	Variables:
%	E0i  		amplitude of the incident wave
%	fase0d 		phase in degrees of the incident wave
%	fase0 		phase in degrees of the incident wave
%	f           frequency (Hz)
%   Z1 y Z2     intrinsic impedances for medium 1 and 2
%	omega       angular frequency (rad/s)
%	t			time instant (s)
%   gamma       propagationconstant (1/m)
%   a1 y a2     attenuation constants (Np/m)
%	lambda      wavelength (m)
%	beta		phase constant (rad/m)
%   CR          reflexión coefficient
%   CT          transmission coefficient
%	E			electric field function E(z,t)
%	z			position (m)
%   swr         standing wave ratio

clc   % clear the command window
clear % removes all variables from the workspace

%   Command input of variable values
disp('NORMAL INCIDENCE on OBSTACLES')
disp(' ')

E0i=input('Enter the amplitude of the incident wave:  ');
fase0id=input('Enter the phase of the incident wave (degrees): ');
fase0i=fase0id*pi/180;

f=input('Enter the frequency (Hz):  ');
Z1=input('Enter the intrinsic impedance of the medium 1: ');
Z2=input('Enter the intrinsic impedance of the medium 2: ');

disp(' ')

%	Initialize the variables
t=0;
mu0=4*pi*1e-7;
ep0=1e-9/36/pi;
omega=2*pi*f;

gamma1=1j*omega*mu0/Z1;
a1=real(gamma1);
beta1=imag(gamma1);
lambda1=2*pi/beta1;
gamma2=1j*omega*mu0/Z2;
a2=real(gamma2);
beta2=imag(gamma2);
lambda2=2*pi/beta2;

%	Performs calculations
zmin=min(-2*lambda1,-lambda2);
zmax=max(2*lambda2,lambda1);
z1=linspace(zmin,0,200);
z2=linspace(0,zmax,100);
CR=(Z2-Z1)/(Z2+Z1);
CT=2*Z2/(Z1+Z2);
E1=E0i*exp(-a1*z1).*cos(omega*t-beta1*z1+fase0i)+abs(CR)*E0i*exp(-a1*z1).*cos(omega*t+beta1*z1+fase0i+angle(CR));
fasor1=E0i*exp(-gamma1*z1+1j*fase0i)+abs(CR)*E0i*exp(gamma1*z1+1j*(fase0i+angle(CR)));
E2=abs(CT)*E0i*exp(-a2*z2).*cos(omega*t-beta2*z2+fase0i+angle(CT));
fasor2=abs(CT)*E0i*exp(-gamma2*z2+1j*(fase0i+angle(CT)));

%	Generates initial graphic (figure plot)
C=2*abs(E0i);
plot(z1,E1,z2,E2,'r',[0 0],[-C C],'k','LineWidth',2)
axis([zmin zmax -C C])

% axis function sets scaling for the x- and y-axes on the current plot,
% axis([xmin xmax ymin ymax])
xlabel('z(m)')
ylabel('E(z,t)')
pause

%	Calculate and draw in a loop every moment to see the movement
t=0:1/(40*f):4/f;
for n=1:160
    E1=E0i*exp(-a1*z1).*cos(omega*t(n)-beta1*z1+fase0i)+abs(CR)*E0i*exp(-a1*z1).*cos(omega*t(n)+beta1*z1+fase0i+angle(CR));
    E2=abs(CT)*E0i*exp(-a2*z2).*cos(omega*t(n)-beta2*z2+fase0i+angle(CT));
    plot(z1,E1,z2,E2,'r',[0 0],[-C C],'k',z1,[abs(fasor1);-abs(fasor1)],'k',z2,[abs(fasor2);-abs(fasor2)],'k','LineWidth',2)
    axis([zmin zmax -C C])
	xlabel('z(m)');
	ylabel('E(z,t)');
	M(:,1)=getframe;
end

grid
swr=(1+abs(CR))/(1-abs(CR));

display('Standing wave ratio: ');
display(swr);

