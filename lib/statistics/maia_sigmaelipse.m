function[] = maia_sigmaelipse(xy,color,h)

conf = 0.95;

n = size(xy,1);
mxy = mean(xy);

numPts = 1800; % The number of points in the ellipse.
th = linspace(0,2*pi,numPts)';


p = 2; % Dimensionality of the data, 2-D in this case.

k = finv(conf,p,n-p)*p*(n-1)/(n-p);

[pc,score,lat] = princomp(xy);


ab = diag(sqrt(k*lat));
exy = [cos(th),sin(th)]*ab*pc' + repmat(mxy,numPts,1);

% Add ellipse to current plot
h = line(exy(:,1),exy(:,2),'Clipping','off','Color',color,'LineWidth',2);

end