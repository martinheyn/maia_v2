


%load('17_SKT\17_MagneVikingNavigation.mat');

spheroid = referenceEllipsoid('wgs84');
rEarth = 6378137.0; 
g0     = 9.80665;
we     = 7.292115e-5;
wie_e  = [0 0 we]';
Sie_e  = Smtrx(wie_e);

Nav_t = datenum(Timest);

lat0 = Lat_position_Deg(1);
lon0 = Lon_position_Deg(1);
h0   = 0; %rEarth;

h = h0;
[xNED,yNED,zNED]    = geodetic2ned(Lat_position_Deg,Lon_position_Deg,h,lat0,lon0,h0,spheroid);
[xECEF,yECEF,zECEF] = geodetic2ecef(spheroid,Lat_position_Deg,Lon_position_Deg,h);

Head = Heading_Deg;

pECEF = [xECEF,yECEF,zECEF]';
Cent_ie_e = Sie_e*Sie_e*pECEF;
% nu_nb_n = [2 1 0]';
% 2*Sie_e*nu_nb_n


xUTM = North_position_UTM_M-North_position_UTM_M(1);
yUTM = East_position_UTM_M-East_position_UTM_M(1);

figure(1); subplot(2,1,1);
plot(yNED,xNED,yUTM,xUTM);
subplot(2,1,2);
plot(Nav_t,Head); datetick;

% Calibration
% We use the ax, ay, az arrows for direction of positive acceleration data. 
% Then we only need to multiply the fx data with (-1) to get it into the
% fore-stbd-down coordinate system. Similarly, the gyro data gy and gz must
% also be multilied by (-1).
% load('17_SKT\17_rawdataIMU_100Hz.mat');
% IMU_t    = imu_data_raw.IMU1.matdatenum;
% IMU1_fx  = imu_data_raw.IMU1.signal_surge*g0/1e3;
% IMU1_fy  = imu_data_raw.IMU1.signal_sway*g0/1e3;
% IMU1_fz  = imu_data_raw.IMU1.signal_heave*g0/1e3;
% IMU1_wx  = imu_data_raw.IMU1.signal_roll*pi/180;
% IMU1_wy  = imu_data_raw.IMU1.signal_pitch*pi/180;
% IMU1_wz  = imu_data_raw.IMU1.signal_yaw*pi/180;
% IMU4_fx  = imu_data_raw.IMU4.signal_surge*g0/1e3;
% IMU4_fy  = imu_data_raw.IMU4.signal_sway*g0/1e3;
% IMU4_fz  = imu_data_raw.IMU4.signal_heave*g0/1e3;
% IMU4_wx  = imu_data_raw.IMU4.signal_roll*pi/180;
% IMU4_wy  = imu_data_raw.IMU4.signal_pitch*pi/180;
% IMU4_wz  = imu_data_raw.IMU4.signal_yaw*pi/180;

% load('17_SKT\17_rawdataIMU_100Hz.mat');
IMU_t    = imu_data.IMU1.matdatenum;
IMU1_fx  = detrend(imu_data.IMU1.signal_surge*g0/1e3);
IMU1_fy  = detrend(imu_data.IMU1.signal_sway*g0/1e3);
IMU1_fz  = detrend(imu_data.IMU1.signal_heave*g0/1e3);
IMU1_wx  = detrend(imu_data.IMU1.signal_roll*pi/180);
IMU1_wy  = detrend(imu_data.IMU1.signal_pitch*pi/180);
IMU1_wz  = detrend(imu_data.IMU1.signal_yaw*pi/180);
IMU4_fx  = detrend(imu_data.IMU4.signal_surge*g0/1e3);
IMU4_fy  = detrend(imu_data.IMU4.signal_sway*g0/1e3);
IMU4_fz  = detrend(imu_data.IMU4.signal_heave*g0/1e3);
IMU4_wx  = detrend(imu_data.IMU4.signal_roll*pi/180);
IMU4_wy  = detrend(imu_data.IMU4.signal_pitch*pi/180);
IMU4_wz  = detrend(imu_data.IMU4.signal_yaw*pi/180);


f1 = [-IMU1_fx,IMU1_fy,IMU1_fz]';
w1 = [IMU1_wx,-IMU1_wy,-IMU1_wz]';
f4 = [-IMU1_fx,IMU1_fy,IMU1_fz]';
w4 = [IMU1_wx,-IMU1_wy,-IMU1_wz]';
f5 = [-IMU1_fx,IMU1_fy,IMU1_fz]';
w5 = [IMU1_wx,-IMU1_wy,-IMU1_wz]';

phi1   = atan2(-f1(2,:),-f1(3,:));
theta1 = atan2(f1(1,:),sqrt(f1(2,:).^2+f1(3,:).^2));
phi4   = atan2(-f4(2,:),-f4(3,:));
theta4 = atan2(f4(1,:),sqrt(f4(2,:).^2+f4(3,:).^2));
phi5   = atan2(-f5(2,:),-f5(3,:));
theta5 = atan2(f5(1,:),sqrt(f5(2,:).^2+f5(3,:).^2));

figure(2);
plot(IMU_t,IMU1_fx, IMU_t,IMU1_fy); hold on;
% plot(IMU_t(1.2e5:2.8e5),IMU1_fx(1.2e5:2.8e5),IMU_t(1.2e5:2.8e5),IMU1_fy(1.2e5:2.8e5),IMU_t(1.2e5:2.8e5),IMU1_fz(1.2e5:2.8e5)); 
plot(Nav_t,Cent_ie_e(1,:)); datetick; grid on; 
hold off;

figure(3); 
plot(IMU_t,phi4*180/pi, IMU_t,theta4*180/pi); datetick; grid on;

figure(4); 
plot(IMU_t,w4*180/pi, IMU_t,w4*180/pi, IMU_t,w4*180/pi); datetick; grid on;


% Scatter plot
figure(5);
scatter(f4(1,:),f4(2,:));
