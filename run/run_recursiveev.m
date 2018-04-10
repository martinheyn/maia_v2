%% Run the EV

data_port = sqrt(imu_data.IMU5.signal_surge.^2 + imu_data.IMU5.signal_sway.^2).*1.33;
data_sb = sqrt(imu_data.IMU4.signal_surge.^2 + imu_data.IMU4.signal_sway.^2);

timevect = imu_data.IMU5.matdatenum;

windowlength = 3000;
blocklength = 100;
frequency = 100;

[blockmax_port,mleev_port] = maia_recursiveev(data_port,timevect,windowlength,blocklength,frequency);
[blockmax_sb,mleev_sb] = maia_recursiveev(data_sb,timevect,windowlength,blocklength,frequency);

maia2_plotevreturnperiod(mleev_port,mleev_sb,0.25)

clear windowlength blocklength