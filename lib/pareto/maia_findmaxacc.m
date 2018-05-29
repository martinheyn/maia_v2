timevect = imu_data_aligned.IMU1.matdatenum;
imu_data = imu_data_aligned;

data_1 = sqrt(detrend(imu_data.IMU1.signal_surge).^2 + detrend(imu_data.IMU1.signal_sway).^2);
data_port = sqrt(detrend(imu_data.IMU5.signal_surge).^2 + detrend(imu_data.IMU5.signal_sway).^2);
data_sb = sqrt(detrend(imu_data.IMU4.signal_surge).^2 + detrend(imu_data.IMU4.signal_sway).^2);
data_port2 = sqrt(detrend(imu_data.IMU3.signal_surge).^2 + detrend(imu_data.IMU3.signal_sway).^2);
data_sb2 = sqrt(detrend(imu_data.IMU2.signal_surge).^2 + detrend(imu_data.IMU2.signal_sway).^2);

data_mean = (1/5).*(data_1+data_port+data_sb+data_port2+data_sb2);
C = linspecer(5);

figure
subplot(3,1,[1,2])
plot(timevect,data_1,'--','Color',C(1,:)')
hold
plot(timevect,data_sb2,'--','Color',C(2,:)')
plot(timevect,data_port2,'--','Color',C(3,:)')
plot(timevect,data_sb,'--','Color',C(4,:)')
plot(timevect,data_port,'--','Color',C(5,:)')
plot(timevect,data_port,'k')
hold
datetick
grid on


tempdate = datenum(Timest);

startinx = find(tempdate>=timevect(1),1);
endinx = find(tempdate<=timevect(end),1,'last');

subplot(3,1,3)
plot(tempdate(startinx:endinx),Fx_Anchor_N(startinx:endinx));
datetick
grid on