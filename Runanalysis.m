ws = 200;

sampledata.surge_data = imu_data_cut.IMU2.signal_surge;
sampledata.sway_data = imu_data_cut.IMU2.signal_sway;
sampledata.matdatenum = imu_data_cut.IMU2.matdatenum;

[sampledata.results.surge.pd_n,sampledata.results.surge.pd_t] = estimate_uni_t_recursive(sampledata.surge_data,ws);
[sampledata.results.sway.pd_n,sampledata.results.sway.pd_t] = estimate_uni_t_recursive(sampledata.sway_data,ws);
[sampledata.results.surgesway.mu,sampledata.results.surgesway.S,sampledata.results.surgesway.nu,sampledata.results.surgesway.p,] = estimate_bi_t_recursive([sampledata.surge_data, sampledata.sway_data],ws);


