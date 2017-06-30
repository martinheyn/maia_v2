function [imu_data_cut] = GUIselectIMUdata(imu_data)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % Extract start and stop times
    starttime = imu_data.IMU3.matdatenum(1);
    endtime = imu_data.IMU3.matdatenum(end);
    
    % 2. Plot all data with plot compare
    plotCompare(imu_data,starttime,endtime,0);

    % 3. Let the person in front of the screen pick a data set
    ginput(1); % We just have to click in or close to the plot to pick it
    picked = gca;
    if picked.Position(1) > 0.5 
        m = 3;
    else
        m = 0;
    end

    if picked.Position(2) < 0.33
        m = m + 3;
    elseif picked.Position(2) < 0.66
        m = m + 2;
    elseif picked.Position(1) < 1
        m = m + 1;
    end
    
    switch m
        case 1
            selected = 'signal_surge';
        case 2
            selected = 'signal_sway';
        case 3
            selected = 'signal_heave';
        case 4
            selected = 'signal_roll';
        case 5
            selected = 'signal_pitch';
        case 6
            selected = 'signal_yaw';
    end
    
    % Plot the selected DOF for selection of start and stop time
    fig1 = figure;
    set (fig1, 'Units', 'normalized', 'Position', [0,0,1,1]);
    hold
    plot(imu_data.IMU1.matdatenum,imu_data.IMU1.(selected),'k')
    plot(imu_data.IMU2.matdatenum,imu_data.IMU2.(selected),'b')
    plot(imu_data.IMU3.matdatenum,imu_data.IMU3.(selected),'r')
    plot(imu_data.IMU4.matdatenum,imu_data.IMU4.(selected),'Color',[0 0.75 0])
    datetick
    
    %YLabelsave = get(picked.YLabel);
    userrequest = 1;

    % 5. Let the user decide which part he wants to analyse
    selected = ginput(2); % Click once for the start 
    
    start_num = selected(1,1);
    end_num = selected(2,1);
    close all
    for n=1:1:4
        if (n == 1) && (isfield(imu_data,'IMU1'))
            selectedIMU = 'IMU1';
        elseif (n == 2) && (isfield(imu_data,'IMU2'))
            selectedIMU = 'IMU2';
        elseif (n == 3) && (isfield(imu_data,'IMU3'))
            selectedIMU = 'IMU3';
        elseif (n == 4) && (isfield(imu_data,'IMU4'))
            selectedIMU = 'IMU4';
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

