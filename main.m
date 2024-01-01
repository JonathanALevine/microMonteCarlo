close all;  
clear; %intialization
set(0,'DefaultFigureWindowStyle','docked')
config; % load the simulation configurations
global vw;
states = GenerateStates(num_particles, distribution_type);
vw = VideoWriter('scattering_off.avi');
vw.FrameRate = 30;
open(vw);
run(states, epochs);
close(vw)