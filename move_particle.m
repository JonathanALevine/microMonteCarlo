function states = move_particle(states, scatter_particle)
    global dt;
    states(:,1) = states(:,1) + states(:,3)*dt;
    states(:,2) = states(:,2) + states(:,4)*dt;
    states(:,5) = GetTemperature(states(:,3), states(:,4));
end

