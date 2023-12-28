close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Constants
global m0 m T k tau Pscat dt;
m0 = 9.10938356*10^(-31); %Electron rest mass
m = 0.26*m0; 
T = 300;
k = 1.38064852*10^(-23); %Boltzmann Constant
tau = 0.2*10^(-12);

global world;
world.length = 400*10^(-9);
world.height = 200*10^(-9);

global vth;
vth = sqrt(2*k*T/m);

global dt;
dt = world.height/vth/100;

epochs = 1000;

Pscat = 1 - exp(-dt/tau);

% The mean free path = velocity*mean time between collisions
MFP = vth * tau;

% Simulation controls
num_particles = 100;
distribution_type = 'MB';
epochs = 1000;
scattering = 1;

% generate the initial states of all the particles
states = GenerateStates(num_particles, distribution_type);

for epoch = 1:epochs
    figure(1)
    % plot the particles in the world
    PlotAllParticles(states);
    states = WorldBoundaryHandler(states, 1);
    % handle scattering
    if scattering
        states = ScatterParticle(states);
    end
    % move the particles
    states = MoveParticle(states);
    % print the epoch in terminal
    epoch
    pause(0.01);
end




