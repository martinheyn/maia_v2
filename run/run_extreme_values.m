%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This tool launches the extreme value analysis                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs the extreme values analysis for the IMU data. The script
% originated from the run_tf_analysis script
% 
%
% Workspace data:
%   signal: The acceleration and velocity data from all IMUs
%   
% Output data:
%   
%  
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-05-19  Hans-Martin Heyn (NTNU)
%    

%---------------------------------------------------------------------%
% addpath .\Tools .\Import .\Tools\statistics
% Tool_CleanUp
% 
% inputOptions = {'JA','NEI'};
% defSelection = inputOptions{end};
% button = bttnChoiseDialog(inputOptions,'Make it extreme!',defSelection,'Do you want to analyse new data?');
% 
% if button == 1
%     % 1. Check if required data is in workspace and which sensors are present
%     n = 0;
%     if exist('imu_1_data_si')
%         n = n+1;
%     end
% 
%     if exist('imu_2_data_si')
%         n = n+3;
%     end
% 
%     if exist('imu_3_data_si')
%         n = n+5;
%     end
% 
%     if exist('imu_4_data_si')
%         n = n+7;
%     end
% 
%     if n == 0
%         fprintf('no data found \n');
%         return
%     end
% 
%     % 2. Plot all data with plot compare
%     Tool_PlotCompare
% 
%     % 3. Let the person in front of the screen pick a data set
%     ginput(1); % We just have to click in or close to the plot to pick it
%     picked = gca;
%     if picked.Position(1) > 0.5 
%         m = 3;
%     else
%         m = 0;
%     end
% 
%     if picked.Position(2) < 0.33
%         m = m + 3;
%     elseif picked.Position(2) < 0.66
%         m = m + 2;
%     elseif picked.Position(1) < 1
%         m = m + 1;
%     end
%     m = m + 4; % That is now the correct position in the IMU data matrix
% 
%     YLabelsave = get(picked.YLabel);
%     userrequest = 1;
% 
%     while userrequest == 1
%         % 4. Plot the selected data set
%         Tool_PlotSingleData;
% 
%         % 5. Let the user decide which part he wants to analyse
%         selected = ginput(2); % Click once for the start 
% 
%         % 6. Check that it's not longer than 60 seconds
%     %     if (selected(2,1) - selected(1,1)) > 600
%     %         fprintf('You cannot select a time longer than 600 seconds')
%     %     else
%             tfstart = round(selected(1,1));
%             tfend = round(selected(2,1));
%             userrequest = 0;
%     %     end
%     end
%     clear selected userrequest
% 
%  % Copy data to a struct
%  
%          if (exist('imu_1_data_si','var'))
%             start_inx = find(imu_1_data_si(1,:) > tfstart,1);
%             end_inx = find(imu_1_data_si(1,:) > tfend,1);
%             imu_data.IMU1.signal_surge = imu_1_data_si(5,(start_inx:end_inx))';
%             imu_data.IMU1.signal_sway = imu_1_data_si(6,(start_inx:end_inx))';
%             imu_data.IMU1.signal_heave = imu_1_data_si(7,(start_inx:end_inx))';
%             imu_data.IMU1.signal_roll = imu_1_data_si(8,(start_inx:end_inx))';
%             imu_data.IMU1.signal_pitch = imu_1_data_si(9,(start_inx:end_inx))';
%             imu_data.IMU1.signal_yaw = imu_1_data_si(10,(start_inx:end_inx))';
%             imu_data.IMU1.matdatenum = datenum(imu_1_data_si([14:19],(start_inx:end_inx))');
%             imu_data.IMU1.t_cc = linspace(tfstart,tfend,length(imu_data.IMU1.signal_heave));
%         end
% 
%         if (exist('imu_2_data_si','var'))
%             start_inx = find(imu_2_data_si(1,:) > tfstart,1);
%             end_inx = find(imu_2_data_si(1,:) > tfend,1);
%             imu_data.IMU2.signal_surge = imu_2_data_si(5,(start_inx:end_inx))';
%             imu_data.IMU2.signal_sway = imu_2_data_si(6,(start_inx:end_inx))';
%             imu_data.IMU2.signal_heave = imu_2_data_si(7,(start_inx:end_inx))';
%             imu_data.IMU2.signal_roll = imu_2_data_si(8,(start_inx:end_inx))';
%             imu_data.IMU2.signal_pitch = imu_2_data_si(9,(start_inx:end_inx))';
%             imu_data.IMU2.signal_yaw = imu_2_data_si(10,(start_inx:end_inx))';
%             imu_data.IMU2.matdatenum = datenum(imu_2_data_si([14:19],(start_inx:end_inx))');
%             imu_data.IMU2.t_cc = linspace(tfstart,tfend,length(imu_data.IMU2.signal_heave));
%          end
% 
%         if (exist('imu_3_data_si','var'))       
%             start_inx = find(imu_3_data_si(1,:) > tfstart,1);
%             end_inx = find(imu_3_data_si(1,:) > tfend,1);
%             imu_data.IMU3.signal_surge = imu_3_data_si(5,(start_inx:end_inx))';
%             imu_data.IMU3.signal_sway = imu_3_data_si(6,(start_inx:end_inx))';
%             imu_data.IMU3.signal_heave = imu_3_data_si(7,(start_inx:end_inx))';
%             imu_data.IMU3.signal_roll = imu_3_data_si(8,(start_inx:end_inx))';
%             imu_data.IMU3.signal_pitch = imu_3_data_si(9,(start_inx:end_inx))';
%             imu_data.IMU3.signal_yaw = imu_3_data_si(10,(start_inx:end_inx))';
%             imu_data.IMU3.matdatenum = datenum(imu_3_data_si([14:19],(start_inx:end_inx))');
%             imu_data.IMU3.t_cc = linspace(tfstart,tfend,length(imu_data.IMU3.signal_heave));
%          end
% 
%         if (exist('imu_4_data_si','var'))       
%             start_inx = find(imu_4_data_si(1,:) > tfstart,1);
%             end_inx = find(imu_4_data_si(1,:) > tfend,1);
%             imu_data.IMU4.signal_surge = imu_4_data_si(5,(start_inx:end_inx))';
%             imu_data.IMU4.signal_sway = imu_4_data_si(6,(start_inx:end_inx))';
%             imu_data.IMU4.signal_heave = imu_4_data_si(7,(start_inx:end_inx))';
%             imu_data.IMU4.signal_roll = imu_4_data_si(8,(start_inx:end_inx))';
%             imu_data.IMU4.signal_pitch = imu_4_data_si(9,(start_inx:end_inx))';
%             imu_data.IMU4.signal_yaw = imu_4_data_si(10,(start_inx:end_inx))';
%             imu_data.IMU4.matdatenum = datenum(imu_4_data_si([14:19],(start_inx:end_inx))');
%             %freq = 1/(imu_4_data_si(1,(start_inx+1)) - imu_4_data_si(1,(start_inx)));
%             imu_data.IMU4.t_cc = linspace(tfstart,tfend,length(imu_data.IMU4.signal_heave));
%         end
%         
%         imu_data.userinput.start_inx = start_inx;
%         imu_data.userinput.end_inx = end_inx;
%         imu_data.userinput.tfstart = tfstart;
%         imu_data.userinput.tfend = tfend;
% end
%  
% % 7. Execute time-frequency analysis and plot them
usermainrequest = 1;

while usermainrequest == 1

    inputOptions = {'DIS_FIT','EXTREME','PROBPLOT','2DACCPlot','ICEDETECT','Done :)'};
    defSelection = inputOptions{end};
    button = bttnChoiseDialog(inputOptions,'Make it extreme!',defSelection,'Operation select?'); 
    %button = questdlg('Make it extreme!','Operation selection','DIS_FIT','EXTREME','END','DIS_FIT');

  
    switch button

            case 1
                % This case still uses the script-style - variable-style 
                % processing, which
                % has been replaced by a function-style - struct-style
                % processing, which is cooler

            prompt = {'Distribution for translational motion','Distribution for rotational motion'};
            %userinput = inputdlg(prompt,'Distributions',1,{'Normal','Normal'});
            
        imu_data.pdfs = maia_multicomparepdf(imu_data);
        %clear userinput
        
        
        case 2
                
            prompt = {'Distribution for translational motion','Distribution for rotational motion'};
            %userinput = inputdlg(prompt,'Distributions',1,{'Normal','Normal'});

            maia_extremevalueanalysis
            %clear userinput 
        
        case 3
        
            % GUI for asking which IMU and which DOF should be plotted

            inputOptions = {};
            if isfield(eva,'IMU1')
                inputOptions(end+1) = {'1'};
            end
            if isfield(eva,'IMU2')
                inputOptions(end+1) = {'2'};
            end
            if isfield(eva,'IMU3')
                inputOptions(end+1) = {'3'};
            end
            if isfield(eva,'IMU4')
                inputOptions(end+1) = {'4'};
            end
                inputOptions(end+1) = {'Done'};

            defSelection = inputOptions{end};
            button2 = bttnChoiseDialog(inputOptions,'Select IMU',defSelection,'Select an IMU :)'); 

            selectedIMU = str2num(cell2mat(inputOptions(button2))); % button only returns the number of the button, not its value. Have to look that up.

            inputOptions = {'Surge','Sway','Heave','Roll','Pitch','Yaw','Done'};
            button3 = bttnChoiseDialog(inputOptions,'Degree of Freedom',defSelection,'Select a DOF :D'); 

            inputOptions = {'All','Frechet only','Frechet of surge and sway','Frechet of surge and sway with more accl'};
            button4 = bttnChoiseDialog(inputOptions,'Want them all?',defSelection,'Choose what you want.'); 
            
            if button4 == 1
                maia_plotprobplots(eva,selectedIMU,button3);
            elseif button4 == 2
                maia_plotfrechplot(eva,selectedIMU,button3);
            elseif button4 == 3
                maia_plotfrechplotssurgesway(eva,selectedIMU);
            elseif button4 == 4
                maia_plotfrechplotssurgesway_meraccl(eva,selectedIMU);
            end


        case 4
            if (isfield(imu_data,'IMU3') && isfield(imu_data,'IMU4'))
            figure
            plot(imu_data.IMU3.signal_sway,imu_data.IMU3.signal_surge,'bo')
            hold
            plot(imu_data.IMU4.signal_sway,imu_data.IMU4.signal_surge,'ro')
            hold
            legend('IMU3','IMU4')
            end
            
            
            if isfield(imu_data,'IMU1')
            figure
            plot(imu_data.IMU1.signal_sway,imu_data.IMU1.signal_surge,'bo')
            legend('IMU1')
            end
            
            if isfield(imu_data,'IMU2')
            figure
            plot(imu_data.IMU2.signal_sway,imu_data.IMU2.signal_surge,'ro')
            hold
            legend('IMU2')
            end
            
        case 5
            
            userinput = inputdlg({'Enter the blocksize please','Enter the threshold please'},'Input',1,...
                {'500','0.25'});    
            userinIMU = str2num(userinput{1}); 
            userinDOF = str2num(userinput{2});
            h = figure
            
            datain = maia_selectIMUDOF(imu_data);    % GUI for asking which IMU and which DOF should be considered

            icefactor = maia_icedetect(datain,userinIMU,userinDOF,'Both',h);
            clear userinput userin datain
            
                 
        case button(end)
            usermainrequest = 0;        

    end
end


% 8. Make movies if required
% offsetsec = floor(imu_3_data_si(1,start_inx));
% Tool_MakeMovies
% clear offsetsec button button4 defSelection inputOption usermainrequest blocksize button2 button3 datastring defSelection inputOptions selectedIMU userrequest variname