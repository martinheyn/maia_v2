%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This functions plots fancy probplots of extreme value statistics        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-05-31  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%

function [] = maia_plotfrechplotssurgesway_meraccl(evaIMUstruct,IMUnumber)

% Which IMU is used?
switch IMUnumber
    case 1
        selectedIMU = 'IMU1';
    case 2
        selectedIMU = 'IMU2';
    case 3
        selectedIMU = 'IMU3';
    case 4
        selectedIMU = 'IMU4';
    case 5
        selectedIMU = 'IMU5';
end

% Find the data in the eva-struct (ExtremeValueAnalysis)
datasurge = evaIMUstruct.(selectedIMU).blockmax(:,1);
datasway = evaIMUstruct.(selectedIMU).blockmax(:,2);

% Plot the raw data
h = figure;
grid on
hold

% Plot the distributions on probplot-paper (see functions later
maia_plotfrech_surge(datasurge,evaIMUstruct.(selectedIMU).blocksize,h)
maia_plotfrech_sway(datasway,evaIMUstruct.(selectedIMU).blocksize,h)

legend('Extreme values of a_x (surge)','Extreme values of a_y (sway)')

% Function for Frechet Paper (x is data, h is handle to figure)

end

function [] = maia_plotfrech_surge(x,blocksize,h)
lambda = 0*min(x);

F=edf(x);

u = log(F(:,1)-lambda);
v = -log(-log(F(:,2)));
maxu = log(20-lambda);

p_label = [0.01 0.2 0.4 0.6 0.8 0.9 0.95 0.98 0.99 0.995 0.999 0.9995];
p_return_label = (blocksize/100).*1./(1-p_label); % Return period is tau = 1/(1-p)
p_label_inv = -log(-log(p_label));

x_label_inv = linspace(min(u),maxu,8);
x_label = round((exp(x_label_inv)+lambda),3);

yyaxis left
h=plot(u,v,'b.','markersize',12);
hold on
grid on

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Probability')

[f,gof] = fit(u,v,'poly1');
text(0.98,0.10,strcat('R^2 for surge: ',' ',num2str(gof.rsquare)),'Units','normalized','HorizontalAlignment','right','FontSize',10,'Color','b')

a = f.p1;
b = f.p2;

CI = confint(f);
o = linspace(0.1,20,100);
ou = log(o-lambda);

vf = a.*ou + b;
vb = CI(1,1).*u + CI(1,2);
vc = CI(2,1).*u + CI(2,2);

yyaxis right
h=plot(ou,vf,'b-');
%h=plot(u,vb,'k--');
%h=plot(u,vc,'k--');

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_return_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Return Period [s]')

title('Frechet Probability Plot')
xlabel('Acceleration [m/s^2]')
end

function [] = maia_plotfrech_sway(x,blocksize,h)
lambda = 0*min(x);

F=edf(x);

u = log(F(:,1)-lambda);
v = -log(-log(F(:,2)));
maxu = log(20-lambda);

p_label = [0.01 0.2 0.4 0.6 0.8 0.9 0.95 0.98 0.99 0.995 0.999 0.9995];
p_return_label = (blocksize/100).*1./(1-p_label); % Return period is tau = 1/(1-p)
p_label_inv = -log(-log(p_label));

x_label_inv = linspace(min(u),maxu,8);
x_label = round((exp(x_label_inv)+lambda),3);

yyaxis left
h=plot(u,v,'r.','markersize',12);
hold on
grid on

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Probability')

[f,gof] = fit(u,v,'poly1');
text(0.98,0.05,strcat('R^2 for sway: ',' ',num2str(gof.rsquare)),'Units','normalized','HorizontalAlignment','right','FontSize',10,'Color','r')

a = f.p1;
b = f.p2;

CI = confint(f);
o = linspace(0.1,20,100);
ou = log(o-lambda);

vf = a.*ou + b;
vb = CI(1,1).*u + CI(1,2);
vc = CI(2,1).*u + CI(2,2);

yyaxis right
h=plot(ou,vf,'r-');
%h=plot(u,vb,'k--');
%h=plot(u,vc,'k--');

set(gca,'YTick',p_label_inv);
set(gca,'YTicklabel',p_return_label);
set(gca,'YLim',[-log(-log(0.005)) -log(-log(0.9995))])
set(gca,'YColor',[0 0 0])
set(gca,'XTick',x_label_inv);
set(gca,'XTicklabel',x_label);
ylabel('Return Period [s]')

title('Frechet Probability Plot')
xlabel('Acceleration [m/s^2]')
end