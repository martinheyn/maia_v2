C = linspecer(6);

startinx = 1;
endinx = length(Timest);

zeitvektor = datenum(Timest);

figure
subplot 311
plot(zeitvektor(startinx:endinx),Fx_prop_PS_N(startinx:endinx),'Color',C(1,:)')
hold
plot(zeitvektor(startinx:endinx),Fx_prop_SB_N(startinx:endinx),'Color',C(2,:)')
hold
datetick
xlabel('Time')
ylabel('F_x (N)')

subplot 312
plot(zeitvektor(startinx:endinx),Fy_prop_PS_N(startinx:endinx),'Color',C(1,:)')
hold
plot(zeitvektor(startinx:endinx),Fy_prop_SB_N(startinx:endinx),'Color',C(2,:)')
plot(zeitvektor(startinx:endinx),Fy_Thruster_1_N(startinx:endinx),'Color',C(3,:)')
plot(zeitvektor(startinx:endinx),Fy_Thruster_2_N(startinx:endinx),'Color',C(4,:)')
plot(zeitvektor(startinx:endinx),Fy_Thruster_3_N(startinx:endinx),'Color',C(5,:)')
plot(zeitvektor(startinx:endinx),Fy_Thruster_4_N(startinx:endinx),'Color',C(6,:)')
hold
datetick
xlabel('Time')
ylabel('F_y (N)')

subplot 313
plot(zeitvektor(startinx:endinx),Mz_prop_PS_N_m(startinx:endinx),'Color',C(1,:)')
hold
plot(zeitvektor(startinx:endinx),Mz_prop_SB_N_m(startinx:endinx),'Color',C(2,:)')
plot(zeitvektor(startinx:endinx),Mz_Thruster_1_N_m(startinx:endinx),'Color',C(3,:)')
plot(zeitvektor(startinx:endinx),Mz_Thruster_2_N_m(startinx:endinx),'Color',C(4,:)')
plot(zeitvektor(startinx:endinx),Mz_Thruster_3_N_m(startinx:endinx),'Color',C(5,:)')
plot(zeitvektor(startinx:endinx),Mz_Thruster_4_N(startinx:endinx),'Color',C(6,:)')
hold
datetick
xlabel('Time')
ylabel('M_z (Nm)')
legend('Prop PS','Prop SB','Thruster 1','Thruster 2','Thruster 3','Thruster 4')