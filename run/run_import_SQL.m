%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This scripts runs the import of SQL data from Frej or Oden           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script allows the import of SQL data from Frej or Oden into a
% structure for later processing
% 
%
% Input data:
%   A GUI requests the .csv files from the SQL database export
%   
% Output data:
%   Two structs, shipdata for navigational data and enginedata for engine
%   data
%  
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-08-21  Hans-Martin Heyn (NTNU)
%    

%---------------------------------------------------------------------%

fprintf('o---------------------------------------------o\n')
fprintf('|\t The SQL import tool V1.0                \t|\n')
fprintf('o-------------------------------------------o\n\n');

% Shipdata
[CSVName,CSVDir] = uigetfile('.csv','Select the shipdata file','*.csv');
% Enginedata
[CSVengineName,CSVengineDir] = uigetfile('.csv','Select the engine data file','*.csv');

inputOptions = {'JA','NEI'};
defSelection = inputOptions{end};
button = bttnChoiseDialog(inputOptions,'Make it so!',defSelection,'Do you want to cut the data to IMU timewindow?');


if CSVName ~= 0
    switch missionselect
        case 1
            [shipdata.timestamp,shipdata.heading,shipdata.COG,shipdata.SOG,shipdata.GPS_lon,shipdata.GPS_lat,shipdata.windDirTrue,shipdata.windSpeedTrue,shipdata.windDirRel,shipdata.windSpeedRel,shipdata.SQL_depth] = Tool_Import_SQL_Frej(strcat(CSVDir,CSVName),2,inf);
%             if button == 1
%                 shipdata_cut = cut_shipdata(shipdata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
%             end   
        case 2
            [shipdata.timestamp,shipdata.heading,shipdata.COG,shipdata.SOG,shipdata.GPS_lon,shipdata.GPS_lat,shipdata.windDirTrue,shipdata.windSpeedTrue,shipdata.windDirRel,shipdata.windSpeedRel]=Tool_Import_SQL_Oden(strcat(CSVDir,CSVName),2,inf);
%             if button == 1
%                 shipdata_cut = cut_shipdata(shipdata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
%             end      
        case 3
%             [shipdata.timestamp,shipdata.heading,shipdata.COG,shipdata.SOG,shipdata.GPS_lon,shipdata.GPS_lat,shipdata.windDirTrue,shipdata.windSpeedTrue,shipdata.windDirRel,shipdata.windSpeedRel]=Tool_Import_SQL_Oden(strcat(CSVDir,CSVName),2,inf);
%             if button == 1
%                 shipdata_cut = cut_shipdata(shipdata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
%             end
                
        case 4
            [shipdata.timestamp,shipdata.heading,shipdata.COG,shipdata.SOG,shipdata.GPS_lon,shipdata.GPS_lat,shipdata.windDirTrue,shipdata.windSpeedTrue,shipdata.windDirRel,shipdata.windSpeedRel]=Tool_Import_SQL_Oden(strcat(CSVDir,CSVName),2,inf);
            %if button == 1 
                %shipdata_cut = cut_shipdata(shipdata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)')); 
            %end
    end
    if button == 1
        %shipdata_cut = cut_shipdata(shipdata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
        shipdata_cut = cut_shipdata(shipdata,imu_data_raw.IMU3.matdatenum(1),imu_data_raw.IMU3.matdatenum(end));
    end
end

if CSVengineName ~= 0
    switch missionselect
        case 1
           [enginedata.timestamp,enginedata.id,enginedata.RPM1,enginedata.RPM2,enginedata.RPM3,enginedata.RPM4,enginedata.PWR1,enginedata.PWR2,enginedata.PWR3,enginedata.PWR4,enginedata.Rudder] = Tool_Import_SQLEngine_Frej(strcat(CSVengineDir,CSVengineName),2,inf);
            %if button == 1
                %enginedata_cut = cut_enginedataFrej(enginedata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
            %end
        
        case 2
            [enginedata.timestamp,enginedata.rudder_port,enginedata.rudder_stbd,enginedata.pitch_port,enginedata.pitch_stbd,enginedata.rpm_port,enginedata.rpm_stbd,enginedata.torque_port,enginedata.torque_stbd,enginedata.power_port,enginedata.power_stbd] = Tool_Import_SQLEngine_Oden_AO16(strcat(CSVengineDir,CSVengineName),2,inf);
            %if button == 1
                %enginedata_cut = cut_enginedataOden(enginedata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
            %end
        case 3
           [enginedata.timestamp,enginedata.rudder_port,enginedata.rudder_stbd,enginedata.pitch_port,enginedata.pitch_stbd,enginedata.rpm_port,enginedata.rpm_stbd,enginedata.torque_port,enginedata.torque_stbd,enginedata.power_port,enginedata.power_stbd] = Tool_Import_SQLEngine_Oden_AO16(strcat(CSVengineDir,CSVengineName),2,inf);
            %if button == 1
                %enginedata_cut = cut_enginedataOden(enginedata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
            %end
        case 4
           [enginedata.timestamp,enginedata.rudder_port,enginedata.rudder_stbd,enginedata.pitch_port,enginedata.pitch_stbd,enginedata.rpm_port,enginedata.rpm_stbd,enginedata.torque_port,enginedata.torque_stbd,enginedata.power_port,enginedata.power_stbd] = Tool_Import_SQLEngine_Oden_AO16(strcat(CSVengineDir,CSVengineName),2,inf);
            %if button == 1
                %enginedata_cut = cut_enginedataOden(enginedata,datenum(imu_3_data_si(14:19,1)'),datenum(imu_3_data_si(14:19,end)'));
            %end
    end
    
    if button == 1
        if missionselect == 1
            enginedata_cut = cut_enginedataFrej(enginedata,imu_data_raw.IMU3.matdatenum(1),imu_data_raw.IMU3.matdatenum(end));
        else
            enginedata_cut = cut_enginedataOden(enginedata,imu_data_raw.IMU3.matdatenum(1),imu_data_raw.IMU3.matdatenum(end));
        end
    end
    
end



clear CSVName CSVDir CSVengineName CSVengineDir

