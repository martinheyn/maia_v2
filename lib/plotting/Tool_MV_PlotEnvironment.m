C = linspecer(3);

startinx = 1;
endinx = length(Timest);

zeitvektor = datenum(Timest);

figure
subplot 311
plot(zeitvektor(startinx:endinx),Ice_Drift_Direction_DB_deg(startinx:endinx),'Color',C(1,:)')
hold
plot(zeitvektor(startinx:endinx),True_Wind_Direction_deg(startinx:endinx),'Color',C(2,:)')
hold
datetick
ylabel('Direction (^\circ)')
xlabel('Time')
legend('Ice','Wind')

subplot 312
plot(zeitvektor(startinx:endinx),AverageofIce_Drift_Velocity_DB_ms(startinx:endinx),'Color',C(1,:)')
yyaxis right
plot(zeitvektor(startinx:endinx),True_Wind_Speed_ms(startinx:endinx),'Color',C(2,:)')
datetick
ylabel('Velocity (ms)')
xlabel('Time')

subplot 313
plot(zeitvektor(startinx:endinx),Ice_Thickness_Observation_m,'Color',C(3,:)')
datetick
ylabel('Ice Thickness (m)')
xlabel('Time')
