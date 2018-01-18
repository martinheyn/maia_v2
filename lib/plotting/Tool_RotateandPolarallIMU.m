data_body_1 = [imu_data_aligned.IMU1.signal_surge, imu_data_aligned.IMU1.signal_sway];
data_body_2 = [imu_data_aligned.IMU2.signal_surge, imu_data_aligned.IMU2.signal_sway];
data_body_3 = [imu_data_aligned.IMU3.signal_surge, imu_data_aligned.IMU3.signal_sway];
data_body_4 = [imu_data_aligned.IMU4.signal_surge, imu_data_aligned.IMU4.signal_sway];
data_body_5 = [imu_data_aligned.IMU5.signal_surge, imu_data_aligned.IMU5.signal_sway];

data_NED_1 = maia_rotatetoNED(data_body_1,Heading_Deg);
data_NED_2 = maia_rotatetoNED(data_body_2,Heading_Deg);
data_NED_3 = maia_rotatetoNED(data_body_3,Heading_Deg);
data_NED_4 = maia_rotatetoNED(data_body_4,Heading_Deg);
data_NED_5 = maia_rotatetoNED(data_body_5,Heading_Deg);

polar_IMU.IMU1.dir = (atan2(data_NED_1(:,2),data_NED_1(:,1)).*(180/pi));
polar_IMU.IMU2.dir = (atan2(data_NED_2(:,2),data_NED_2(:,1)).*(180/pi));
polar_IMU.IMU3.dir = (atan2(data_NED_3(:,2),data_NED_3(:,1)).*(180/pi));
polar_IMU.IMU4.dir = (atan2(data_NED_4(:,2),data_NED_4(:,1)).*(180/pi));
polar_IMU.IMU5.dir = (atan2(data_NED_5(:,2),data_NED_5(:,1)).*(180/pi));

polar_IMU.IMU1.amp = sqrt(data_NED_1(:,1).^2+data_NED_1(:,2).^2);
polar_IMU.IMU2.amp = sqrt(data_NED_2(:,1).^2+data_NED_2(:,2).^2);
polar_IMU.IMU3.amp = sqrt(data_NED_3(:,1).^2+data_NED_3(:,2).^2);
polar_IMU.IMU4.amp = sqrt(data_NED_4(:,1).^2+data_NED_4(:,2).^2);
polar_IMU.IMU5.amp = sqrt(data_NED_5(:,1).^2+data_NED_5(:,2).^2);