function[MeanVec,CovMatrix,Mu] = plotbivariate(data,h)

MeanVec = zeros(1,2);
CovMatrix = zeros(2);
Mu = 0;

[MeanVec,CovMatrix,Mu] = fitt(data);
%CovMatrix = sqrt(CovMatrix);

% Plot ellipse
Samples = data;
 
%Get the sigma ellipses by transform a circle by the cholesky decomp
L = chol(CovMatrix,'lower');
t = linspace(0,2*pi,100); %Our ellipse will have 100 points on it
%set(0,'DefaultAxesFontName', 'Times New Roman')
%set(0,'DefaultAxesFontSize', 36)

C = [cos(t); sin(t)]; %A unit circle
E1 = 1*L*C; E2 = 2*L*C; E3 = 3*L*C; %Get the 1,2, and 3-sigma ellipses
E3(1,:) = E3(1,:) + MeanVec(1);
E3(2,:) = E3(2,:) + MeanVec(2);

%Plot the samples on the "floor"
%plot3(Samples(:,1),Samples(:,2),zeros(size(Samples,1),1),'k.','MarkerSize',2)
%clf(h)
h = plot(Samples(:,1),Samples(:,2),'k.','MarkerSize',3)
hold on
%Plot the 1,2, and 3-sigma ellipses slightly above the floor
%plot3(E1(1,:), E1(2,:), 1e-3+zeros(1,size(E1,2)),'Color','g','LineWidth',2);
h = plot(E3(1,:), E3(2,:),'Color','g','LineWidth',2);
dim = [.2 .5 .3 .3];
axis([-0.5 0.5 -0.5 0.5])
hold off
%plot3(E3(1,:), E3(2,:), 1e-3+zeros(1,size(E3,2)),'Color','g','LineWidth',2);
 
%Plot the histograms on the walls from the data in the middle
% [n_x, xout] = hist(Samples(:,1),20);%Creates 20 bars
% n_x = n_x ./ ( sum(n_x) *(xout(2)-xout(1)));%Normalizes to be a pdf
% [~,~,~,x_Pos,x_Height] = makebars(xout,n_x);%Creates the bar points
% plot3(x_Pos, Y(end)*ones(size(x_Pos)),x_Height,'-k')
%  
% %Now plot the other histograms on the wall
% [n_y, yout] = hist(Samples(:,2),20);
% n_y = n_y ./ ( sum(n_y) *(yout(2)-yout(1)));
% [~,~,~,y_Pos,y_Height] = makebars(yout,n_y);
% plot3(X(1)*ones(size(y_Pos)),y_Pos, y_Height,'-k')
%  
% %Now plot the 1-d pdfs over the histograms
% plot3(X, ones(size(X))*Y(end), Z_x,'-b','LineWidth',2); 
% plot3(ones(size(Y))*X(1), Y, Z_y,'-r','LineWidth',2);
%  
%Make the figure look nice
% grid on; view(45,55);
%axis([X(1) X(end) Y(1) Y(end)])
%pause(0.005)
end