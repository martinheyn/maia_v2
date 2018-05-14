C = linspecer(2);

maia_gp_dircolbars;

figure
plot(timevect,data_port,'Color',C(1,:)')
hold
plot(timevect,data_sb,'Color',C(2,:)')
datetick
%xlabel('Time (HH:mm)')
%ylabel('$A_{vib}^b=\sqrt{{f_{i{s_j},HP,x}^2}^2+{f_{i{s_j},HP,y}^2}$','Interpreter','latex')
title('Vibration data')
ylabel('$A_{vib}^b$ (m$\cdot$s$^{-2}$)','Interpreter','latex')
legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
c = get(gca);
set(gca,'FontSize',12,'FontName','Times New Roman')

figure
subplot 211
plot(gp_port.matdatenum,gp_port.estimate(:,1),'Color',C(1,:)')
hold
plot(gp_sb.matdatenum,gp_sb.estimate(:,1),'Color',C(2,:)')
datetick
%xlabel('Time (HH:mm)')
title('Parameter estimates')
ylabel('$\hat{\xi}$','Interpreter','latex')
%legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
c = get(gca);
set(gca,'FontSize',12,'FontName','Times New Roman')

subplot 212
plot(gp_port.matdatenum,gp_port.estimate(:,2),'Color',C(1,:)')
hold
plot(gp_sb.matdatenum,gp_sb.estimate(:,2),'Color',C(2,:)')
datetick
%xlabel('Time (HH:mm)')
ylabel('$\hat{\sigma}$','Interpreter','latex')
%legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
c = get(gca);
set(gca,'FontSize',12,'FontName','Times New Roman')

figure
subplot(3,1,[1,2])
plot(gp_port.matdatenum,gp_port.returnlevel15u*(gp_port.windowlength/gp_port.frequency),'Color',C(1,:)')
hold
plot(gp_sb.matdatenum,gp_sb.returnlevel15u*(gp_sb.windowlength/gp_sb.frequency),'Color',C(2,:)')
datetick
%xlabel('Time (HH:mm)')
ylabel({'Return period';'of 1.5u (s)'})
%legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
title('Ice drift detection')
grid on
set(gca,'FontSize',12,'FontName','Times New Roman')

subplot(3,1,3)
heatmap(directionesti');
ylabel({'Side of';'ice action'})
set(gca,'FontSize',12,'FontName','Times New Roman')

figure
plot(zeitvektor,bodyDrift);
datetick
grid on
title('Ice drift reference (in body frame)')
ylabel({'Ice Drift';'(^\circ)'})
c = get(gca);
set(gca,'FontSize',12,'FontName','Times New Roman')
