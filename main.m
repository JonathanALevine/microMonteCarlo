close all;  
clear; %intialization
set(0,'DefaultFigureWindowStyle','docked')
config; % load the simulation configurations
states = GenerateStates(num_particles, distribution_type);
run(states, epochs);