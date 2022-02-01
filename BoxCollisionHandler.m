function states = BoxCollisionHandler(states)
    

    left_wall = 80*10^(-9);
    right_wall = 120*10^(-9);
    top_wall = 40*10^(-9);
    
    indices =  states(:,1) >= left_wall*0.99 & states(:, 1) <= left_wall*1.01;
    states(indices, 3) = -states(indices, 3);
    
    indices =  states(:,1) >= right_wall*0.99 & states(:, 1) <= right_wall*1.01;
    states(indices, 3) = -states(indices, 3);
    
    indices = states(:,1) > left_wall & states(:,1) < right_wall & states(:,2) >= top_wall*0.99 & states(:,2) <= top_wall*1.01;
    states(indices, 4) = -states(indices, 4);

end

