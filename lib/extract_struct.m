function [acc_data,rot_data,matdatenum] = extract_struct(imu_data,imuno)

imuid = strcat('IMU',num2str(imuno));
acc_data(1:3,:) = [imu_data.(imuid).signal_surge,imu_data.(imuid).signal_sway,imu_data.(imuid).signal_heave]';
rot_data(1:3,:) = [imu_data.(imuid).signal_roll,imu_data.(imuid).signal_pitch,imu_data.(imuid).signal_yaw]';
matdatenum = imu_data.(imuid).matdatenum;

end