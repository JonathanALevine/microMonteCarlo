function states = WorldBoundaryHandler(states)
    global world;

    indices = states(:,1) > world.length;
    states(indices,1) = states(indices,1) - world.length;
    
    indices = states(:,1) < 0;
    states(indices,1) = states(indices,1) + world.length;
    
    indices = states(:,2) > world.height;
    states(indices,4) = -states(indices,4);
    states(indices, 2) = world.height;
    
    indices = states(:,2) < 0;
    states(indices,4) = -states(indices,4);
    states(indices,2) = 0;
    
end

