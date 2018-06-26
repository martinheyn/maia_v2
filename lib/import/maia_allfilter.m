%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A band-pass filter approach for the IMU data                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% csimu_lp: This function is a low-pass filter for ADIS IMU data 
% 
% Input data:
%   ADIS_sig: The acceleration or velocity data from the IMU
%   Fsample:  The sampling frequency
% 
% Output data:
%   LP_ADIS_sig: The low-pass filtered data. The low-pass filter has a
%   cutoff frequency of 0.95*0.5*Fs . 0.5 for Nyquist, 0.95 as an extra
%   margin. 
%
%    Copyright:     NTNU
%    Project:	    SAMCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-11-22  Hans-Martin Heyn (NTNU)
%    Change Log: 


function[LP_ADIS_sig] = maia_allfilter(ADIS_sig,F_sample,df)

% First a low-pass FIR filter is applied to remove frequency above any
% useful frequency
% Since the sampling rate was 205 Hz, the first useful frequency is 102.5
% Hz. 

%N   = 10;           % FIR filter order
%Fp  = Fcut;         % Cutoff Frequency
Fs  = F_sample ;     % Sampling frequency
indata = ADIS_sig';

%Fnorm = Fp/(Fs/2); % Normalized frequency



% Filter introduces a time delay, called group delay. This delay will be
% identified here and removed from the data.
grpdelay(df,2048,Fs);
D = round(mean(grpdelay(df)));
filterdata = filter(df,[indata';zeros(D,1)]);
filterdata = filterdata(D+1:end);
% info(df)
%Plot filtered data
% figure
% plot(indata,'b--')
% hold
% plot(filterdata,'r')
% legend('Original Data','Filtered Data')

LP_ADIS_sig = filterdata;
end







