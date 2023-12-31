% Constants
global m0 m T k tau Pscat dt epochs;
global num_particles distribution_type scattering;
global vth;
global world;
global dt;

m0 = 9.10938356*10^(-31); %Electron rest mass
m = 0.26*m0;
T = 300; % temperature in kelvin
k = 1.38064852*10^(-23); %Boltzmann Constant
tau = 0.2*10^(-12);
world.length = 400*10^(-9);
world.height = 200*10^(-9);
vth = sqrt(2*k*T/m);
dt = world.height/vth/100;
epochs = 1000;
Pscat = 1 - exp(-dt/tau);
% Simulation controls
num_particles = 100;
distribution_type = 'MB';
epochs = 1000;
scattering = 1;