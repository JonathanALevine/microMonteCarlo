function run(states, epochs)
    figure(1)
    for epoch = 1:epochs
        % plot the particles in the world
        PlotAllParticles(states);
        states = WorldBoundaryHandler(states, 1);
        % handle scattering
        states = ScatterParticle(states);
        states = MoveParticle(states); % move the particles
        epoch % print the epoch in terminal
        pause(0.01);
    end
end

