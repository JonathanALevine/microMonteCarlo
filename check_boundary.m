function states = check_boundary(states)
    global box;

    indices = states(:,1) > box.length;
    states(indices,1) = states(indices,1) - box.length;
    
    indices = states(:,1) < 0;
    states(indices,1) = states(indices,1) + box.length;
    
    indices = states(:,2) > box.height;
    states(indices,4) = -states(indices,4);
    
    indices = states(:,2) < 0;
    states(indices,4) = -states(indices,4);
    
end

