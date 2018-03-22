%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This functions plots fancy probplots of extreme value statistics        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-05-31  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%

function [] = maia_plotfrechplot(evaIMUstruct,IMUnumber,DOF)

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
data = evaIMUstruct.(selectedIMU).blockmax(:,DOF);

% Plot the raw data
h = figure;
grid on
hold

% Plot the distributions on probplot-paper (see functions later
maia_plotfrech(data,evaIMUstruct.(selectedIMU).blocksize,h)

% Function for Frechet Paper (x is data, h is handle to figure)
function [] = maia_plotfrech(x,blocksize,h)
lambda = 0*min(x);

F=edf(x);

u = log(F(:,1)-lambda); % This is for Frechet

v = -log(-log(F(:,2)));

p_label = [0.01 0.2 0.4 0.6 0.8 0.9 0.95 0.98 0.99 0.995 0.999];
p_return_label = (blocksize/100).*1./(1-p_label); % Return period is tau = 1/(1-p)
p_label_inv = -log(-log(p_label));

x_label_inv = linspace(min(u),max(u),6);
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
text(0.98,0.05,strcat('R^2: ',' ',num2str(gof.rsquare)),'Units','normalized','HorizontalAlignment','right','FontSize',10)

a = f.p1;
b = f.p2;

CI = confint(f);

vf = a.*u + b;
vb = CI(1,1).*u + CI(1,2);
vc = CI(2,1).*u + CI(2,2);

yyaxis right
h=plot(u,vf,'r-');
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
