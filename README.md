# microMonteCarlo

![Monte Carlo simulation with scattering on](scattering_on.gif)
A micro project for playing around with Monte Carlo simulations. 
This project was initially for simulating Electron Transport using Monte Carlo techniques.



### Installation
Provide instructions on how to install and run your project. For example:

### Example usage
Scattering disabled for the electrons

![Monte Carlo simulation with scattering on](scattering_off.gif)
```matlab
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
epochs = 250;
Pscat = 1 - exp(-dt/tau);
% Simulation controls
num_particles = 250;
distribution_type = 'MB';
scattering = 0;
```

### Features
List down the features of your project here. For example:
- Electron movement under an electric field is implemented in `Part5.m` in 
[legacy](https://github.com/JonathanALevine/microMonteCarlo/tree/legacy).
Work is ongoing at tranferring this to [main](https://github.com/JonathanALevine/microMonteCarlo). 
PR's are welcome if you would like to implement this. 
- Feature 2
- Feature 3


