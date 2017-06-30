%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This tool launches the extreme value analysis                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script runs all analysis necessary for the paper on acceleration 
% statistics. The script % originated from the run_tf_analysis script
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
%    Date created:  2016-07-12  Hans-Martin Heyn (NTNU)
%    

%---------------------------------------------------------------------%
Tool_CleanUp

usermainrequest = 1;

while usermainrequest == 1

    inputOptions = {'SELECT DATA','DIS_FIT','CDF_COMP','DOF_CDF','REC-PAR-ESTI','1DACCPLOT','2DACCPlot','ICEDETECT','ZEROCROSS','MOVIE','DONE'};
    defSelection = inputOptions{end};
    button = bttnChoiseDialog(inputOptions,'Make it extreme!',defSelection,'Operation select?'); 
    %button = questdlg('Make it extreme!','Operation selection','DIS_FIT','EXTREME','END','DIS_FIT');

  
    switch button

        case 1
            
            inputOptions = {'GUI selection','Text selection'};
            defSelection = inputOptions{end};
            buttona = bttnChoiseDialog(inputOptions,'How do you want to pick the data',defSelection,'HI :)'); 
            
            switch buttona
                
                case 1     
                    if exist('imu_data_aligned','var')
                        imu_data = GUIselectIMUdata(imu_data_aligned);
                    else
                        imu_data = GUIselectIMUdata(imu_data_raw);
                    end
                case 2
                    if exist('imu_data_aligned','var')
                        imu_data = cutIMUdata(imu_data_aligned);
                    else
                        imu_data = cutIMUdata(imu_data_raw);
                    end
            end
            
            if exist('shipdata','var')
                inputOptions = {'Cut!','Do not'};
                defSelection = inputOptions{end};
                buttona = bttnChoiseDialog(inputOptions,'Cutting of shipdata and enginedata',defSelection,'Do you want to cut shipdata?'); 

                if buttona==1
                    [enginedata_analyse,shipdata_analyse] = cutshipdataauto(imu_data,enginedata,shipdata);
                end    
            end
            
        case 2
            % This case still uses the script-style - variable-style 
            % processing, which
            % has been replaced by a function-style - struct-style
            % processing, which is cooler

            %prompt = {'Distribution for translational motion','Distribution for rotational motion'};
            %userinput = inputdlg(prompt,'Distributions',1,{'Normal','Normal'});

            estimatedpdfs = maia_multicomparecdf(imu_data);
            %clear userinput
        
        
        case 3
                
            %prompt = {'Distribution for translational motion','Distribution for rotational motion'};
            %userinput = inputdlg(prompt,'Distributions',1,{'Normal','Normal'});
            
            maia_comparesurgeswaycdf(imu_data);
            %clear userinput 
        case 4
            % Ask for IMU and DOF
            [data,selectedIMU,selectedDOF] = maia_selectIMUDOF(imu_data);
            h = figure;
            [result.pd_n,result.pd_t,result.pd_l,result.pd_c] = maia_comparecdf(data(:,2),strcat(selectedIMU,{' '},selectedDOF),h);
                        
        case 5
        
           % userinput = inputdlg({'Enter the sample blocksize please'},'Input',1,...
           %     {'600'});    
           % userinBlock = str2double(userinput{1}); 
           %for m = 1:1:4
               m = 2;
               imuid = strcat('IMU',num2str(m))
           
               for k = 1:1:4
                   estimatedresults.lp = 10;
                   estimatedresults.downsampled = 20;
                   
                   if k == 1
                       userinBlock = 2400;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).norm.cdfs.pd,estimateresults.(imuid).(blocklength).norm.cdfs.pci,estimateresults.(imuid).(blocklength).norm.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','norm',userinBlock);
                   elseif k == 2
                       userinBlock = 1200;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).norm.cdfs.pd,estimateresults.(imuid).(blocklength).norm.cdfs.pci,estimateresults.(imuid).(blocklength).norm.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','norm',userinBlock);

                   elseif k == 3
                       userinBlock = 600;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).norm.cdfs.pd,estimateresults.(imuid).(blocklength).norm.cdfs.pci,estimateresults.(imuid).(blocklength).norm.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','norm',userinBlock);
                   elseif k == 4
                       userinBlock = 200;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).norm.cdfs.pd,estimateresults.(imuid).(blocklength).norm.cdfs.pci,estimateresults.(imuid).(blocklength).norm.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','norm',userinBlock);
                   end
               end

               for k = 1:1:4

                   if k == 1
                       userinBlock = 2400;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).t.cdfs.pd,estimateresults.(imuid).(blocklength).t.cdfs.pci,estimateresults.(imuid).(blocklength).t.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','tlocationscale',userinBlock);
                   elseif k == 2
                       userinBlock = 1200;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).t.cdfs.pd,estimateresults.(imuid).(blocklength).t.cdfs.pci,estimateresults.(imuid).(blocklength).t.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','tlocationscale',userinBlock);
 
                   elseif k == 3
                       userinBlock = 600;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).t.cdfs.pd,estimateresults.(imuid).(blocklength).t.cdfs.pci,estimateresults.(imuid).(blocklength).t.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','tlocationscale',userinBlock);

                   elseif k == 4
                       userinBlock = 200;
                       blocklength = strcat('Blocklength',num2str(userinBlock))
                       [estimateresults.(imuid).(blocklength).t.cdfs.pd,estimateresults.(imuid).(blocklength).t.cdfs.pci,estimateresults.(imuid).(blocklength).t.cdfs.p] = maia_recursivecdfestimate(imu_data,'IMU4','tlocationscale',userinBlock);

                   end
                   %save('20160508imurecesti_FILT.mat','imu_data')
               end
           %end
        case 6
            Tool_PlotCompare
        
        case 7
        
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


        case 8

            userinput = inputdlg({'Enter the blocksize please','Enter the threshold(s) please'},'Input',1,...
                {'500','0.25'});    
            userinBLOCK = str2num(userinput{1}); 
            userinTHRES = str2num(userinput{2});
            datain = maia_selectIMUDOF(imu_data);    % GUI for asking which IMU and which DOF should be considered
            inputOptions = {'Power','Shape','Both'};
            defSelection = inputOptions{end};
            button = bttnChoiseDialog(inputOptions,'What do you want to analyse?',defSelection,'What do you want to analyse?');
                if button == 1
                    modeselect = 'Power';
                elseif button == 2
                    modeselect = 'Shape';
                else
                    modeselect = 'Both';
                end
     
            h4 = figure
            icefactor = maia_icedetect(datain,userinBLOCK,userinTHRES,modeselect,h4);
            clear userinput userin datain
            
        case 9
            % Zero crossing detection
            h5 = figure
            zerodata = maia_selectIMUDOF(imu_data); % Request user input
            [zerIdx,zerdown,zerup,deltaZeit,maxVec,minVec] = maia_zerocrossstat(zerodata,h5);
            
        case (button(end) - 1)
            % Make movies
            offsetsec = floor(imu_3_data_si(1,start_inx));
            Tool_MakeMovies
            
        case button(end)
            usermainrequest = 0;
    end
end


clear offsetsec button defSelection inputOption usermainrequest inputOptions movend movierequest movstart tfend tfstart userinDOF userinIMU userinput h m n prompt picked interval_start inverval_end index_end_2 index_end_3 index_end_4 index_start_2 index_start_3 index_start_4 index_start_1 index_end_1 endstring d ans YLabelsave buttona