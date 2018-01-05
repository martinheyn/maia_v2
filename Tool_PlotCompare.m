%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script re-samples the given files with a set frequency and stores %
% it in the ReSampledData folder                                         % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close all;
clc;

%---------------------------------------------------------------------%
% User input to ask for start and stop time

if missionselect == 1
    legendtext3 = [{'Däck9'},{'port'},{'starboard'}];
    legendtext3a = [{'mid'},{'port'},{'starboard'}];
    legendtext4 = [{'Däck9'},{'mid'},{'port'},{'starboard'}];
elseif missionselect == 2
    legendtext3 = [{'IMU1'},{'IMU3'},{'IMU4'}];
    legendtext3a = [{'IMU2'},{'IMU3'},{'IMU4'}];
    legendtext4 = [{'IMU1'},{'IMU2'},{'IMU3'},{'IMU4'}];
elseif missionselect == (3 || 4)
    legendtext4 = [{'Midship'},{'Bow'},{'Port'},{'Starboard'}];
else
    legendtext3 = [{'IMU1'},{'IMU3'},{'IMU4'}];
    legendtext3a = [{'IMU2'},{'IMU3'},{'IMU4'}];
    legendtext4 = [{'IMU1'},{'IMU2'},{'IMU3'},{'IMU4'}];
	legendtext5 = [{'IMU2'},{'IMU3'},{'IMU4'},{'IMU5'},{'IMU6'}];
end


fprintf('o-----------------------------------------------o\n')
fprintf('|\t IMU TOOLS v01: THE PLOTCOMPARE SCRIPT  \t|\n')
fprintf('o-----------------------------------------------o\n\n');

