function states = move_particle(states)
    global dt;
    states(:,1) = states(:,1) + states(:,3)*dt;
    states(:,2) = states(:,2) + states(:,4)*dt;
end

