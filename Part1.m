close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Constants
global m0 m T k tau;
m0 = 9.10938356*10^(-31); %Electron rest mass
m = 0.26*m0; 
T = 300;
k = 1.38064852*10^(-23); %Boltzmann Constant
tau = 0.2*10^(-12);

global vth;
vth = sqrt(2*k*T/m);

% The mean free path = velocity*mean time between collisions
MFP = vth * tau;

% Simulation controls
global world;
world.length = 200*10^(-9);
world.height = 100*10^(-9);

num_particles = 1000;
traced_particles = 10;
distribution_type = nan;
scatter_particle = 0;

global dt;
dt = world.height/vth/100;
epochs = 1000;

show_all_particles = 1;
save_plots = 0;

% Generate the states
states = GenerateStates(num_particles, distribution_type);

temperatures = zeros(epochs, 1);

for epoch = 1:epochs
    % Plot the positions of the particles
    figure(1)
    % Plot the positions of the particles
    if show_all_particles
        PlotAllParticles(states);
    else
        for n = 1:traced_particles
            xValues(epoch, n) = states(n:n,1).';
            yValues(epoch, n) = states(n:n,2).';
        end
        plot(xValues/10^(-9), yValues/10^(-9), '.')
        xlim([0 world.length/(10^(-9))]);
        ylim([0 world.height/(10^(-9))]);
        xlabel('x (nm)')
        ylabel('y (nm)')
    end
    % Check the boundary conditions of the particles
    states = WorldBoundaryHandler(states, 0);
    % Move the particle
    states = MoveParticle(states);
    % Get thesemi conductor temperature at this time step
    temperatures(epoch) = mean(states(:,5));
    
    pause (0.01)
end

if save_plots
    FN2 = 'Figures/Part 1 Particle Trajectories';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

    figure(2)
    plot(temperatures)
    xlabel('Time (1/100 sec)')
    ylabel('Temperature (K)') 

    FN2 = 'Figures/Part 1 Temperature Plot';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

