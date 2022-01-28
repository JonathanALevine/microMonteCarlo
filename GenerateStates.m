function states = GenerateStates(num_particles)
    global box;
    global vth;
    
    states = zeros(num_particles, 5);
    
    for i=1:num_particles
        angle = rand*2*pi;
        vx = vth*cos(angle);
        vy = vth*sin(angle);
        temperature = GetTemperature(vx, vy);
        states(i,:) = [box.length*rand box.height*rand vth*cos(angle) vth*sin(angle) temperature];
    end
    
end

