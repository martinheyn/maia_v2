C = linspecer(6);

startinx = 1;
endinx = length(Timest);

zeitvektor = datenum(Timest);

figure
subplot 311
plot(zeitvektor(startinx:endinx),Fx_Anchor_N(startinx:endinx),'Color',C(1,:)')
%hold
%plot(zeitvektor(startinx:endinx),True_Wind_Direction_deg(startinx:endinx),'Color',C(2,:)')
%hold
datetick
ylabel('Anchor Force (N)')
xlabel('Time')

subplot 312
tempHeading = maia_from180to360(Heading_Deg(startinx:endinx));
tempDrift = maia_addtodegrees(tempHeading,Ice_Drift_Direction_DB_deg);
plot(zeitvektor(startinx:endinx),Ice_Drift_Direction_IPS_deg(startinx:endinx),'Color',C(1,:)')
hold
plot(zeitvektor(startinx:endinx),Ice_Drift_Direction_DB_deg(startinx:endinx),'Color',C(2,:)')
plot(zeitvektor(startinx:endinx),tempHeading,'Color',C(3,:)')
plot(zeitvektor(startinx:endinx),tempDrift,'Color',C(4,:)')
datetick
hold
ylabel('Heading (ms)')
xlabel('Time')
legend('Ice Drift IPS','Ice Drift DB','Heading','Ice Drift DB in Body')
clear tempHeading tempDrift

subplot 313
plot(zeitvektor(startinx:endinx),Ice_Thickness_Observation_m,'Color',C(5,:)')
hold
plot(zeitvektor(startinx:endinx),Ice_Thickness_IPS1_m,'Color',C(6,:)')
datetick
ylabel('Ice Thickness (m)')
xlabel('Time')
legend('Observation','IPS1')
