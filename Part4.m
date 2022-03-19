close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Constants
global m0 m T k tau qe Vx Vy Pscat rho;
m0 = 9.10938356*10^(-31); %Electron rest mass
m = 0.26*m0; 
T = 300;
k = 1.38064852*10^(-23); %Boltzmann Constant
tau = 0.2*10^(-12);
qe = 1.60217662*10^(-19); % Electron charge
rho = 10^(19); %Electron concentration in m^(-2)

% Simulation controls
global world;
world.length = 200*10^(-9);
world.height = 100*10^(-9);

% Voltage in the x and y directions
Vx = 0.1;
Vy = 0;

Ex = Vx/world.length;
Ey = Vy/world.height;
Fx = qe*Ex;
Fy = qe*Ey;
ax = Fx/m;
ay = Fy/m;

global vth;
vth = sqrt(2*k*T/m);

% The mean free path = velocity*mean time between collisions
MFP = vth * tau;

% Simulation Controls
num_particles = 10000;
traced_particles = 10;
distribution_type = 'MB';
epochs = 1000;
show_all_particles = 0;
save_plots = 0;
scatter_particle = 1;
bottleneck = 0;

global dt;
dt = world.height/vth/100;
Pscat = 1 - exp(-dt/tau);

% Generate the states
states = GenerateStates(num_particles, distribution_type);
figure('name', 'v_x histogram')
histogram(states(:,3))
xlabel('V_x (m/s)')
ylabel('Count')

temperatures = zeros(epochs, 1);
DriftCurrents = zeros(epochs, 1);

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
    % Scatter the particle
    states = ScatterParticle(states);
    % Update the states based on the electric field
    states = ElectricFieldHandler(states);
    % Move the particle
    states = MoveParticle(states);
    % Get the semi conductor temperature at this time step
    temperatures(epoch) = mean(states(:,5));
    % Get the electron drift current
    DriftCurrents(epoch) = GetDriftCurrent(states);
    
    epoch/epochs * 100
    pause (0.01)
end

if save_plots
    FN2 = 'Figures/Assignment3/Part1 - Particle Trajectories';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

figure(2)
plot(DriftCurrents*10^3)
xlabel('Time (1/100 sec)')
ylabel('Current (mA)') 
if save_plots
    FN2 = 'Figures/Assignment3/Part1 - Drift Current';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end   
    
figure(3)
PlotParticleDensity(states)
if save_plots
    FN2 = 'Figures/Assignment3/Part1 - Particle Density Map';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

figure(4)
PlotTemperatureMap(states)
if save_plots
    FN2 = 'Figures/Assignment3/Part1 - Temperature Map';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end