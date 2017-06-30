%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script re-samples the given files with a set frequency and stores %
% it in the ReSampledData folder                                         % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;

%---------------------------------------------------------------------%
% PARAMETER TO SET 
if exist('PathName_IMU1','var') && exist('PathName_IMU2','var') && exist('PathName_IMU3','var') && exist('PathName_IMU4','var')
fprintf('Path Names already known, skipping GUI');

else
% Source file in RawData folder
[FileName_IMU1,PathName_IMU1,~] = uigetfile({'*.csv';'*.*'},'Select the IMU 1 .csv file');
[FileName_IMU2,PathName_IMU2,~] = uigetfile({'*.csv';'*.*'},'Select the IMU 2 .csv file');
[FileName_IMU3,PathName_IMU3,~] = uigetfile({'*.csv';'*.*'},'Select the IMU 3 .csv file');
[FileName_IMU4,PathName_IMU4,~] = uigetfile({'*.csv';'*.*'},'Select the IMU 4 .csv file');
[FileName_IMU5,PathName_IMU5,~] = uigetfile({'*.csv';'*.*'},'Select the IMU 5 .csv file');
end

% Desired frequency
userinput = inputdlg({'What is the desired frequency for resampling?'},'',1,...
        {'Frequency in Hz'});
freq_d = str2num(userinput{:}); %Hz
%---------------------------------------------------------------------%


fprintf('o-----------------------------------------------o\n')
fprintf('|\t IMU TOOLS v01: THE RE-SAMPLING SCRIPT  \t|\n')
fprintf('o-----------------------------------------------o\n\n');

% If data not already in workspace, empty it and read fiels
% if ~exist('imu_1_csv','var') && ~exist('imu_2_csv','var') && ~exist('imu_3_csv','var') && ~exist('imu_4_csv','var')
    fprintf('\t -> Loading data from CSV files\n');
    
    % Load CSV files
    if FileName_IMU1 ~= 0
    imu_1_csv = dlmread(strcat(PathName_IMU1,'/',FileName_IMU1), ';', 2, 0);
    end
    
    if FileName_IMU2 ~= 0
    imu_2_csv = dlmread(strcat(PathName_IMU2,'/',FileName_IMU2), ';', 2, 0);
    end
    
    if FileName_IMU3 ~= 0
    imu_3_csv = dlmread(strcat(PathName_IMU3,'/',FileName_IMU3), ';', 2, 0);
    end
    
    if FileName_IMU4 ~=0
    imu_4_csv = dlmread(strcat(PathName_IMU4,'/',FileName_IMU4), ';', 2, 0);
    end
    
    if FileName_IMU5 ~= 0
    imu_5_csv = dlmread(strcat(PathName_IMU5,'/',FileName_IMU5), ';', 2, 0);
    end
        
% else
%     fprintf('\t -> CSV data already in workspace\n');
% end

% Create a downsampled dataset, with a given frequency
fprintf('\t -> Re-sampling datasets to %d Hz\n',freq_d);

if exist('imu_1_csv','var')
    if size(imu_1_csv,2) > 20
        imu_1_csv = imu_1_csv(:,[1:12 14:21]);
    end

    if size(imu_1_csv,2) == 18
        imu_1_csv = imu_1_csv(:,[1:9,9,9,10:18]);     
    end
end

if exist('imu_1_csv','var')
    [imu_1_data time_1_c data time_r] = datasetResampler(imu_1_csv,freq_d);
end

if exist('imu_2_csv','var')
    [imu_2_data time_2_c data time_r] = datasetResampler(imu_2_csv,freq_d);
end

if exist('imu_3_csv','var')
    [imu_3_data time_3_c data time_r] = datasetResampler(imu_3_csv,freq_d);
end

if exist('imu_4_csv','var')
    [imu_4_data time_4_c data time_r] = datasetResampler(imu_4_csv,freq_d);
end

if exist('imu_5_csv','var')
    [imu_5_data time_5_c data time_r] = datasetResampler(imu_5_csv,freq_d);
end

fprintf('\t -> Re-sampling to %d Hz done\n',freq_d);

fprintf('\t -> Extend dataset with progressive time as channel 1\n');

if exist('imu_1_csv','var') 
    imu_1_data(2:21,:) = imu_1_data;
    imu_1_data(1,:) = time_1_c;
    imu_1_data(22,:) = datenum(imu_1_data(14:19)) + datenum(0,0,0,0,0,imu_1_data(1,:));
end

if exist('imu_2_csv','var') 
    imu_2_data(2:21,:) = imu_2_data;
    imu_2_data(1,:) = time_2_c;
    imu_2_data(22,:) = datenum(imu_2_data(14:19)) + datenum(0,0,0,0,0,imu_2_data(1,:));
end

if exist('imu_3_csv','var') 
    imu_3_data(2:21,:) = imu_3_data;
    imu_3_data(1,:) = time_3_c;
    imu_3_data(22,:) = datenum(imu_3_data(14:19)) + datenum(0,0,0,0,0,imu_3_data(1,:));
end

if exist('imu_4_csv','var') 
    imu_4_data(2:21,:) = imu_4_data;
    imu_4_data(1,:) = time_4_c;
    imu_4_data(22,:) = datenum(imu_4_data(14:19)) + datenum(0,0,0,0,0,imu_4_data(1,:));
end

if exist('imu_5_csv','var') 
    imu_5_data(2:21,:) = imu_5_data;
    imu_5_data(1,:) = time_5_c;
    imu_5_data(22,:) = datenum(imu_5_data(14:19)) + datenum(0,0,0,0,0,imu_5_data(1,:));    
end

if exist('imu_1_csv','var') 
    save(strcat(PathName_IMU1,FileName_IMU1(1:end-4),'_resampled.mat'),'imu_1_data');
end

if exist('imu_2_csv','var') 
    save(strcat(PathName_IMU2,FileName_IMU2(1:end-4),'_resampled.mat'),'imu_2_data');
end

if exist('imu_3_csv','var') 
    save(strcat(PathName_IMU3,FileName_IMU3(1:end-4),'_resampled.mat'),'imu_3_data');
end

if exist('imu_4_csv','var') 
    save(strcat(PathName_IMU4,FileName_IMU4(1:end-4),'_resampled.mat'),'imu_4_data');
end

if exist('imu_5_csv','var') 
    save(strcat(PathName_IMU5,FileName_IMU5(1:end-4),'_resampled.mat'),'imu_5_data');
end


fprintf('\t -> Files stored in ReSampledData folder \n\n\t FINE!\n');
