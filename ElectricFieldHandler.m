function states = ElectricFieldHandler(states)
    % UPDATES VX AND VY FROM AX AND AY FROM ELECTRICFIELD
    global Vx Vy m world qe dt;
    % Get the electric field from the potential and world 
    % size
    Ex = Vx/world.length;
    Ey = Vy/world.height;
    Fx = qe*Ex;
    Fy = qe*Ey;
    ax = Fx/m;
    ay = Fy/m;
    states(:, 6) = ax;
    states(:, 7) = ay;
end

