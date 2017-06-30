%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This scripts creates a user interface to conduct pdf-analysis of data   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
%
%  
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-04-11  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%

function [estimatedpdf] = maia_multicomparecdf(IMUdatastruct)

button = 0;
userrequest = 1;
counter = 1;

% Data preparation (this is necessary because I wrote the script before I
% introduced the struct-concept for the data and I don't want to rewrite
% everything now).
            
        if (isfield(IMUdatastruct,'IMU1'))
            signal_surge_1 = IMUdatastruct.IMU1.signal_surge;
            signal_sway_1 = IMUdatastruct.IMU1.signal_sway;
            signal_heave_1 = IMUdatastruct.IMU1.signal_heave;
            signal_roll_1 = IMUdatastruct.IMU1.signal_roll;
            signal_pitch_1 = IMUdatastruct.IMU1.signal_pitch;
            signal_yaw_1 = IMUdatastruct.IMU1.signal_yaw;
        end

        if (isfield(IMUdatastruct,'IMU2'))
            signal_surge_2 = IMUdatastruct.IMU2.signal_surge;
            signal_sway_2 = IMUdatastruct.IMU2.signal_sway;
            signal_heave_2 = IMUdatastruct.IMU2.signal_heave;
            signal_roll_2 = IMUdatastruct.IMU2.signal_roll;
            signal_pitch_2 = IMUdatastruct.IMU2.signal_pitch;
            signal_yaw_2 = IMUdatastruct.IMU2.signal_yaw;
        end

        if (isfield(IMUdatastruct,'IMU3'))
            signal_surge_3 = IMUdatastruct.IMU3.signal_surge;
            signal_sway_3 = IMUdatastruct.IMU3.signal_sway;
            signal_heave_3 = IMUdatastruct.IMU3.signal_heave;
            signal_roll_3 = IMUdatastruct.IMU3.signal_roll;
            signal_pitch_3 = IMUdatastruct.IMU3.signal_pitch;
            signal_yaw_3 = IMUdatastruct.IMU3.signal_yaw;
         end

        if (isfield(IMUdatastruct,'IMU4'))
            signal_surge_4 = IMUdatastruct.IMU4.signal_surge;
            signal_sway_4 = IMUdatastruct.IMU4.signal_sway;
            signal_heave_4 = IMUdatastruct.IMU4.signal_heave;
            signal_roll_4 = IMUdatastruct.IMU4.signal_roll;
            signal_pitch_4 = IMUdatastruct.IMU4.signal_pitch;
            signal_yaw_4 = IMUdatastruct.IMU4.signal_yaw;
        end
		   
	   if (isfield(IMUdatastruct,'IMU5'))
            signal_surge_5 = IMUdatastruct.IMU5.signal_surge;
            signal_sway_5 = IMUdatastruct.IMU5.signal_sway;
            signal_heave_5 = IMUdatastruct.IMU5.signal_heave;
            signal_roll_5 = IMUdatastruct.IMU5.signal_roll;
            signal_pitch_5 = IMUdatastruct.IMU5.signal_pitch;
            signal_yaw_5 = IMUdatastruct.IMU5.signal_yaw;
        end

