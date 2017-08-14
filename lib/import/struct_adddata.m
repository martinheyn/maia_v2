function [imu_data_struct] = struct_adddata(imu_data_struct,acc_data,rot_data,matdatenum,imuno)
            
        imuid = strcat('IMU',num2str(imuno));

        imu_data_struct.(imuid).signal_surge = acc_data(1,:)';
        imu_data_struct.(imuid).signal_sway = acc_data(2,:)';
        imu_data_struct.(imuid).signal_heave = acc_data(3,:)';
        imu_data_struct.(imuid).signal_roll = rot_data(1,:)';
        imu_data_struct.(imuid).signal_pitch = rot_data(2,:)';
        imu_data_struct.(imuid).signal_yaw = rot_data(3,:)';
        imu_data_struct.(imuid).matdatenum = linspace(matdatenum(1),matdatenum(end),length(imu_data_struct.(imuid).signal_surge));
end
	    