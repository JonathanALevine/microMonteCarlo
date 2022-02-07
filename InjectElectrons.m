function states = InjectElectrons(states, epoch)
    global world;
    global vth;
    global k m T;
    
    num_particles = length(states);
    
    mu = 0;
    sigma = sqrt(k*T/m);
    velocity_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
    initialx = 20*10^(-9);
    initialy = world.height/2;
    
    if isnan(states(epoch))
        vx = abs(random(velocity_pdf));
        vy = random(velocity_pdf);
        temperature = GetTemperature(vx, vy);
        states(epoch,:) = [initialx initialy vx vy temperature];
    end
end

