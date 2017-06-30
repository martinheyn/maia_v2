%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% The data cut tool for IMU data                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% script: This script converts the IMU data to SI units and applies  
% a rotation matrix to allign all readings into the ship frame
% Input data:
%   IMU data: Resampled IMU data in matrix format        
% 
% Output data:
%   IMU data: One matrix with converted and alligned sensor readings for
%   each sensor
%
%    Copyright:     NTNU
%    Project:	    SAMCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2017-01-13  Hans-Martin Heyn (NTNU)
%    Change Log: 

%---------------------------------------------------------------------%
fprintf('o-------------------------------------------o\n')
fprintf('|\t The data cut tool V1.0                \t|\n')
fprintf('o-------------------------------------------o\n\n');

addpath(pwd,'./Tools')
addpath(strcat(pwd,'./Import'))

inputOptions = {'Oh yes please','Hell no, give me all data'};
defSelection = inputOptions{end};
button = bttnChoiseDialog(inputOptions,'Hei der, velkomme',defSelection,'Will you cut the data?'); 

switch button

    case 1
        imu_data_cut = cutIMUdata(imu_data);
        
        if exist('enginedata','var')
            fprintf('Cutting Enginedata \n')
            try
                enginedata_cut = cut_enginedataOden(enginedata,imu_data_cut.starttime,imu_data_cut.endtime);
            catch
                enginedata_cut = cut_enginedataFrej(enginedata,imu_data_cut.starttime,imu_data_cut.endtime);
                fprintf('It was Frej \n')
            end
        end
        
        if exist('shipdata','var')
            fprintf('Cutting Shipdata \n')
            shipdata_cut = cut_shipdata(shipdata,imu_data_cut.starttime,imu_data_cut.endtime);
        end
        
    case 2
        fprintf('All right, have a pleasent day \n')
end

clear defSelection button inputOptions
