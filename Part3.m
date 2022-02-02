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
epochs = 1000;
show_all_particles = 1;
save_plots = 1;
scatter_particle = 1;
bottleneck = 1;
bottlenecks = 1e-9.*[80 120 0 40; 80 120 60 100];

% Generate the states
states = GenerateStates(num_particles, distribution_type);
states = FixInitialPositions(states);

% Get the mean speed
mean_speed = sqrt(mean(states(:,3).^2 + states(:,4).^2));

temperatures = zeros(epochs, 1);

figure(2)
for epoch = 1:epochs
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
    states = WorldBoundaryHandler(states);
    % Handle the collisions with the boxes
    states = BoxCollisionHandler(states);
    % scatter particle if selected scatter_particle=1
    if scatter_particle
        states = ScatterParticle(states);
    end
    % Move the particle
    states = move_particle(states, scatter_particle);
    % Get the semiconductor temperature at this time step
    temperatures(epoch) = mean(states(:,5));
    epoch
    pause (0.01)
end

if bottleneck
    hold on
    % Plot the first box
    plot([80 120], [0.4 0.4].*100, 'k')
    plot([80 80], [0 0.4].*100, 'k')
    plot([120 120], [0 0.4].*100, 'k')
    % Plot the second box
    plot([80 120], [0.6 0.6].*100, 'k')
    plot([80 80], [1 0.6].*100, 'k')
    plot([120 120], [1 0.6].*100, 'k')
    hold off
end

figure(3)
values = hist3([states(:,1), states(:,2)], [200 100], 'CdataMode','auto');
imagesc(values.')
colorbar
axis equal
axis xy

% % if save_plots
% %     FN2 = 'Part 2 Particle Trajectories';   
% %     print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
% % 
% %     figure(3)
% %     plot(temperatures)
% %     xlabel('Time (1/100 sec)')
% %     ylabel('Temperature (K)')
% %     ylim([min(temperatures)*0.98 max(temperatures)*1.02])
% % 
% %     FN2 = 'Part 2 Temperature Plot';   
% %     print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
% %     
% %     figure(4)
% %     histogram(sqrt(states(:,3).^2 + states(:,4).^2))
% %     FN2 = 'Histogram of Final Particle Speeds';   
% %     print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
% % end


