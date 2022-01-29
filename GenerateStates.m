function states = GenerateStates(num_particles, distribution_type)
    global box;
    global vth;
    global k m T;
    
    states = zeros(num_particles, 5);
    
    if distribution_type == 'MB'
        mu = 0;
        sigma = sqrt(k*T/m);
        velocity_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
        for i=1:num_particles
            vx = random(velocity_pdf);
            vy = random(velocity_pdf);
            temperature = GetTemperature(vx, vy);
            states(i,:) = [box.length*rand box.height*rand random(velocity_pdf) random(velocity_pdf) temperature];
        end
    else
        for i=1:num_particles
            angle = rand*2*pi;
            vx = vth*cos(angle);
            vy = vth*sin(angle);
            temperature = GetTemperature(vx, vy);
            states(i,:) = [box.length*rand box.height*rand vth*cos(angle) vth*sin(angle) temperature];
        end    
    end
        
    
end