%     figure('Name','Unfiltered data');
%     set(gcf, 'Position', get(0, 'Screensize'));
%     
%     subplot 321
% 	hold on;
% 	
% 	if (isfield(imu_data,'IMU1'))
% 		plot(imu_data.IMU1.matdatenum, imu_data.IMU1.signal_surge,'m')
% 	end
%     if (isfield(imu_data,'IMU2'))
% 		plot(imu_data.IMU2.matdatenum, imu_data.IMU2.signal_surge,'b')
% 	end
% 	if (isfield(imu_data,'IMU3'))
% 		plot(imu_data.IMU3.matdatenum, imu_data.IMU3.signal_surge,'r')
% 	end
% 	if (isfield(imu_data,'IMU4'))
% 		plot(imu_data.IMU4.matdatenum, imu_data.IMU4.signal_surge,'g')
% 	end
% 	if (isfield(imu_data,'IMU5'))
% 		plot(imu_data.IMU5.matdatenum, imu_data.IMU5.signal_surge,'k')
% 	end
% 	
%     xlabel('Time (s)')
%     ylabel('a_x (m \cdot s^{-2})')
%     grid on
%     datetick
% 
%     subplot 322
%     hold on;
% 	
% 	if (isfield(imu_data,'IMU1'))
% 		plot(imu_data.IMU1.matdatenum, imu_data.IMU1.signal_roll,'m')
% 	end
%     if (isfield(imu_data,'IMU2'))
% 		plot(imu_data.IMU2.matdatenum, imu_data.IMU2.signal_roll,'b')
% 	end
% 	if (isfield(imu_data,'IMU3'))
% 		plot(imu_data.IMU3.matdatenum, imu_data.IMU3.signal_roll,'r')
% 	end
% 	if (isfield(imu_data,'IMU4'))
% 		plot(imu_data.IMU4.matdatenum, imu_data.IMU4.signal_roll,'g')
% 	end
% 	if (isfield(imu_data,'IMU5'))
% 		plot(imu_data.IMU5.matdatenum, imu_data.IMU5.signal_roll,'k')
% 	end
% 	
%     xlabel('Time (s)')
%     ylabel('\omega_x (^\circ \cdot s^{-1})')
%     grid on
%     datetick
%     
%     subplot 323
% 	hold on;
% 	
% 	if (isfield(imu_data,'IMU1'))
% 		plot(imu_data.IMU1.matdatenum, imu_data.IMU1.signal_sway,'m')
% 	end
%     if (isfield(imu_data,'IMU2'))
% 		plot(imu_data.IMU2.matdatenum, imu_data.IMU2.signal_sway,'b')
% 	end
% 	if (isfield(imu_data,'IMU3'))
% 		plot(imu_data.IMU3.matdatenum, imu_data.IMU3.signal_sway,'r')
% 	end
% 	if (isfield(imu_data,'IMU4'))
% 		plot(imu_data.IMU4.matdatenum, imu_data.IMU4.signal_sway,'g')
% 	end
% 	if (isfield(imu_data,'IMU5'))
% 		plot(imu_data.IMU5.matdatenum, imu_data.IMU5.signal_sway,'k')
% 	end
% 	
%     xlabel('Time (s)')
%     ylabel('a_y (m \cdot s^{-2})')
%     grid on
%     datetick
%     
%     subplot 324
%     hold on;
% 	
% 	if (isfield(imu_data,'IMU1'))
% 		plot(imu_data.IMU1.matdatenum, imu_data.IMU1.signal_pitch,'m')
% 	end
%     if (isfield(imu_data,'IMU2'))
% 		plot(imu_data.IMU2.matdatenum, imu_data.IMU2.signal_pitch,'b')
% 	end
% 	if (isfield(imu_data,'IMU3'))
% 		plot(imu_data.IMU3.matdatenum, imu_data.IMU3.signal_pitch,'r')
% 	end
% 	if (isfield(imu_data,'IMU4'))
% 		plot(imu_data.IMU4.matdatenum, imu_data.IMU4.signal_pitch,'g')
% 	end
% 	if (isfield(imu_data,'IMU5'))
% 		plot(imu_data.IMU5.matdatenum, imu_data.IMU5.signal_pitch,'k')
% 	end
% 	
%     xlabel('Time (s)')
%     ylabel('\omega_y (^\circ \cdot s^{-1})')
%     grid on
%     datetick
%     
%     subplot 325
% 	hold on;
% 	
% 	if (isfield(imu_data,'IMU1'))
% 		plot(imu_data.IMU1.matdatenum, imu_data.IMU1.signal_heave,'m')
% 	end
%     if (isfield(imu_data,'IMU2'))
% 		plot(imu_data.IMU2.matdatenum, imu_data.IMU2.signal_heave,'b')
% 	end
% 	if (isfield(imu_data,'IMU3'))
% 		plot(imu_data.IMU3.matdatenum, imu_data.IMU3.signal_heave,'r')
% 	end
% 	if (isfield(imu_data,'IMU4'))
% 		plot(imu_data.IMU4.matdatenum, imu_data.IMU4.signal_heave,'g')
% 	end
% 	if (isfield(imu_data,'IMU5'))
% 		plot(imu_data.IMU5.matdatenum, imu_data.IMU5.signal_heave,'k')
% 	end
% 	
%     xlabel('Time (s)')
%     ylabel('a_z (m \cdot s^{-2})')
%     grid on
%     datetick
%     
%     subplot 326
%     hold on;
% 	
% 	if (isfield(imu_data,'IMU1'))
% 		plot(imu_data.IMU1.matdatenum, imu_data.IMU1.signal_yaw,'m')
% 	end
%     if (isfield(imu_data,'IMU2'))
% 		plot(imu_data.IMU2.matdatenum, imu_data.IMU2.signal_yaw,'b')
% 	end
% 	if (isfield(imu_data,'IMU3'))
% 		plot(imu_data.IMU3.matdatenum, imu_data.IMU3.signal_yaw,'r')
% 	end
% 	if (isfield(imu_data,'IMU4'))
% 		plot(imu_data.IMU4.matdatenum, imu_data.IMU4.signal_yaw,'g')
% 	end
% 	if (isfield(imu_data,'IMU5'))
% 		plot(imu_data.IMU5.matdatenum, imu_data.IMU5.signal_yaw,'k')
% 	end
% 	
%     xlabel('Time (s)')
%     ylabel('\omega_z (^\circ \cdot s^{-1})')
%     grid on
% 	datetick
% 	
    %%
    % filterdesign
    d = designfilt('lowpassfir','PassbandFrequency',0.005, ...
             'StopbandFrequency',0.02,'PassbandRipple',0.5, ...
             'StopbandAttenuation',65,'DesignMethod','kaiserwin');
    fvtool(d)   

    figure('Name','Zero phase filtered data');
    set(gcf, 'Position', get(0, 'Screensize'));
    
    subplot 321
	hold on;
	
	if (isfield(imu_data,'IMU1'))
		plot(imu_data.IMU1.matdatenum, filtfilt(d,imu_data.IMU1.signal_surge),'m')
	end
    if (isfield(imu_data,'IMU2'))
		plot(imu_data.IMU2.matdatenum, filtfilt(d,imu_data.IMU2.signal_surge),'b')
	end
	if (isfield(imu_data,'IMU3'))
		plot(imu_data.IMU3.matdatenum, filtfilt(d,imu_data.IMU3.signal_surge),'r')
	end
	if (isfield(imu_data,'IMU4'))
		plot(imu_data.IMU4.matdatenum, filtfilt(d,imu_data.IMU4.signal_surge),'g')
	end
	if (isfield(imu_data,'IMU5'))
		plot(imu_data.IMU5.matdatenum, filtfilt(d,imu_data.IMU5.signal_surge),'k')
	end
	
    xlabel('Time (s)')
    ylabel('a_x (m \cdot s^{-2})')
    grid on
    datetick

    subplot 322
    hold on;
	
	if (isfield(imu_data,'IMU1'))
		plot(imu_data.IMU1.matdatenum, filtfilt(d,imu_data.IMU1.signal_roll),'m')
	end
    if (isfield(imu_data,'IMU2'))
		plot(imu_data.IMU2.matdatenum, filtfilt(d,imu_data.IMU2.signal_roll),'b')
	end
	if (isfield(imu_data,'IMU3'))
		plot(imu_data.IMU3.matdatenum, filtfilt(d,imu_data.IMU3.signal_roll),'r')
	end
	if (isfield(imu_data,'IMU4'))
		plot(imu_data.IMU4.matdatenum, filtfilt(d,imu_data.IMU4.signal_roll),'g')
	end
	if (isfield(imu_data,'IMU5'))
		plot(imu_data.IMU5.matdatenum, filtfilt(d,imu_data.IMU5.signal_roll),'k')
	end
	
    xlabel('Time (s)')
    ylabel('\omega_x (^\circ \cdot s^{-1})')
    grid on
    datetick
    
    subplot 323
	hold on;
	
	if (isfield(imu_data,'IMU1'))
		plot(imu_data.IMU1.matdatenum, filtfilt(d,imu_data.IMU1.signal_sway),'m')
	end
    if (isfield(imu_data,'IMU2'))
		plot(imu_data.IMU2.matdatenum, filtfilt(d,imu_data.IMU2.signal_sway),'b')
	end
	if (isfield(imu_data,'IMU3'))
		plot(imu_data.IMU3.matdatenum, filtfilt(d,imu_data.IMU3.signal_sway),'r')
	end
	if (isfield(imu_data,'IMU4'))
		plot(imu_data.IMU4.matdatenum, filtfilt(d,imu_data.IMU4.signal_sway),'g')
	end
	if (isfield(imu_data,'IMU5'))
		plot(imu_data.IMU5.matdatenum, filtfilt(d,imu_data.IMU5.signal_sway),'k')
	end
	
    xlabel('Time (s)')
    ylabel('a_y (m \cdot s^{-2})')
    grid on
    datetick
    
    subplot 324
    hold on;
	
	if (isfield(imu_data,'IMU1'))
		plot(imu_data.IMU1.matdatenum, filtfilt(d,imu_data.IMU1.signal_pitch),'m')
	end
    if (isfield(imu_data,'IMU2'))
		plot(imu_data.IMU2.matdatenum, filtfilt(d,imu_data.IMU2.signal_pitch),'b')
	end
	if (isfield(imu_data,'IMU3'))
		plot(imu_data.IMU3.matdatenum, filtfilt(d,imu_data.IMU3.signal_pitch),'r')
	end
	if (isfield(imu_data,'IMU4'))
		plot(imu_data.IMU4.matdatenum, filtfilt(d,imu_data.IMU4.signal_pitch),'g')
	end
	if (isfield(imu_data,'IMU5'))
		plot(imu_data.IMU5.matdatenum, filtfilt(d,imu_data.IMU5.signal_pitch),'k')
	end
	
    xlabel('Time (s)')
    ylabel('\omega_y (^\circ \cdot s^{-1})')
    grid on
    datetick
    
    subplot 325
	hold on;
	
	if (isfield(imu_data,'IMU1'))
		plot(imu_data.IMU1.matdatenum, filtfilt(d,imu_data.IMU1.signal_heave),'m')
	end
    if (isfield(imu_data,'IMU2'))
		plot(imu_data.IMU2.matdatenum, filtfilt(d,imu_data.IMU2.signal_heave),'b')
	end
	if (isfield(imu_data,'IMU3'))
		plot(imu_data.IMU3.matdatenum, filtfilt(d,imu_data.IMU3.signal_heave),'r')
	end
	if (isfield(imu_data,'IMU4'))
		plot(imu_data.IMU4.matdatenum, filtfilt(d,imu_data.IMU4.signal_heave),'g')
	end
	if (isfield(imu_data,'IMU5'))
		plot(imu_data.IMU5.matdatenum, filtfilt(d,imu_data.IMU5.signal_heave),'k')
	end
	
    xlabel('Time (s)')
    ylabel('a_z (m \cdot s^{-2})')
    grid on
    datetick
    
    subplot 326
    hold on;
	
	if (isfield(imu_data,'IMU1'))
		plot(imu_data.IMU1.matdatenum, filtfilt(d,imu_data.IMU1.signal_yaw),'m')
	end
    if (isfield(imu_data,'IMU2'))
		plot(imu_data.IMU2.matdatenum, filtfilt(d,imu_data.IMU2.signal_yaw),'b')
	end
	if (isfield(imu_data,'IMU3'))
		plot(imu_data.IMU3.matdatenum, filtfilt(d,imu_data.IMU3.signal_yaw),'r')
        legend(legendtext3);
	end
	if (isfield(imu_data,'IMU4'))
		plot(imu_data.IMU4.matdatenum, filtfilt(d,imu_data.IMU4.signal_yaw),'g')
        legend(legendtext4);
	end
	if (isfield(imu_data,'IMU5'))
		plot(imu_data.IMU5.matdatenum, filtfilt(d,imu_data.IMU5.signal_yaw),'k')
        legend(legendtext5);
	end
	
    xlabel('Time (s)')
    ylabel('\omega_z (^\circ \cdot s^{-1})')
    grid on
	datetick

fprintf('\t -> Enjoy the plots\n\n\t FINE!\n');

clear legendtext3 legendtext3a legendtext4