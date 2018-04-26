C = linspecer(2);

figure

subplot 311
plot(timevect,data_port,'Color',C(1,:)')
hold
plot(timevect,data_sb,'Color',C(2,:)')
datetick
xlabel('Time (HH:mm)')
ylabel('$A_{vib}=\sqrt{\tilde{a}_x^2+\tilde{a}_y^2}$','Interpreter','latex')
legend('Port','Starboard')
xlim([gamma_port.matdatenum(1) gamma_port.matdatenum(end)])
grid on

subplot 312
plot(gamma_port.matdatenum,gamma_port.estimate(:,1),'Color',C(1,:)')
hold
plot(gamma_sb.matdatenum,gamma_sb.estimate(:,1),'Color',C(2,:)')
datetick
xlabel('Time (HH:mm)')
ylabel('Shape parameter \xi')
legend('Port','Starboard')
xlim([gamma_port.matdatenum(1) gamma_port.matdatenum(end)])
grid on

subplot 313
plot(gamma_port.matdatenum,gamma_port.estimate(:,2),'Color',C(1,:)')
hold
plot(gamma_sb.matdatenum,gamma_sb.estimate(:,2),'Color',C(2,:)')
datetick
xlabel('Time (HH:mm)')
ylabel('Scale parameter \sigma')
xlim([gamma_port.matdatenum(1) gamma_port.matdatenum(end)])
grid on
