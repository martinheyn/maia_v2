%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The IMU data cut script                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script cuts the IMU data into the desired time frame
% 
%
% Workspace data: - IMU raw data
% Output data: - IMU data struct
%   
%  
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-08-07  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%

function [imu_data_cut] = cutIMUdata(imu_data)
 

    % Text based input
    prompt = {'Year:','Months:','Day:','Hours:','Minutes:','Seconds:'};
    userinput = inputdlg(prompt,'Starttime',1,{'YYYY','MM','DD','HH','MM','SS'});
    sjahr = str2num(cell2mat(userinput(1)));
    smonat = str2num(cell2mat(userinput(2)));
    stag = str2num(cell2mat(userinput(3)));
    sstunde = str2num(cell2mat(userinput(4)));
    sminute = str2num(cell2mat(userinput(5)));
    ssekunde = str2num(cell2mat(userinput(6)));
    
    userinput = inputdlg(prompt,'Endtime',1,{'YYYY','MM','DD','HH','MM','SS'});
    ejahr = str2num(cell2mat(userinput(1)));
    emonat = str2num(cell2mat(userinput(2)));
    etag = str2num(cell2mat(userinput(3)));
    estunde = str2num(cell2mat(userinput(4)));
    eminute = str2num(cell2mat(userinput(5)));
    esekunde = str2num(cell2mat(userinput(6)));
    
    start_num = datenum(sjahr,smonat,stag,sstunde,sminute,ssekunde);
    end_num = datenum(ejahr,emonat,etag,estunde,eminute,esekunde);
    
    clear prompt userinput sjahr smonat stag sstunde sminute ssekunde ejahr emonat etag estunde eminute esekunde
    
    % 3. Find the time in the IMU dataset
    for n=1:1:5
        if (n == 1) && (isfield(imu_data,'IMU1'))
            selectedIMU = 'IMU1';
        elseif (n == 2) && (isfield(imu_data,'IMU2'))
            selectedIMU = 'IMU2';
        elseif (n == 3) && (isfield(imu_data,'IMU3'))
            selectedIMU = 'IMU3';
        elseif (n == 4) && (isfield(imu_data,'IMU4'))
            selectedIMU = 'IMU4';
        elseif (n == 5) && (isfield(imu_data,'IMU5'))
            selectedIMU = 'IMU5';
        end
           start_inx = find(imu_data.(selectedIMU).matdatenum >= start_num,1);
           end_inx = find(imu_data.(selectedIMU).matdatenum >= end_num,1);
           imu_data_cut.(selectedIMU).signal_surge = imu_data.(selectedIMU).signal_surge(start_inx:end_inx);
           imu_data_cut.(selectedIMU).signal_sway = imu_data.(selectedIMU).signal_sway(start_inx:end_inx);
           imu_data_cut.(selectedIMU).signal_heave = imu_data.(selectedIMU).signal_heave(start_inx:end_inx);
           imu_data_cut.(selectedIMU).signal_roll = imu_data.(selectedIMU).signal_roll(start_inx:end_inx);
           imu_data_cut.(selectedIMU).signal_pitch = imu_data.(selectedIMU).signal_pitch(start_inx:end_inx);
           imu_data_cut.(selectedIMU).signal_yaw = imu_data.(selectedIMU).signal_yaw(start_inx:end_inx);
           imu_data_cut.(selectedIMU).matdatenum = imu_data.(selectedIMU).matdatenum(start_inx:end_inx);
           try
            imu_data_cut.(selectedIMU).t_cc = imu_data_raw.(selectedIMU).t_cc(start_inx:end_inx); 
           catch
           end
           imu_data_cut.frequency = imu_data.frequency;
           imu_data_cut.starttime = start_num;
           imu_data_cut.endtime = end_num;
    end
end
