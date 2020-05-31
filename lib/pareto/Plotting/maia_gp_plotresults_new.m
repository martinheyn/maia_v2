close all

C = linspecer(2);

colmap = [1,1,1;0,0.45,0.74;0.92,0.28,0.29;1,1,0];

maia_gp_dircolbars;

[directionestifilt] = maia_gp_meanfiltered(directionesti,400);
[directionestientropyfilt] = maia_gp_meanfiltered(directionestientropy,400);

h = figure

hold
plot(timevect,data_port,'Color',C(1,:)','LineWidth',1)
plot(timevect,data_sb,':','Color',C(2,:)','LineWidth',1)
datetick
%xlabel('Time (HH:mm)')
%ylabel('$A_{vib}^b=\sqrt{{f_{i{s_j},HP,x}^2}^2+{f_{i{s_j},HP,y}^2}$','Interpreter','latex')
title('Vibration data')
ylabel('$A_{vib}^b$ (m$\cdot$s$^{-2}$)','Interpreter','latex')
%legend('Starboard','Port')
legend('Port','Starboard')
%reorderLegend([1 2])
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
set(gca,'FontSize',12,'FontName','Times New Roman')
hold

pos = [8.1759,6.7333,5.8333,1.0917];
set(h,'Units','Inches');
set(h,'Position',pos,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

h = figure
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

pos = [9.7833,5.8083,5.8333,2.0667];
set(h,'Units','Inches');
set(h,'Position',pos,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

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

h=figure
subplot(5,1,[1,2])
plot(gp_port.matdatenum,gp_port.exceedlevel50-gp_port.threshold,'Color',C(1,:)','LineWidth',2)
hold
plot(gp_sb.matdatenum,gp_sb.exceedlevel50-gp_port.threshold,':','Color',C(2,:)','LineWidth',2)
hold
ylabel({'50% exceedance level x_m';'(m\cdot s^{-2})'})
set(gca,'XLim',[gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
set(gca,'FontSize',12,'FontName','Times New Roman')
title('Ice drift detection (exceedance level)')
datetick

subplot(5,1,4)
heatmap(directionesti');
colormap(colmap);
%ylabel({'Side of';'ice action'})
set(gca,'FontSize',12,'FontName','Times New Roman')

subplot(5,1,5)
heatmap(directionestifilt');
colormap(colmap);
%ylabel({'Side of';'ice action'})
set(gca,'FontSize',12,'FontName','Times New Roman')

pos = [10.0667,5.8083,5.8333,2.2833];
set(h,'Units','Inches');
set(h,'Position',pos,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

h = figure
subplot(5,1,[1,2])
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

subplot(5,1,4)
heatmap(directionestientropy');
colormap(colmap);
%ylabel({'Side of';'ice action'})
set(gca,'FontSize',12,'FontName','Times New Roman')

subplot(5,1,5)
%heatmap(directionestientropyfilt');
heatmap(directionDB');
colormap(colmap);
%ylabel({'Side of';'ice action'})
set(gca,'FontSize',12,'FontName','Times New Roman')

pos = [10.0667,5.8083,5.8333,2.2833];
set(h,'Units','Inches');
set(h,'Position',pos,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

figure
plot(zeitvektor(2:end-1),bodyDrift(2:end-1),'k','LineWidth',1);
hold
plot(zeitvektor(2:end-1),bodyDrift2(2:end-1),'r--','LineWidth',1);
datetick
grid on
title('Ice drift direction reference (in body frame)')
ylabel({'Ice Drift (^\circ)'})
set(gca,'FontSize',12,'FontName','Times New Roman')
