function cMap = ConductivityMap(sigma_inside, sigma_outside)
    % Define the limits of the boxes
    nx = 200;
    ny = 100;
    global boxes world;
    boxes = [nx*8/20 nx*12/20 ny*4/10 ny*6/10]; 
    cMap = zeros(nx, ny);
    for i=1:nx
        for j=1:ny
            if i > boxes(1) && i < boxes(2) & (j < boxes(3) || j > boxes(4))
                cMap(i, j) = sigma_inside;
            else
                cMap(i, j) = sigma_outside;
            end
        end
    end
end

