function PlotAllParticles(states)
    global world;
    plot(states(:,1)/(10^(-9)), states(:,2)/(10^(-9)), 'b*');
    xlim([0 world.length/(10^(-9))]);
    ylim([0 world.height/(10^(-9))]);
    xlabel('x (nm)')
    ylabel('y (nm)')
end

