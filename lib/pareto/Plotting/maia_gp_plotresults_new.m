close all

C = linspecer(2);

maia_gp_dircolbars;

figure
plot(timevect,data_port,'Color',C(1,:)','LineWidth',1)
hold
plot(timevect,data_sb,':','Color',C(2,:)','LineWidth',1)
datetick
%xlabel('Time (HH:mm)')
%ylabel('$A_{vib}^b=\sqrt{{f_{i{s_j},HP,x}^2}^2+{f_{i{s_j},HP,y}^2}$','Interpreter','latex')
title('Vibration data')
ylabel('$A_{vib}^b$ (m$\cdot$s$^{-2}$)','Interpreter','latex')
legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
set(gca,'FontSize',12,'FontName','Times New Roman')
hold

figure
subplot 211
plot(gp_port.matdatenum,gp_port.estimate(:,1),'Color',C(1,:)','LineWidth',2)
hold
plot(gp_sb.matdatenum,gp_sb.estimate(:,1),':','Color',C(2,:)','LineWidth',2)
datetick
%xlabel('Time (HH:mm)')
title('Parameter estimates')
ylabel('$\hat{\xi}$','Interpreter','latex')
%legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
set(gca,'FontSize',12,'FontName','Times New Roman')
hold

subplot 212
plot(gp_port.matdatenum,gp_port.estimate(:,2),'Color',C(1,:)','LineWidth',2)
hold
plot(gp_sb.matdatenum,gp_sb.estimate(:,2),':','Color',C(2,:)','LineWidth',2)
datetick
%xlabel('Time (HH:mm)')
ylabel('$\hat{\sigma}$','Interpreter','latex')
%legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
set(gca,'FontSize',12,'FontName','Times New Roman')
hold

% figure
% subplot(3,1,[1,2])
% plot(gp_port.matdatenum,gp_port.returnlevel15u,'Color',C(1,:)','LineWidth',2)
% hold
% plot(gp_sb.matdatenum,gp_sb.returnlevel15u,':','Color',C(2,:)','LineWidth',2)
% hold
% ylabel({'Probability of','exceeding 1.5u'})
% yTack = [0.001 0.2 0.4 0.6 0.8 0.999];
% set(gca,'YLim',[0.0001 1.0]);
% set(gca,'YTick',yTack);
% set(gca,'YTicklabel',yTack);
% set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
% grid on
% set(gca,'FontSize',12,'FontName','Times New Roman')
% title('Ice drift detection')
% datetick

figure
subplot(3,1,[1,2])
plot(gp_port.matdatenum,gp_port.exceedlevel50-gp_port.threshold,'Color',C(1,:)','LineWidth',2)
hold
plot(gp_sb.matdatenum,gp_sb.exceedlevel50-gp_port.threshold,':','Color',C(2,:)','LineWidth',2)
hold
ylabel({'50% exceedance';'level x_m (m\cdot s^{-2})'})
set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
set(gca,'FontSize',12,'FontName','Times New Roman')
title('Ice drift detection (return level)')
datetick

subplot(3,1,3)
heatmap(directionesti');
ylabel({'Side of';'ice action'})
set(gca,'FontSize',12,'FontName','Times New Roman')

figure
subplot(3,1,[1,2])
plot(gp_port.matdatenum,gp_port.entropy,'Color',C(1,:)','LineWidth',2)
hold
plot(gp_sb.matdatenum,gp_sb.entropy,':','Color',C(2,:)','LineWidth',2)
hold
ylabel({'Statistical Entropy'})
set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
set(gca,'FontSize',12,'FontName','Times New Roman')
title('Ice drift detection (entropy)')
datetick

subplot(3,1,3)
heatmap(directionestientropy');
ylabel({'Side of';'ice action'})
set(gca,'FontSize',12,'FontName','Times New Roman')

figure
plot(zeitvektor(2:end-1),bodyDrift(2:end-1),'k','LineWidth',1);
hold
plot(zeitvektor(2:end-1),bodyDrift2(2:end-1),'r--','LineWidth',1);
datetick
grid on
title('Ice drift direction reference (in body frame)')
ylabel({'Ice Drift (^\circ)'})
set(gca,'FontSize',12,'FontName','Times New Roman')
