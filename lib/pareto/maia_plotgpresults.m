
C = linspecer(2);

figure
subplot 211
plot(gp_port.matdatenum,gp_port.estimate(:,1),'Color',C(1,:)')
hold
plot(gp_sb.matdatenum,gp_sb.estimate(:,1),'Color',C(2,:)')
datetick
xlabel('Time (HH:mm)')
ylabel('Shape parameter \xi')
legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on

subplot 212
plot(gp_port.matdatenum,gp_port.estimate(:,2),'Color',C(1,:)')
hold
plot(gp_sb.matdatenum,gp_sb.estimate(:,2),'Color',C(2,:)')
datetick
xlabel('Time (HH:mm)')
ylabel('Scale parameter \sigma')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on

figure
subplot 211
plot(gp_port.matdatenum,gp_port.exceedlevel1000,'Color',C(1,:)')
hold
plot(gp_sb.matdatenum,gp_sb.exceedlevel1000,'Color',C(2,:)')
datetick
xlabel('Time (HH:mm)')
ylabel('Average exceed level (m\cdots^{-2})')
legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on

subplot 212
plot(timevect,data_port,'Color',C(1,:)')
hold
plot(timevect,data_sb,'Color',C(2,:)')
datetick
xlabel('Time (HH:mm)')
ylabel('$A_{vib}=\sqrt{\tilde{a}_x^2+\tilde{a}_y^2}$','Interpreter','latex')
legend('Port','Starboard')
xlim([gp_port.matdatenum(1) gp_port.matdatenum(end)])
grid on
