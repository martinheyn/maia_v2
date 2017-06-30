%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This script runs the Rotation Finder Tool       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Output data:
%   IMU data struct for selected time-frame
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-08-24  Hans-Martin Heyn (NTNU)
%    

%---------------------------------------------------------------------%

addpath .\Tools .\Import

    inputOptions = {'Cut Data','Raw data'};
        defSelection = inputOptions{end};
        button3 = bttnChoiseDialog(inputOptions,'Hei der, velkomme',defSelection,'What data will you use?'); 
        
        switch button3
            
            case 1
                imu_data = imu_data_cut;
            case 2
                imu_data = imu_data_raw;
        end

Tool_RotationFinder

clear button3 inputOptions defSelection
