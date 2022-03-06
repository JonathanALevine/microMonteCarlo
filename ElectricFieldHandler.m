function states = ElectricFieldHandler(states)
    global Vx Vy m world qe dt;
    % Get the electric field from the potential and world 
    % size
    Ex = Vx/world.length;
    Ey = Vy/world.height;
    Fx = qe*Ex;
    Fy = qe*Ey;
    ax = Fx/m;
    ay = Fy/m;
    states(:, 3) = states(:, 3) + ax*dt;
    states(:, 4) = states(:, 4) + ay*dt;
end

