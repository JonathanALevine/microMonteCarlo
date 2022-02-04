function PlotTemperatureMap(states)
    x = states(:,1);
    y = states(:,2);
    xx = linspace(min(x), max(x), 400);
    yy = linspace(min(y), max(y), 200);
    [X, Y] = meshgrid(xx, yy);
    Z = griddata(x, y, states(:,5), X, Y);
    image = imboxfilt(Z, 5);
    imagesc(image)
    c = colorbar;
    c.Label.String = 'Particle Temperature (K)';
    xlabel('x (nm)');
    ylabel('y (nm)');
    view(2);
end