while userrequest == 1

    if (isfield(IMUdatastrcut,'IMU5')
		inputOptions = {'1','2','3','4,','5','ALL','Done'};
		defSelection = inputOptions{end}
		button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
	elseif (isfield(IMUdatastruct,'IMU1') && isfield(IMUdatastruct,'IMU2'))    
        inputOptions = {'1','2','3','4','ALL','Done'};
        defSelection = inputOptions{end};
        button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
    elseif isfield(IMUdatastruct,'IMU2')
        inputOptions = {'2','3','4','ALL','Done'};
        defSelection = inputOptions{end};
        button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
        button = button + 1;
    elseif isfield(IMUdatastruct,'IMU1')
        inputOptions = {'1','3','4','ALL','Done'};
        defSelection = inputOptions{end};
        button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
        if button == 1
            button = 1;
        else
            button = button + 1;
        end
    else
        inputOptions = {'3','4','ALL','Done'};
        defSelection = inputOptions{end};
        button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
        button = button + 2;
    end

	if (isfield(IMUdatastrcut,'IMU5')
		if (button == 7)
			userrequest = 0;
		end
		
		if (button == 6)
			counter = 5;
			button = 1;
		end
	else
		
		if (button == 6)
			userrequest = 0;
		
		else
			if button == 5
				counter = 4;
				button = 1;
			end
		end
	end
	
	if counter > 1

        for k = 1:1:counter
            g = figure('Position',[35 162 890 788]);
            text(.75,1.25,strcat('Probplot of data from IMU',{' '},num2str(button)));


            h = subplot(3,2,1)

            data = eval(genvarname(strcat('signal_surge_',num2str(button))));
            datastring = 'a_x [m \cdot s^{-2}]';

            imuid = strcat('IMU',num2str(button));
            dof = 'signal_surge';
            [estimatedpdf.(imuid).(dof).norm,estimatedpdf.(imuid).(dof).t,estimatedpdf.(imuid).(dof).laplace,estimatedpdf.(imuid).(dof).cauchy] = maia_comparecdf(data,datastring,h);

            h = subplot(3,2,3)

            data = eval(genvarname(strcat('signal_sway_',num2str(button))));
            datastring = 'a_y [m \cdot s^{-2}]';

            imuid = strcat('IMU',num2str(button));
            dof = 'signal_sway';
            [estimatedpdf.(imuid).(dof).norm,estimatedpdf.(imuid).(dof).t,estimatedpdf.(imuid).(dof).laplace,estimatedpdf.(imuid).(dof).cauchy] = maia_comparecdf(data,datastring,h);

            h = subplot(3,2,5)

            data = eval(genvarname(strcat('signal_heave_',num2str(button))));
            datastring = 'a_z [m \cdot s^{-2}]';

            imuid = strcat('IMU',num2str(button));
            dof = 'signal_heave';
            [estimatedpdf.(imuid).(dof).norm,estimatedpdf.(imuid).(dof).t,estimatedpdf.(imuid).(dof).laplace,estimatedpdf.(imuid).(dof).cauchy] = maia_comparecdf(data,datastring,h);

            h = subplot(3,2,2)

            data = eval(genvarname(strcat('signal_roll_',num2str(button))));
            datastring = '\omega_x [1 \cdot s^{-1}]';

            imuid = strcat('IMU',num2str(button));
            dof = 'signal_roll';
            [estimatedpdf.(imuid).(dof).norm,estimatedpdf.(imuid).(dof).t,estimatedpdf.(imuid).(dof).laplace,estimatedpdf.(imuid).(dof).cauchy] = maia_comparecdf(data,datastring,h);

            h = subplot(3,2,4)

            data = eval(genvarname(strcat('signal_pitch_',num2str(button))));
            datastring = '\omega_y [1 \cdot s^{-1}]';

            imuid = strcat('IMU',num2str(button));
            dof = 'signal_pitch';
            [estimatedpdf.(imuid).(dof).norm,estimatedpdf.(imuid).(dof).t,estimatedpdf.(imuid).(dof).laplace,estimatedpdf.(imuid).(dof).cauchy] = maia_comparecdf(data,datastring,h);

            h = subplot(3,2,6)

            data = eval(genvarname(strcat('signal_yaw_',num2str(button))));
            datastring = '\omega_z [1 \cdot s^{-1}]';

            imuid = strcat('IMU',num2str(button));
            dof = 'signal_yaw';
            [estimatedpdf.(imuid).(dof).norm,estimatedpdf.(imuid).(dof).t,estimatedpdf.(imuid).(dof).laplace,estimatedpdf.(imuid).(dof).cauchy] = maia_comparecdf(data,datastring,h);
            
            button = button + 1;
        end
    end
end