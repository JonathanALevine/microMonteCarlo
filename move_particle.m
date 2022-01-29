function states = move_particle(states, scatter_particle)
    global dt k T m Pscat;
    if scatter_particle
        num_particles = length(states(:,1));
        r = rand(num_particles, 1) < Pscat;
        mu = 0;
        sigma = sqrt(2*k*T/m);
        velocity_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
        states(r,3:4) = random(velocity_pdf, [sum(r), 2]);
    end
    states(:,1) = states(:,1) + states(:,3)*dt;
    states(:,2) = states(:,2) + states(:,4)*dt;
end

