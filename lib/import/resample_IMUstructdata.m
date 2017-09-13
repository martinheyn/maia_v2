%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This tool filters and resamples imu struct data     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2017-08-14  Hans-Martin Heyn (NTNU)
%    

%---------------------------------------------------------------------%

function [imu_data_resampled] = resample_IMUstructdata(imu_data,freq_d)
		imu_data_resampled.accunits = imu_data.accunits;
		imu_data_resampled.rotunits = imu_data.rotunits;
		
		base_freq = imu_data.frequency;
		freq_frac = ceil(base_freq / freq_d);
		
		imu_data_resampled.frequency = base_freq / freq_frac;
		
		for k = 1:1:5
			proceed = 1;
			switch k
				case 1
					if isfield(imu_data,'IMU1')
						selectedIMU = 'IMU1';
					else
						proceed = 0;
					end
				
				case 2
					if isfield(imu_data,'IMU2')
						selectedIMU = 'IMU2';
					else
						proceed = 0;
					end
				
				case 3
					if isfield(imu_data,'IMU3')
						selectedIMU = 'IMU3';
					else
						proceed = 0;
					end
				
				case 4
					if isfield(imu_data,'IMU4')
						selectedIMU = 'IMU4';
					else
						proceed = 0;
					end
				
				case 5
					if isfield(imu_data,'IMU5')
						selectedIMU = 'IMU5';
					else
						proceed = 0;
					end
			end
		
			if proceed == 1
				[imu_data_resampled.(selectedIMU).signal_surge] = decimate(imu_data.(selectedIMU).signal_surge,freq_frac);
				
				[imu_data_resampled.(selectedIMU).signal_sway] = decimate(imu_data.(selectedIMU).signal_sway,freq_frac);
				
				[imu_data_resampled.(selectedIMU).signal_heave_ug] = decimate((imu_data.(selectedIMU).signal_heave- 9.81),freq_frac);
				
                [imu_data_resampled.(selectedIMU).signal_heave] = imu_data_resampled.(selectedIMU).signal_heave_ug + 9.81;
                
				[imu_data_resampled.(selectedIMU).signal_roll] = decimate(imu_data.(selectedIMU).signal_roll,freq_frac);
				
				[imu_data_resampled.(selectedIMU).signal_pitch] = decimate(imu_data.(selectedIMU).signal_pitch,freq_frac);
				
				[imu_data_resampled.(selectedIMU).signal_yaw] = decimate(imu_data.(selectedIMU).signal_yaw,freq_frac);
				
				imu_data_resampled.(selectedIMU).R = imu_data.(selectedIMU).R;
				
				imu_data_resampled.(selectedIMU).alignment = imu_data.(selectedIMU).alignment;
				
				imu_data_resampled.(selectedIMU).matdatenum = linspace(imu_data.(selectedIMU).matdatenum(1),imu_data.(selectedIMU).matdatenum(end),length(imu_data_resampled.(selectedIMU).signal_surge));
			end
			
			
		end
		
 

end