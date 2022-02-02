function PlotBoxes()
    % Plot the first box
    hold on
    plot([80 120], [0.4 0.4].*100, 'k')
    plot([80 80], [0 0.4].*100, 'k')
    plot([120 120], [0 0.4].*100, 'k')
    % Plot the second box
    plot([80 120], [0.6 0.6].*100, 'k')
    plot([80 80], [1 0.6].*100, 'k')
    plot([120 120], [1 0.6].*100, 'k')
    hold off
end

