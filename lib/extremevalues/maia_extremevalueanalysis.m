%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This script runs an extreme value analysis of the acceleration data     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-05-06  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%

button = 0;
userrequest = 1;
clear eva
% Buttons for user input
while userrequest == 1

%     if (exist('imu_1_data_si','var') && exist('imu_2_data_si','var'))    
%         inputOptions = {'1','2','3','4','Done'};
%         defSelection = inputOptions{end};
%         button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
%     elseif exist('imu_2_data_si','var')
%         inputOptions = {'2','3','4','Done'};
%         defSelection = inputOptions{end};
%         button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
%         button = button + 1;
%     elseif exist('imu_1_data_si','var')
%         inputOptions = {'1','3','4','Done'};
%         defSelection = inputOptions{end};
%         button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
%         if button == 1
%             button = 1;
%         else
%             button = button + 1;
%         end
%     else
%         inputOptions = {'3','4','Done'};
%         defSelection = inputOptions{end};
%         button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');
%         button = button + 2;
%     end
  
        inputOptions = {'1','2','3','4','5','Done'};
        defSelection = inputOptions{end};
        button = bttnChoiseDialog(inputOptions,'Pick IMU',defSelection,'Which IMU will you pick?');

    if (button == 6)
    userrequest = 0;
    
    else
        
        inputOptions2 = {'Blockmax','Envelope'};
        defSelection2 = inputOptions2{end};
        button2 = bttnChoiseDialog(inputOptions2,'Pick a method?',defSelection2,'Which method should be used to find extremes?');
        eva.frequency = imu_data.frequency;
        
        if button2 == 1
    % User input dialogue for blocksize
        blocksize = str2double(cell2mat(inputdlg('What blocksize in samples do you choose?','Blocksize',1,{'1000'})));
        %pdrequest = questdlg('Which extreme value distribution shall be used?','EV select','Gumbel','Fréchet','Generalized Extreme Value','Generalized Extreme Value');

        variname = strcat('IMU',num2str(button));

    % Create a figure <== We do not do that anymore
        %g = figure('Position',[35 162 890 788]);
        %text(.75,1.25,strcat('Maxvalues of data from IMU ==>',num2str(button)));


            %h = subplot(3,2,1)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_surge'));
            datastring = 'a_x [m \cdot s^{-2}]';

            % Create the blocks with maia_blockandmax
            eva.(variname).blockmax(:,1) = maia_blockandmax(data,blocksize,datastring);
            %[mleev(:,1),mleevCI(:,1)] = gevfit(blockmax(:,1));


            %h = subplot(3,2,3)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_sway'));
            datastring = 'a_y [m \cdot s^{-2}]';

            eva.(variname).blockmax(:,2) = maia_blockandmax(data,blocksize,datastring);
            %[mleev(:,2),mleevCI(:,2)] = gevfit(blockmax(:,2));

            %h = subplot(3,2,5)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_heave'));
            datastring = 'a_z [m \cdot s^{-2}]';

            eva.(variname).blockmax(:,3) = maia_blockandmax(data,blocksize,datastring);
            %[mleev(:,3),mleevCI(:,3)] = gevfit(blockmax(:,3));


            %h = subplot(3,2,2)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_roll'));
            datastring = '\omega_x [m \cdot s^{-1}]';

            eva.(variname).blockmax(:,4) = maia_blockandmax(data,blocksize,datastring);
            %[mleev(:,4),mleevCI(:,4)] = gevfit(blockmax(:,4));


            %h = subplot(3,2,4)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_pitch'));
            datastring = '\omega_y [m \cdot s^{-1}]';

            eva.(variname).blockmax(:,5) = maia_blockandmax(data,blocksize,datastring);
           % [mleev(:,5),mleevCI(:,5)] = gevfit(blockmax(:,5));

            %h = subplot(3,2,6)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_yaw'));
            datastring = '\omega_z [m \cdot s^{-1}]';

            eva.(variname).blockmax(:,6) = maia_blockandmax(data,blocksize,datastring);
            %[mleev(:,6),mleevCI(:,6)] = gevfit(blockmax(:,6));

            for m = 1:1:6
            [mleevtemp,mleevCItemp] = gevfit(eva.(variname).blockmax(:,m));
            [~,mleevACOVtemp] = gevlike(mleevtemp,eva.(variname).blockmax(:,m));
            eva.(variname).mleev(:,m) = mleevtemp';
            %eva.(variname).mlevCI(:,m) = mleevCItemp';
            eva.(variname).mleevCIdown(:,m) = mleevCItemp(1,:)'; % Bottom of 95% conf. interv.
            eva.(variname).mleevCIup(:,m) = mleevCItemp(2,:)'; % Top of 95% conf. interv.
            eva.(variname).mleevSEs(:,m) = sqrt(diag(mleevACOVtemp))'; % see https://se.mathworks.com/help/stats/examples/modelling-data-with-the-generalized-extreme-value-distribution.html
            eva.(variname).mleevWald(:,m) = eva.(variname).mleev(:,m).^2./(eva.(variname).mleevSEs(:,m).^2);
            clear mleevtemp mleevCItemp
            end

            eva.(variname).blocksize = blocksize;

            
        elseif button2 == 2
            % User input dialogue for blocksize
        windowsize = str2double(cell2mat(inputdlg('Which window size should be used for the hilbert transform?','Windowsize',1,{'10'})));
        %pdrequest = questdlg('Which extreme value distribution shall be used?','EV select','Gumbel','Fréchet','Generalized Extreme Value','Generalized Extreme Value');

        variname = strcat('IMU',num2str(button));

    % Create a figure <== We do not do that anymore
        %g = figure('Position',[35 162 890 788]);
        %text(.75,1.25,strcat('Maxvalues of data from IMU ==>',num2str(button)));


            %h = subplot(3,2,1)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_surge'));
            datastring = 'a_x [m \cdot s^{-2}]';

            % Create the blocks with maia_blockandmax
            [eva.(variname).envelopeup(:,1),eva.(variname).envelopedown(:,1)] = maia_findenvelope(data,windowsize);
            eva.(variname).blockmax(:,1) = eva.(variname).envelopeup(:,1);
            %[mleev(:,1),mleevCI(:,1)] = gevfit(blockmax(:,1));


            %h = subplot(3,2,3)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_sway'));
            datastring = 'a_y [m \cdot s^{-2}]';

            [eva.(variname).envelopeup(:,2),eva.(variname).envelopedown(:,2)] = maia_findenvelope(data,windowsize);
            eva.(variname).blockmax(:,2) = eva.(variname).envelopeup(:,2);
            %[mleev(:,2),mleevCI(:,2)] = gevfit(blockmax(:,2));

            %h = subplot(3,2,5)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_heave'));
            datastring = 'a_z [m \cdot s^{-2}]';

            [eva.(variname).envelopeup(:,3),eva.(variname).envelopedown(:,3)] = maia_findenvelope(data,windowsize);
            eva.(variname).blockmax(:,3) = eva.(variname).envelopeup(:,3);
            %[mleev(:,3),mleevCI(:,3)] = gevfit(blockmax(:,3));


            %h = subplot(3,2,2)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_roll'));
            datastring = '\omega_x [m \cdot s^{-1}]';

            [eva.(variname).envelopeup(:,4),eva.(variname).envelopedown(:,4)] = maia_findenvelope(data,windowsize);
            eva.(variname).blockmax(:,4) = eva.(variname).envelopeup(:,4);
            %[mleev(:,4),mleevCI(:,4)] = gevfit(blockmax(:,4));


            %h = subplot(3,2,4)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_pitch'));
            datastring = '\omega_y [m \cdot s^{-1}]';

            [eva.(variname).envelopeup(:,5),eva.(variname).envelopedown(:,5)] = maia_findenvelope(data,windowsize);
            eva.(variname).blockmax(:,5) = eva.(variname).envelopeup(:,5);
           % [mleev(:,5),mleevCI(:,5)] = gevfit(blockmax(:,5));

            %h = subplot(3,2,6)

            data = eval(strcat('imu_data.IMU',num2str(button),'.signal_yaw'));
            datastring = '\omega_z [m \cdot s^{-1}]';

            [eva.(variname).envelopeup(:,6),eva.(variname).envelopedown(:,6)] = maia_findenvelope(data,windowsize);
            eva.(variname).blockmax(:,6) = eva.(variname).envelopeup(:,6);
            %[mleev(:,6),mleevCI(:,6)] = gevfit(blockmax(:,6));

            for m = 1:1:6
            [mleevtemp,mleevCItemp] = gevfit(eva.(variname).blockmax(:,m));
            [~,mleevACOVtemp] = gevlike(mleevtemp,eva.(variname).blockmax(:,m));
            eva.(variname).mleev(:,m) = mleevtemp';
            %eva.(variname).mlevCI(:,m) = mleevCItemp';
            eva.(variname).mleevCIdown(:,m) = mleevCItemp(1,:)'; % Bottom of 95% conf. interv.
            eva.(variname).mleevCIup(:,m) = mleevCItemp(2,:)'; % Top of 95% conf. interv.
            eva.(variname).mleevSEs(:,m) = sqrt(diag(mleevACOVtemp))'; % see https://se.mathworks.com/help/stats/examples/modelling-data-with-the-generalized-extreme-value-distribution.html
            eva.(variname).mleevWald(:,m) = eva.(variname).mleev(:,m).^2./(eva.(variname).mleevSEs(:,m).^2);
            clear mleevtemp mleevCItemp
            end

            eva.(variname).blocksize = windowsize;

        end
        
        
    end
        
    

    
end

% Clean up section
clear datastring data h g pdrequest blocksize userrequest button defSelection inputOptions  variname