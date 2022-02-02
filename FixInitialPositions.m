function states = FixInitialPositions(states)
    num_particles = length(states(:,1));
    left_wall = 80*10^(-9);
    right_wall = 120*10^(-9);
    for i=1:num_particles
        if (states(i, 1) >= left_wall & states(i, 1) <= right_wall)
            states(i, 1) = states(i, 1) + left_wall;
        end
    end
end

