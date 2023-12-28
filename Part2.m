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
world.length = 200*10^(-9);
world.height = 100*10^(-9);

global vth;
vth = sqrt(2*k*T/m);

dt = world.height/vth/100;
Pscat = 1 - exp(-dt/tau);

% The mean free path = velocity*mean time between collisions
MFP = vth * tau;

% Simulation Controls
num_particles = 1000;
traced_particles = 10;
distribution_type = 'MB';
epochs = 500;
show_all_particles = 0;
scatter = 1;
bottleneck = 0;

% Generate the states
states = GenerateStates(num_particles, distribution_type);
% Remove particles that spawn inside the boxes
if bottleneck
    states = FixInitialPositions(states);
end

% Get the mean speed
mean_speed = sqrt(mean(states(:,3).^2 + states(:,4).^2));
temperatures = zeros(epochs, 1);

for epoch = 1:epochs
    % Plot the positions of the particles
    figure(1)
    % Plot the positions of the particles
    PlotAllParticles(states)
    xlim([0 world.length/(10^(-9))]);
    ylim([0 world.height/(10^(-9))]);
    xlabel('x (nm)')
    ylabel('y (nm)')
    % Check the boundary conditions of the particles
    states = WorldBoundaryHandler(states, 1);
    if bottleneck
        states = BoxCollisionHandler(states);
    end
    if scatter
        states = ScatterParticle(states);
    end
    states = MoveParticle(states);
    % Get the semiconductor temperature at this time step
    temperatures(epoch) = mean(states(:,5));
    epoch
    pause (0.01)
end

if bottleneck
    PlotBoxes;
end

