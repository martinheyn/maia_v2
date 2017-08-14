%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This script runs the filter signal tool       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2017-08-14  Hans-Martin Heyn (NTNU)
%    

%---------------------------------------------------------------------%

imu_data_aligned_prefiltered = imu_data_aligned;

clear imu_data_aligned

userinput = inputdlg({'What is the desired frequency for resampling?'},'',1,...
        {'Frequency in Hz'});
freq_d = str2num(userinput{:}); %Hz

imu_data_aligned = resample_IMUstructdata(imu_data_aligned_prefiltered,freq_d);