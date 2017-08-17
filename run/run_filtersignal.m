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

inputOptions = {'Just filter','Filter and resample','Back :)'};
        defSelection = inputOptions{end};
        button = bttnChoiseDialog(inputOptions,'Hei der, velkomme',defSelection,'What will you do?'); 

        switch button
		
			case 1
			inputOptions = {'Lowpass','Highpass','Bandpass','Take me back'};
            defSelection = inputOptions{1};
            button2 = bttnChoiseDialog(inputOptions,'What filter do you want?',defSelection,'Hei da :)');

            switch button2
                case 1
                    prompt = {'F_s:','F_pass','F_stop:'};
                    userinput = inputdlg(prompt,'Frequencies',1,{'F_s','F_pass','F_stop'});
                    Fs = str2double(cell2mat(userinput(1)));
                    Fpass = str2double(cell2mat(userinput(2)));
                    Fstop = str2double(cell2mat(userinput(3)));
                    
                    %Designing filter
                    Astop = 120;
                    Apass = 0.5;

                    df = designfilt('lowpassfir','StopbandFrequency',Fstop, ...
                      'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
                      'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','equiripple');
                  
                case 2
                    prompt = {'F_s:','F_stop','F_pass:'};
                    userinput = inputdlg(prompt,'Frequencies',1,{'F_s','F_stop','F_pass'});
                    Fs = str2double(cell2mat(userinput(1)));
                    Fpass = str2double(cell2mat(userinput(3)));
                    Fstop = str2double(cell2mat(userinput(2)));
                    
                    %Designing filter
                    Astop = 120;
                    Apass = 0.5;

                    df = designfilt('highpassfir','StopbandFrequency',Fstop, ...
                      'PassbandFrequency',Fpass,'StopbandAttenuation',Astop, ...
                      'PassbandRipple',Apass,'SampleRate',Fs,'DesignMethod','equiripple');

                    %df = designfilt;
                    fvtool(df,'Fs',Fs,'Color','White') % Visualize filter
                    
                case 3
                    prompt = {'F_s:','F_stop1','F_pass1:','F_pass2','F_stop2:'};
                    userinput = inputdlg(prompt,'Frequencies',1,{'F_s:','F_stop1','F_pass1:','F_pass2','F_stop2:'});
                    Fs = str2double(cell2mat(userinput(1)));
                    Fpass1 = str2double(cell2mat(userinput(3)));
                    Fstop1 = str2double(cell2mat(userinput(2)));
                    Fpass2 = str2double(cell2mat(userinput(4)));
                    Fstop2 = str2double(cell2mat(userinput(5)));
                    
                    %Designing filter
                    Astop = 120;
                    Apass = 0.5;

                    df = designfilt('bandpassfir','StopbandFrequency1',Fstop1, ...
                        'PassbandFrequency1',Fpass1,'StopbandFrequency2',Fstop2, ...
                        'PassbandFrequency2',Fpass2,'StopbandAttenuation1',Astop, ...
                        'PassbandRipple',Apass,'StopbandAttenuation2',Astop,...
                        'SampleRate',Fs,'DesignMethod','equiripple');

                    %df = designfilt;
                    fvtool(df,'Fs',Fs,'Color','White') % Visualize filter
            end
                
            if button2 ~= 4
                for u = 1:1:4
                    if u == 1
                        selectedIMU = 'IMU1';
                    elseif u == 2
                        selectedIMU = 'IMU2';
                    elseif u == 3
                        selectedIMU = 'IMU3';
                    elseif u == 4
                        selectedIMU = 'IMU4';
                    end

                    if isfield(imu_data_aligned_prefiltered,(selectedIMU))
                        imu_data_aligned.(selectedIMU).signal_surge = maia_allfilter(imu_data_aligned_prefiltered.(selectedIMU).signal_surge,Fs,df);
                        imu_data_aligned.(selectedIMU).signal_sway = maia_allfilter(imu_data_aligned_prefiltered.(selectedIMU).signal_sway,Fs,df);
                        
                        temp_heave_mean = mean(imu_data_aligned_prefiltered.(selectedIMU).signal_heave); % This is to preserve the gravity offset
                        imu_data_aligned.(selectedIMU).signal_heave = maia_allfilter(detrend(imu_data_aligned_prefiltered.(selectedIMU).signal_heave),Fs,df) + temp_heave_mean;
                        clear temp_heave_mean
                        
                        imu_data_aligned.(selectedIMU).signal_roll = maia_allfilter(imu_data_aligned_prefiltered.(selectedIMU).signal_roll,Fs,df);
                        imu_data_aligned.(selectedIMU).signal_pitch = maia_allfilter(imu_data_aligned_prefiltered.(selectedIMU).signal_pitch,Fs,df);
                        imu_data_aligned.(selectedIMU).signal_yaw = maia_allfilter(imu_data_aligned_prefiltered.(selectedIMU).signal_yaw,Fs,df);
                        imu_data_aligned.(selectedIMU).matdatenum = linspace(imu_data_aligned_prefiltered.(selectedIMU).matdatenum(1),imu_data_aligned_prefiltered.(selectedIMU).matdatenum(end),length(imu_data_aligned_prefiltered.(selectedIMU).matdatenum));
                        imu_data_aligned.filter = df;
                        %imu_data_FILT.(selectedIMU).t_cc = linspace(imu_data.(selectedIMU).t_cc(1),imu_data.(selectedIMU).t_cc(end),length(imu_data.(selectedIMU).t_cc));
                    end
                end
            end
            clear button2
            close all
			
			case 2

				clear imu_data_aligned
				userinput = inputdlg({'What is the desired frequency for resampling?'},'',1,...
						{'Frequency in Hz'});
				freq_d = str2num(userinput{:}); %Hz

				imu_data_aligned = resample_IMUstructdata(imu_data_aligned_prefiltered,freq_d);
			
			case 3
				fprintf('OK, going back doing nothing\n');
			
			end