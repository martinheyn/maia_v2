%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This function preprocesses a signal and evaluates its tf-distribution %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maia_tfd: This function creates the tf-distribution of a signal from the
% IMU
%
% Input data:
%   signal: The acceleration or velocity data from the IMU
%   freq:  The sampling frequency
% 
% Output data:
%   tfr: Time-frequency distribution
%   t: Time vector
%   f: Frequency bins
%   signal: The signal. which should not change (Why do I do that??)
%
%    Copyright:     NTNU
%    Project:	    SAMCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2015-11-19  Hans-Martin Heyn (NTNU)
%    Change Log:    2015-12-02 Hans-Martin Heyn (NTNU)
%                             - Changed name to maia



%---------------------------------------------------------------------%
%function [tfr,t,f,signal_lp_hil] = maia_tfd(signal, freq)
function [tfr,t,f,signal_lp_hil] = maia_tfd(signal)
% First we apply a LP to remove unwanted frequencies (here above 200 Hz,
% but we change that later to higher values)
%signal_lp = maia_lp(detrend(signal'),freq);

% Now we apply the Hilbert transformation to make the signal analytic
% (meaning removing the negative frequency components, that might cause
% cross-coupling effects in the TFD)

signal_lp_hil = hilbert(detrend(signal));

% This function processes the Time Frequency Distribution of a given
% acceleration signal, that is analytic

% Create a window function
%h = hamming(length(signal_lp_hil)/4);
timeindex = 1:1:size(signal_lp_hil);
[tfr,t,f] = tfrpwv(signal_lp_hil,timeindex,length(timeindex));
% Visualisation of TFD
% tfrqview(tfr,signal_lp_hil,timeindex,'tfrpwv');
% tfrpwv(signal_lp_hil,t);
% tfrqview(tfr,signal_lp_hil)

end
