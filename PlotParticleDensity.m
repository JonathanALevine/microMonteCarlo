function PlotParticleDensity(states)
    values = hist3([states(:,1), states(:,2)], [200 100], 'CdataMode','auto');
    imagesc(values.')
    colorbar
    axis equal
    axis xy
end

