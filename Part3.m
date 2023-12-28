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

dt = world.height/vth/1000;
Pscat = 1 - exp(-dt/tau);

% The mean free path = velocity*mean time between collisions
MFP = vth * tau;

% Simulation Controls
num_particles = 10000;
traced_particles = 10;
distribution_type = 'MB';
epochs = 10000;
show_all_particles = 0;
save_plots = 0;
scatter_particle = 1;
bottleneck = 1;
inject_electrons = 1;

% Generate the states
if ~inject_electrons
    states = GenerateStates(num_particles, distribution_type);
    states = FixInitialPositions(states);
else
    states = NaN(num_particles, 5); 
end

% Get the mean speed
try
    mean_speed = sqrt(mean(states(:,3).^2 + states(:,4).^2));
catch
    warning('Empty set')
end

temperatures = zeros(epochs, 1);

figure(1)
for epoch = 1:epochs
    % Inject electrons from the left with thermalized velocities
    if (epoch >= 10 & epoch <= 1000) & inject_electrons 
        states = InjectElectrons(states, epoch);
    end
    % Plot the positions of the particles
    subplot(2, 1, 1)
    PlotAllParticles(states)
    subplot(2, 1, 2)
    for n = 1:traced_particles
        xValues(epoch, n) = states(n+10:n+10,1).';
        yValues(epoch, n) = states(n+10:n+10,2).';
    end
    plot(xValues/10^(-9), yValues/10^(-9), '.')
    xlim([0 world.length/(10^(-9))]);
    ylim([0 world.height/(10^(-9))]);
    xlabel('x (nm)')
    ylabel('y (nm)')
    % Check the boundary conditions of the particles
    states = WorldBoundaryHandler(states, 1);
    % Handle the collisions with the boxes
    states = BoxCollisionHandler(states);
    % scatter particle if selected scatter_particle=1
    if scatter_particle
        states = ScatterParticle(states);
    end
    % Move the particle
    states = MoveParticle(states);
    % Get the semiconductor temperature at this time step
    temperatures(epoch) = mean(states(:,5));
    epoch
    pause (0.01)
end

if bottleneck
    PlotBoxes;
end

if save_plots
    FN2 = 'Figures/Part 3 Particle Trajectories from Injection';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

figure(2)
PlotParticleDensity(states)
if save_plots
    FN2 = 'Figures/ParticleDensityMap From Injection';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

figure(3)
PlotTemperatureMap(states)
if save_plots
    FN2 = 'Figures/TemperatureMap From Injection';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end



