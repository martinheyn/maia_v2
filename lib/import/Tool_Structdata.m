
 % Find the data
    if (exist('imu_1_data','var'))
        start_inx = 1;
        end_inx = size(imu_1_data,2);
        tfstart = imu_1_data(1,start_inx);
        tfend = imu_1_data(1,end_inx);
    elseif (exist('imu_2_data','var'))
        start_inx = 1;
        end_inx = size(imu_2_data,2);
        tfstart = imu_2_data(1,start_inx);
        tfend = imu_2_data(1,end_inx);
    elseif (exist('imu_3_data','var'))
        start_inx = 1;
        end_inx = size(imu_3_data,2);
        tfstart = imu_3_data(1,start_inx);
        tfend = imu_3_data(1,end_inx);
    end
    
    % Copy requested data to a struct
    if (exist('imu_1_data','var'))
        imu_data_raw.IMU1.signal_surge = imu_1_data(5,(start_inx:end_inx))';
        imu_data_raw.IMU1.signal_sway = imu_1_data(6,(start_inx:end_inx))';
        imu_data_raw.IMU1.signal_heave = imu_1_data(7,(start_inx:end_inx))';
        imu_data_raw.IMU1.signal_roll = imu_1_data(8,(start_inx:end_inx))';
        imu_data_raw.IMU1.signal_pitch = imu_1_data(9,(start_inx:end_inx))';
        imu_data_raw.IMU1.signal_yaw = imu_1_data(10,(start_inx:end_inx))';
        imu_data_raw.IMU1.matdatenum = linspace(datenum(imu_1_data([14:19],start_inx)'),datenum(imu_1_data([14:19],end_inx)'),length(imu_data_raw.IMU1.signal_surge));
        %imu_data_raw.IMU1.matdatenum = datenum(imu_1_data([14:19],(start_inx:end_inx))');
        imu_data_raw.IMU1.t_cc = linspace(tfstart,tfend,length(imu_data_raw.IMU1.signal_heave));
		
%  		imu_data_aligned.IMU1.signal_surge = imu_1_data_si(5,(start_inx:end_inx))';
%         imu_data_aligned.IMU1.signal_sway = imu_1_data_si(6,(start_inx:end_inx))';
%         imu_data_aligned.IMU1.signal_heave = imu_1_data_si(7,(start_inx:end_inx))';
%         imu_data_aligned.IMU1.signal_roll = imu_1_data_si(8,(start_inx:end_inx))';
%         imu_data_aligned.IMU1.signal_pitch = imu_1_data_si(9,(start_inx:end_inx))';
%         imu_data_aligned.IMU1.signal_yaw = imu_1_data_si(10,(start_inx:end_inx))';
%         imu_data_aligned.IMU1.matdatenum = linspace(datenum(imu_1_data_si([14:19],start_inx)'),datenum(imu_1_data_si([14:19],end_inx)'),length(imu_data_aligned.IMU1.signal_surge));
%         imu_data_aligned.IMU1.t_cc = linspace(tfstart,tfend,length(imu_data_aligned.IMU1.signal_heave));
%         
%         imu_data_aligned_LP.IMU1.signal_surge = imu_1_data_siLP(5,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU1.signal_sway = imu_1_data_siLP(6,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU1.signal_heave = imu_1_data_siLP(7,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU1.signal_roll = imu_1_data_siLP(8,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU1.signal_pitch = imu_1_data_siLP(9,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU1.signal_yaw = imu_1_data_siLP(10,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU1.matdatenum = linspace(datenum(imu_1_data_siLP([14:19],start_inx)'),datenum(imu_1_data_siLP([14:19],end_inx)'),length(imu_data_aligned_LP.IMU1.signal_surge));
%         imu_data_aligned_LP.IMU1.t_cc = linspace(tfstart,tfend,length(imu_data_aligned_LP.IMU1.signal_heave));
	end

    if (exist('imu_2_data','var'))
		imu_data_raw.IMU2.signal_surge = imu_2_data(5,(start_inx:end_inx))';
        imu_data_raw.IMU2.signal_sway = imu_2_data(6,(start_inx:end_inx))';
        imu_data_raw.IMU2.signal_heave = imu_2_data(7,(start_inx:end_inx))';
        imu_data_raw.IMU2.signal_roll = imu_2_data(8,(start_inx:end_inx))';
        imu_data_raw.IMU2.signal_pitch = imu_2_data(9,(start_inx:end_inx))';
        imu_data_raw.IMU2.signal_yaw = imu_2_data(10,(start_inx:end_inx))';
        imu_data_raw.IMU2.matdatenum = linspace(datenum(imu_2_data([14:19],start_inx)'),datenum(imu_2_data([14:19],end_inx)'),length(imu_data_raw.IMU2.signal_surge));
        %imu_data_raw.IMU2.matdatenum = datenum(imu_2_data([14:19],(start_inx:end_inx))');
        imu_data_raw.IMU2.t_cc = linspace(tfstart,tfend,length(imu_data_raw.IMU2.signal_heave));
		
%         imu_data_aligned.IMU2.signal_surge = imu_2_data_si(5,(start_inx:end_inx))';
%         imu_data_aligned.IMU2.signal_sway = imu_2_data_si(6,(start_inx:end_inx))';
%         imu_data_aligned.IMU2.signal_heave = imu_2_data_si(7,(start_inx:end_inx))';
%         imu_data_aligned.IMU2.signal_roll = imu_2_data_si(8,(start_inx:end_inx))';
%         imu_data_aligned.IMU2.signal_pitch = imu_2_data_si(9,(start_inx:end_inx))';
%         imu_data_aligned.IMU2.signal_yaw = imu_2_data_si(10,(start_inx:end_inx))';
%         imu_data_aligned.IMU2.matdatenum = linspace(datenum(imu_2_data_si([14:19],start_inx)'),datenum(imu_2_data_si([14:19],end_inx)'),length(imu_data_aligned.IMU2.signal_surge));
%         imu_data_aligned.IMU2.t_cc = linspace(tfstart,tfend,length(imu_data_aligned.IMU2.signal_heave));
%         
%         imu_data_aligned_LP.IMU2.signal_surge = imu_2_data_siLP(5,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU2.signal_sway = imu_2_data_siLP(6,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU2.signal_heave = imu_2_data_siLP(7,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU2.signal_roll = imu_2_data_siLP(8,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU2.signal_pitch = imu_2_data_siLP(9,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU2.signal_yaw = imu_2_data_siLP(10,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU2.matdatenum = linspace(datenum(imu_2_data_siLP([14:19],start_inx)'),datenum(imu_2_data_siLP([14:19],end_inx)'),length(imu_data_aligned_LP.IMU2.signal_surge));
%         imu_data_aligned_LP.IMU2.t_cc = linspace(tfstart,tfend,length(imu_data_aligned_LP.IMU2.signal_heave));
    end

    if (exist('imu_3_data','var')) 
		imu_data_raw.IMU3.signal_surge = imu_3_data(5,(start_inx:end_inx))';
        imu_data_raw.IMU3.signal_sway = imu_3_data(6,(start_inx:end_inx))';
        imu_data_raw.IMU3.signal_heave = imu_3_data(7,(start_inx:end_inx))';
        imu_data_raw.IMU3.signal_roll = imu_3_data(8,(start_inx:end_inx))';
        imu_data_raw.IMU3.signal_pitch = imu_3_data(9,(start_inx:end_inx))';
        imu_data_raw.IMU3.signal_yaw = imu_3_data(10,(start_inx:end_inx))';
        imu_data_raw.IMU3.matdatenum = linspace(datenum(imu_3_data([14:19],start_inx)'),datenum(imu_3_data([14:19],end_inx)'),length(imu_data_raw.IMU3.signal_surge));
        %imu_data_raw.IMU3.matdatenum = datenum(imu_3_data([14:19],(start_inx:end_inx))');
        imu_data_raw.IMU3.t_cc = linspace(tfstart,tfend,length(imu_data_raw.IMU3.signal_heave));
		
%         imu_data_aligned.IMU3.signal_surge = imu_3_data_si(5,(start_inx:end_inx))';
%         imu_data_aligned.IMU3.signal_sway = imu_3_data_si(6,(start_inx:end_inx))';
%         imu_data_aligned.IMU3.signal_heave = imu_3_data_si(7,(start_inx:end_inx))';
%         imu_data_aligned.IMU3.signal_roll = imu_3_data_si(8,(start_inx:end_inx))';
%         imu_data_aligned.IMU3.signal_pitch = imu_3_data_si(9,(start_inx:end_inx))';
%         imu_data_aligned.IMU3.signal_yaw = imu_3_data_si(10,(start_inx:end_inx))';
%         imu_data_aligned.IMU3.matdatenum = linspace(datenum(imu_3_data_si([14:19],start_inx)'),datenum(imu_3_data_si([14:19],end_inx)'),length(imu_data_aligned.IMU3.signal_surge));
%         imu_data_aligned.IMU3.t_cc = linspace(tfstart,tfend,length(imu_data_aligned.IMU3.signal_heave));
%         
%         imu_data_aligned_LP.IMU3.signal_surge = imu_3_data_siLP(5,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU3.signal_sway = imu_3_data_siLP(6,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU3.signal_heave = imu_3_data_siLP(7,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU3.signal_roll = imu_3_data_siLP(8,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU3.signal_pitch = imu_3_data_siLP(9,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU3.signal_yaw = imu_3_data_siLP(10,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU3.matdatenum = linspace(datenum(imu_3_data_siLP([14:19],start_inx)'),datenum(imu_3_data_siLP([14:19],end_inx)'),length(imu_data_aligned_LP.IMU3.signal_surge));
%         imu_data_aligned_LP.IMU3.t_cc = linspace(tfstart,tfend,length(imu_data_aligned_LP.IMU3.signal_heave));
    end

    if (exist('imu_4_data','var'))
		imu_data_raw.IMU4.signal_surge = imu_4_data(5,(start_inx:end_inx))';
        imu_data_raw.IMU4.signal_sway = imu_4_data(6,(start_inx:end_inx))';
        imu_data_raw.IMU4.signal_heave = imu_4_data(7,(start_inx:end_inx))';
        imu_data_raw.IMU4.signal_roll = imu_4_data(8,(start_inx:end_inx))';
        imu_data_raw.IMU4.signal_pitch = imu_4_data(9,(start_inx:end_inx))';
        imu_data_raw.IMU4.signal_yaw = imu_4_data(10,(start_inx:end_inx))';
        imu_data_raw.IMU4.matdatenum = linspace(datenum(imu_4_data([14:19],start_inx)'),datenum(imu_4_data([14:19],end_inx)'),length(imu_data_raw.IMU4.signal_surge));
        %imu_data_raw.IMU4.matdatenum = datenum(imu_4_data([14:19],(start_inx:end_inx))');
        imu_data_raw.IMU4.t_cc = linspace(tfstart,tfend,length(imu_data_raw.IMU4.signal_heave));
		
%         imu_data_aligned.IMU4.signal_surge = imu_4_data_si(5,(start_inx:end_inx))';
%         imu_data_aligned.IMU4.signal_sway = imu_4_data_si(6,(start_inx:end_inx))';
%         imu_data_aligned.IMU4.signal_heave = imu_4_data_si(7,(start_inx:end_inx))';
%         imu_data_aligned.IMU4.signal_roll = imu_4_data_si(8,(start_inx:end_inx))';
%         imu_data_aligned.IMU4.signal_pitch = imu_4_data_si(9,(start_inx:end_inx))';
%         imu_data_aligned.IMU4.signal_yaw = imu_4_data_si(10,(start_inx:end_inx))';
%         imu_data_aligned.IMU4.matdatenum = linspace(datenum(imu_4_data_si([14:19],start_inx)'),datenum(imu_4_data_si([14:19],end_inx)'),length(imu_data_aligned.IMU4.signal_surge));
%         imu_data_aligned.IMU4.t_cc = linspace(tfstart,tfend,length(imu_data_aligned.IMU4.signal_heave));
%         
%         imu_data_aligned_LP.IMU4.signal_surge = imu_4_data_siLP(5,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU4.signal_sway = imu_4_data_siLP(6,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU4.signal_heave = imu_4_data_siLP(7,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU4.signal_roll = imu_4_data_siLP(8,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU4.signal_pitch = imu_4_data_siLP(9,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU4.signal_yaw = imu_4_data_siLP(10,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU4.matdatenum = linspace(datenum(imu_4_data_siLP([14:19],start_inx)'),datenum(imu_3_data_siLP([14:19],end_inx)'),length(imu_data_aligned_LP.IMU4.signal_surge));
%         imu_data_aligned_LP.IMU4.t_cc = linspace(tfstart,tfend,length(imu_data_aligned_LP.IMU4.signal_heave));
    end

    if (exist('imu_5_data','var'))
		imu_data_raw.IMU5.signal_surge = imu_5_data(5,(start_inx:end_inx))';
        imu_data_raw.IMU5.signal_sway = imu_5_data(6,(start_inx:end_inx))';
        imu_data_raw.IMU5.signal_heave = imu_5_data(7,(start_inx:end_inx))';
        imu_data_raw.IMU5.signal_roll = imu_5_data(8,(start_inx:end_inx))';
        imu_data_raw.IMU5.signal_pitch = imu_5_data(9,(start_inx:end_inx))';
        imu_data_raw.IMU5.signal_yaw = imu_5_data(10,(start_inx:end_inx))';
        imu_data_raw.IMU5.matdatenum = linspace(datenum(imu_5_data([14:19],start_inx)'),datenum(imu_5_data([14:19],end_inx)'),length(imu_data_raw.IMU5.signal_surge));
        %imu_data_raw.IMU5.matdatenum = datenum(imu_5_data([14:19],(start_inx:end_inx))');
        imu_data_raw.IMU5.t_cc = linspace(tfstart,tfend,length(imu_data_raw.IMU5.signal_heave));
		
%         imu_data_aligned.IMU5.signal_surge = imu_5_data_si(5,(start_inx:end_inx))';
%         imu_data_aligned.IMU5.signal_sway = imu_5_data_si(6,(start_inx:end_inx))';
%         imu_data_aligned.IMU5.signal_heave = imu_5_data_si(7,(start_inx:end_inx))';
%         imu_data_aligned.IMU5.signal_roll = imu_5_data_si(8,(start_inx:end_inx))';
%         imu_data_aligned.IMU5.signal_pitch = imu_5_data_si(9,(start_inx:end_inx))';
%         imu_data_aligned.IMU5.signal_yaw = imu_5_data_si(10,(start_inx:end_inx))';
%         imu_data_aligned.IMU5.matdatenum = linspace(datenum(imu_5_data_si([14:19],start_inx)'),datenum(imu_5_data_si([14:19],end_inx)'),length(imu_data_aligned.IMU5.signal_surge));
%         imu_data_aligned.IMU5.t_cc = linspace(tfstart,tfend,length(imu_data_aligned.IMU5.signal_heave));
%         
%         imu_data_aligned_LP.IMU5.signal_surge = imu_5_data_siLP(5,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU5.signal_sway = imu_5_data_siLP(6,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU5.signal_heave = imu_5_data_siLP(7,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU5.signal_roll = imu_5_data_siLP(8,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU5.signal_pitch = imu_5_data_siLP(9,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU5.signal_yaw = imu_5_data_siLP(10,(start_inx:end_inx))';
%         imu_data_aligned_LP.IMU5.matdatenum = linspace(datenum(imu_5_data_siLP([14:19],start_inx)'),datenum(imu_3_data_siLP([14:19],end_inx)'),length(imu_data_aligned_LP.IMU5.signal_surge));
%         imu_data_aligned_LP.IMU5.t_cc = linspace(tfstart,tfend,length(imu_data_aligned_LP.IMU5.signal_heave));
    end
	
        imu_data_raw.userinput.start_inx = start_inx;
        imu_data_raw.userinput.end_inx = end_inx;
        imu_data_raw.userinput.tfstart = tfstart;
        imu_data_raw.userinput.tfend = tfend;
		imu_data_raw.frequency = freq_d;
		
%         imu_data_aligned.userinput.start_inx = start_inx;
%         imu_data_aligned.userinput.end_inx = end_inx;
%         imu_data_aligned.userinput.tfstart = tfstart;
%         imu_data_aligned.userinput.tfend = tfend;
% 		imu_data_aligned.frequency = freq_d;
% 		imu_data_aligned.rotations.R1S1 = R1S1;
% 		imu_data_aligned.rotations.R2S1 = R2S1;
% 		imu_data_aligned.rotations.R3S1 = R3S1;
% 		imu_data_aligned.rotations.R4S1 = R4S1;
% 		imu_data_aligned.rotations.T1S1 = T1S1;
% 		imu_data_aligned.rotations.T2S1 = T2S1;
% 		imu_data_aligned.rotations.T3S1 = T3S1;
% 		imu_data_aligned.rotations.T4S1 = T4S1;
%         
%         imu_data_aligned_LP.userinput.start_inx = start_inx;
%         imu_data_aligned_LP.userinput.end_inx = end_inx;
%         imu_data_aligned_LP.userinput.tfstart = tfstart;
%         imu_data_aligned_LP.userinput.tfend = tfend;
% 		imu_data_aligned_LP.frequency = freq_d;
%         imu_data_aligned_LP.lowpassfilter = df;
% 		imu_data_aligned_LP.rotations.R1S1 = R1S1;
% 		imu_data_aligned_LP.rotations.R2S1 = R2S1;
% 		imu_data_aligned_LP.rotations.R3S1 = R3S1;
% 		imu_data_aligned_LP.rotations.R4S1 = R4S1;
% 		imu_data_aligned_LP.rotations.T1S1 = T1S1;
% 		imu_data_aligned_LP.rotations.T2S1 = T2S1;
% 		imu_data_aligned_LP.rotations.T3S1 = T3S1;
% 		imu_data_aligned_LP.rotations.T4S1 = T4S1;