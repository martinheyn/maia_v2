function plotCompare(imu_data,interval_start,interval_end,filter)
%PLOTCOMPARE 2 or 3 datasets, if just 2, set data_3 = 0; Interval is time
%in secounds after file start

% filterdesign
d = designfilt('lowpassfir','PassbandFrequency',0.001, ...
         'StopbandFrequency',0.05,'PassbandRipple',0.5, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
%fvtool(d)   

%fig1 = figure(1);
%clf;
%set(fig1,'Position',[460 100 1000 1000])

% if length(data_1) ~= length(data_3) 
%     if filter == 0
%         index_start_2 = median(find((data_1(1,:)-interval_start).^2<0.001));
%         index_start_3 = median(find((data_2(1,:)-interval_start).^2<0.001));
% 
%         index_end_2 = median(find((data_1(1,:)-interval_end).^2<0.001));
%         index_end_3 = median(find((data_2(1,:)-interval_end).^2<0.001));
% 
%         subplot 321
%         plot(data_1(1,index_start_2:index_end_2),data_1(5,index_start_2:index_end_2))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),data_2(5,index_start_3:index_end_3),'r')
%         %plot(data_3(1,index_start_4:index_end_4),data_3(5,index_start_4:index_end_4),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('a_x [m/s^2]')
% 
%         subplot 322
%         plot(data_1(1,index_start_2:index_end_2),data_1(8,index_start_2:index_end_2))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),data_2(8,index_start_3:index_end_3),'r')
%         %plot(data_3(1,index_start_4:index_end_4),data_3(8,index_start_4:index_end_4),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('omega_x [rad/s]')
% 
%         subplot 323
%         plot(data_1(1,index_start_2:index_end_2),data_1(6,index_start_2:index_end_2))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),data_2(6,index_start_3:index_end_3),'r')
%         %plot(data_3(1,index_start_4:index_end_4),data_3(6,index_start_4:index_end_4),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('a_y [m/s^2]')
% 
%         subplot 324
%         plot(data_1(1,index_start_2:index_end_2),data_1(9,index_start_2:index_end_2))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),data_2(9,index_start_3:index_end_3),'r')
%         %plot(data_3(1,index_start_4:index_end_4),data_3(9,index_start_4:index_end_4),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('omega_y [rad/s]')
% 
%         subplot 325
%         plot(data_1(1,index_start_2:index_end_2),data_1(7,index_start_2:index_end_2))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),data_2(7,index_start_3:index_end_3),'r')
%         %plot(data_3(1,index_start_4:index_end_4),data_3(7,index_start_4:index_end_4),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('a_z [m/s^2]')
% 
%         subplot 326
%         plot(data_1(1,index_start_2:index_end_2),data_1(10,index_start_2:index_end_2))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),data_2(10,index_start_3:index_end_3),'r')
%         %plot(data_3(1,index_start_4:index_end_4),data_3(10,index_start_4:index_end_4),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('omega_z [rad/s]')
%     else
%         index_start_2 = median(find((data_1(1,:)-interval_start).^2<0.001));
%         index_start_3 = median(find((data_2(1,:)-interval_start).^2<0.001));
%         %index_start_4 = median(find((data_3(1,:)-interval_start).^2<0.001));
% 
%         index_end_2 = median(find((data_1(1,:)-interval_end).^2<0.001));
%         index_end_3 = median(find((data_2(1,:)-interval_end).^2<0.001));
%         %index_end_4 = median(find((data_3(1,:)-interval_end).^2<0.001));
% 
%         subplot 321
%         plot(data_1(1,index_start_2:index_end_2),filtfilt(d,data_1(5,index_start_2:index_end_2)))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),filtfilt(d,data_2(5,index_start_3:index_end_3)),'r')
%         %plot(data_3(1,index_start_4:index_end_4),filtfilt(d,data_3(5,index_start_4:index_end_4)),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('a_x [m/s^2]')
% 
%         subplot 322
%         plot(data_1(1,index_start_2:index_end_2),filtfilt(d,data_1(8,index_start_2:index_end_2)))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),filtfilt(d,data_2(8,index_start_3:index_end_3)),'r')
%         %plot(data_3(1,index_start_4:index_end_4),filtfilt(d,data_3(8,index_start_4:index_end_4)),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('omega_x [rad/s]')
% 
%         subplot 323
%         plot(data_1(1,index_start_2:index_end_2),filtfilt(d,data_1(6,index_start_2:index_end_2)))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),filtfilt(d,data_2(6,index_start_3:index_end_3)),'r')
%         %plot(data_3(1,index_start_4:index_end_4),filtfilt(d,data_3(6,index_start_4:index_end_4)),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('a_y [m/s^2]')
% 
%         subplot 324
%         plot(data_1(1,index_start_2:index_end_2),filtfilt(d,data_1(9,index_start_2:index_end_2)))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),filtfilt(d,data_2(9,index_start_3:index_end_3)),'r')
%         %plot(data_3(1,index_start_4:index_end_4),filtfilt(d,data_3(9,index_start_4:index_end_4)),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('omega_y [rad/s]')
% 
%         subplot 325
%         plot(data_1(1,index_start_2:index_end_2),filtfilt(d,data_1(7,index_start_2:index_end_2)))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),filtfilt(d,data_2(7,index_start_3:index_end_3)),'r')
%         %plot(data_3(1,index_start_4:index_end_4),filtfilt(d,data_3(7,index_start_4:index_end_4)),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('a_z [m/s^2]')
% 
%         subplot 326
%         plot(data_1(1,index_start_2:index_end_2),filtfilt(d,data_1(10,index_start_2:index_end_2)))
%         hold on;
%         plot(data_2(1,index_start_3:index_end_3),filtfilt(d,data_2(10,index_start_3:index_end_3)),'r')
%         %plot(data_3(1,index_start_4:index_end_4),filtfilt(d,data_3(10,index_start_4:index_end_4)),'Color',[0 0.75 0])
%         xlabel('Time [s]')
%         ylabel('omega_z [rad/s]')
%         
%     end
%     
% else

    % Unpack
    leer = zeros(1,length(imu_data.IMU3.matdatenum));
    try
        [acc_1_data, rot_1_data, matdatenum_1] = extract_struct(imu_data,1);
        data_1 = [matdatenum_1;leer;leer;leer;acc_1_data;rot_1_data];
    catch
        fprintf('IMU 1 not found')
    end
    try
        [acc_2_data, rot_2_data, matdatenum_2] = extract_struct(imu_data,2);
        data_2 = [matdatenum_2;leer;leer;leer;acc_2_data;rot_2_data];
    catch
        fprintf('IMU 2 not found')
    end
    try
        [acc_3_data, rot_3_data, matdatenum_3] = extract_struct(imu_data,3);
        data_3 = [matdatenum_3;leer;leer;leer;acc_3_data;rot_3_data];
    catch
        fprintf('IMU 3 not found')
    end
    try
        [acc_4_data, rot_4_data, matdatenum_4] = extract_struct(imu_data,4);
        data_4 = [matdatenum_4;leer;leer;leer;acc_4_data;rot_4_data];
    catch
        fprintf('IMU 4 not found')
    end
        index_start_1 = find(matdatenum_1>=interval_start,1);
        index_start_2 = find(matdatenum_2>=interval_start,1);
        index_start_3 = find(matdatenum_3>=interval_start,1);
        index_start_4 = find(matdatenum_4>=interval_start,1);

        index_end_1 = find(matdatenum_1>=interval_end,1);
        index_end_2 = find(matdatenum_2>=interval_end,1);
        index_end_3 = find(matdatenum_3>=interval_end,1);
        index_end_4 = find(matdatenum_4>=interval_end,1);
    
    if filter == 0
        subplot 321
        plot(data_2(1,index_start_2:index_end_2),data_2(5,index_start_2:index_end_2))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),data_3(5,index_start_3:index_end_3),'r')
        plot(data_4(1,index_start_4:index_end_4),data_4(5,index_start_4:index_end_4),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),data_1(5,index_start_1:index_end_1),'k')
        xlabel('Time')
        ylabel('a_x [m/s^2]')
        datetick

        subplot 322
        plot(data_2(1,index_start_2:index_end_2),data_2(8,index_start_2:index_end_2))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),data_3(8,index_start_3:index_end_3),'r')
        plot(data_4(1,index_start_4:index_end_4),data_4(8,index_start_4:index_end_4),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),data_1(8,index_start_1:index_end_1),'k')
        xlabel('Time')
        ylabel('omega_x [rad/s]')
        legend('IMU2','IMU3','IMU4','IMU1')
        datetick

        subplot 323
        plot(data_2(1,index_start_2:index_end_2),data_2(6,index_start_2:index_end_2))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),data_3(6,index_start_3:index_end_3),'r')
        plot(data_4(1,index_start_4:index_end_4),data_4(6,index_start_4:index_end_4),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),data_1(6,index_start_1:index_end_1),'k')
        xlabel('Time')
        ylabel('a_y [m/s^2]')
        datetick

        subplot 324
        plot(data_2(1,index_start_2:index_end_2),data_2(9,index_start_2:index_end_2))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),data_3(9,index_start_3:index_end_3),'r')
        plot(data_4(1,index_start_4:index_end_4),data_4(9,index_start_4:index_end_4),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),data_1(9,index_start_1:index_end_1),'k')
        xlabel('Time')
        ylabel('omega_y [rad/s]')
        datetick

        subplot 325
        plot(data_2(1,index_start_2:index_end_2),data_2(7,index_start_2:index_end_2))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),data_3(7,index_start_3:index_end_3),'r')
        plot(data_4(1,index_start_4:index_end_4),data_4(7,index_start_4:index_end_4),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),data_1(7,index_start_1:index_end_1),'k')
        xlabel('Time')
        ylabel('a_z [m/s^2]')
        datetick
        
        subplot 326
        plot(data_2(1,index_start_2:index_end_2),data_2(10,index_start_2:index_end_2))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),data_3(10,index_start_3:index_end_3),'r')
        plot(data_4(1,index_start_4:index_end_4),data_4(10,index_start_4:index_end_4),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),data_1(10,index_start_1:index_end_1),'k')
        xlabel('Time')
        ylabel('omega_z [rad/s]')
        datetick
    else
        subplot 321
        plot(data_2(1,index_start_2:index_end_2),filtfilt(d,data_2(5,index_start_2:index_end_2)))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),filtfilt(d,data_3(5,index_start_3:index_end_3)),'r')
        plot(data_4(1,index_start_4:index_end_4),filtfilt(d,data_4(5,index_start_4:index_end_4)),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),filtfilt(d,data_1(5,index_start_1:index_end_1)),'k')
        xlabel('Time')
        ylabel('a_x [m/s^2]')
        datetick

        subplot 322
        plot(data_2(1,index_start_2:index_end_2),filtfilt(d,data_2(8,index_start_2:index_end_2)))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),filtfilt(d,data_3(8,index_start_3:index_end_3)),'r')
        plot(data_4(1,index_start_4:index_end_4),filtfilt(d,data_4(8,index_start_4:index_end_4)),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),filtfilt(d,data_1(8,index_start_1:index_end_1)),'k')
        xlabel('Time')
        ylabel('omega_x [rad/s]')
        datetick

        subplot 323
        plot(data_2(1,index_start_2:index_end_2),filtfilt(d,data_2(6,index_start_2:index_end_2)))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),filtfilt(d,data_3(6,index_start_3:index_end_3)),'r')
        plot(data_4(1,index_start_4:index_end_4),filtfilt(d,data_4(6,index_start_4:index_end_4)),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),filtfilt(d,data_1(6,index_start_1:index_end_1)),'k')
        xlabel('Time')
        ylabel('a_y [m/s^2]')
        datetick

        subplot 324
        plot(data_2(1,index_start_2:index_end_2),filtfilt(d,data_2(9,index_start_2:index_end_2)))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),filtfilt(d,data_3(9,index_start_3:index_end_3)),'r')
        plot(data_4(1,index_start_4:index_end_4),filtfilt(d,data_4(9,index_start_4:index_end_4)),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),filtfilt(d,data_1(9,index_start_1:index_end_1)),'k')
        xlabel('Time')
        ylabel('omega_y [rad/s]')
        datetick

        subplot 325
        plot(data_2(1,index_start_2:index_end_2),filtfilt(d,data_2(7,index_start_2:index_end_2)))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),filtfilt(d,data_3(7,index_start_3:index_end_3)),'r')
        plot(data_4(1,index_start_4:index_end_4),filtfilt(d,data_4(7,index_start_4:index_end_4)),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),filtfilt(d,data_1(7,index_start_1:index_end_1)),'k')
        xlabel('Time')
        ylabel('a_z [m/s^2]')
        datetick
        
        subplot 326
        plot(data_2(1,index_start_2:index_end_2),filtfilt(d,data_2(10,index_start_2:index_end_2)))
        hold on;
        plot(data_3(1,index_start_3:index_end_3),filtfilt(d,data_3(10,index_start_3:index_end_3)),'r')
        plot(data_4(1,index_start_4:index_end_4),filtfilt(d,data_4(10,index_start_4:index_end_4)),'Color',[0 0.75 0])
        plot(data_1(1,index_start_1:index_end_1),filtfilt(d,data_1(10,index_start_1:index_end_1)),'k')
        xlabel('Time')
        ylabel('omega_z [rad/s]')
        datetick
    end

end

