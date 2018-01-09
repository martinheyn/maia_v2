%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script equalizes the re-sampled data and stores the files in   %
% the SyncronizedData folder so that all are equally long. It assumes %
% that all datasets start at the same time                            % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;

%---------------------------------------------------------------------%
% PARAMETER TO SET 
% Source file in RawData folder

if exist('imu_1_csv','var')
    path_to_source_file_1 = strcat(PathName_IMU1,FileName_IMU1(1:end-4),'_resampled.mat');
end

if exist('imu_2_csv','var')
    path_to_source_file_2 = strcat(PathName_IMU2,FileName_IMU2(1:end-4),'_resampled.mat');
end

if exist('imu_3_csv','var')
    path_to_source_file_3 = strcat(PathName_IMU3,FileName_IMU3(1:end-4),'_resampled.mat');
end

if exist('imu_4_csv','var')
    path_to_source_file_4 = strcat(PathName_IMU4,FileName_IMU4(1:end-4),'_resampled.mat');
end

if exist('imu_5_csv','var')
    path_to_source_file_5 = strcat(PathName_IMU5,FileName_IMU5(1:end-4),'_resampled.mat');
end
%---------------------------------------------------------------------%

fprintf('o-------------------------------------------o\n')
fprintf('|\t IMU TOOLS v01: THE EQUIALIZER SCRIPT  \t|\n')
fprintf('o-------------------------------------------o\n\n');

% Load data
%if ~exist('imu_1_data','var') && ~exist('imu_2_data','var') && ~exist('imu_3_data','var') && ~exist('imu_4_data','var')
%    fprintf('\t -> Loading data\n');
%    load(path_to_source_file_1);
%    load(path_to_source_file_2);
%    load(path_to_source_file_3);
%    load(path_to_source_file_4);
%else
%    fprintf('\t -> Data existed in workspace\n');
%end
if exist('imu_5_data','var')
    data_lengths = [length(imu_1_data) length(imu_2_data) length(imu_3_data) length(imu_4_data) length(imu_5_data)];
    [~,inx] = min(data_lengths);

else
    
    if exist('imu_1_data','var') && exist('imu_2_data','var')
        data_lengths = [length(imu_1_data) length(imu_2_data) length(imu_3_data) length(imu_4_data)];
        [~,inx] = min(data_lengths);
    end

    % find the shortest dataset
    if ~exist('imu_1_data','var') && exist('imu_2_data','var')
        data_lengths = [99999999 length(imu_2_data) length(imu_3_data) length(imu_4_data)];
        [~,inx] = min(data_lengths);
    end

    if ~exist('imu_2_data','var') && exist('imu_1_data','var')
        data_lengths = [length(imu_1_data) 99999999 length(imu_3_data) length(imu_4_data)];
        [~,inx] = min(data_lengths);
    end

    if ~exist('imu_1_data','var') && ~exist('imu_2_data','var')
        data_lengths = [99999999 99999999 length(imu_3_data) length(imu_4_data)];
        [~,inx] = min(data_lengths);
    end
end

%%%% FIX THAT PROBLEM HERE WHEN YOU ARE HOME: CONVERT STRING TO A VALID
%%%% VARIABLENAME!!!!!!!


%cut the others
%if exist('imu_1_data','var')
%    imu_1_data = imu_1_data(:,1:length(strcat('imu_',num2str(inx),'_data(1,:)')));
%end
% if exist('imu_2_data','var')
%     imu_2_data = imu_2_data(:,1:length(strcat('imu_',num2str(inx),'_data(1,:)')));
% end
% 
% if exist('imu_3_data','var')
%     imu_3_data = imu_3_data(:,1:length(strcat('imu_',num2str(inx),'_data(1,:)')));
% end
% 
% if exist('imu_4_data','var')
%     imu_4_data = imu_4_data(:,1:length(strcat('imu_',num2str(inx),'_data(1,:)')));
% end

if inx == 1
    if exist('imu_1_data','var')
        imu_1_data = imu_1_data(:,1:length(imu_1_data(1,:)));
    end
    if exist('imu_2_data','var')
        imu_2_data = imu_2_data(:,1:length(imu_1_data(1,:)));
    end

    if exist('imu_3_data','var')
        imu_3_data = imu_3_data(:,1:length(imu_1_data(1,:)));
    end

    if exist('imu_4_data','var')
        imu_4_data = imu_4_data(:,1:length(imu_1_data(1,:)));
    end
    
    if exist('imu_5_data','var')
        imu_5_data = imu_5_data(:,1:length(imu_1_data(1,:)));
    end
    
elseif inx == 2
    if exist('imu_1_data','var')
        imu_1_data = imu_1_data(:,1:length(imu_2_data(1,:)));
    end
    if exist('imu_2_data','var')
        imu_2_data = imu_2_data(:,1:length(imu_2_data(1,:)));
    end

    if exist('imu_3_data','var')
        imu_3_data = imu_3_data(:,1:length(imu_2_data(1,:)));
    end

    if exist('imu_4_data','var')
        imu_4_data = imu_4_data(:,1:length(imu_2_data(1,:)));
    end
    
    if exist('imu_5_data','var')
        imu_5_data = imu_5_data(:,1:length(imu_2_data(1,:)));
    end

elseif inx == 3
    if exist('imu_1_data','var')
        imu_1_data = imu_1_data(:,1:length(imu_3_data(1,:)));
    end
    
    if exist('imu_2_data','var')
        imu_2_data = imu_2_data(:,1:length(imu_3_data(1,:)));
    end

    if exist('imu_3_data','var')
        imu_3_data = imu_3_data(:,1:length(imu_3_data(1,:)));
    end

    if exist('imu_4_data','var')
        imu_4_data = imu_4_data(:,1:length(imu_3_data(1,:)));
    end
    
    if exist('imu_5_data','var')
        imu_5_data = imu_5_data(:,1:length(imu_3_data(1,:)));
    end
    
elseif inx == 4
    
    if exist('imu_1_data','var')
        imu_1_data = imu_1_data(:,1:length(imu_4_data(1,:)));
    end
    
    if exist('imu_2_data','var')
        imu_2_data = imu_2_data(:,1:length(imu_4_data(1,:)));
    end

    if exist('imu_3_data','var')
        imu_3_data = imu_3_data(:,1:length(imu_4_data(1,:)));
    end

    if exist('imu_4_data','var')
        imu_4_data = imu_4_data(:,1:length(imu_4_data(1,:)));
    end
    
    if exist('imu_5_data','var')
        imu_5_data = imu_5_data(:,1:length(imu_4_data(1,:)));
    end
    
elseif inx == 5
    
    if exist('imu_1_data','var')
        imu_1_data = imu_1_data(:,1:length(imu_5_data(1,:)));
    end
    
    if exist('imu_2_data','var')
        imu_2_data = imu_2_data(:,1:length(imu_5_data(1,:)));
    end

    if exist('imu_3_data','var')
        imu_3_data = imu_3_data(:,1:length(imu_5_data(1,:)));
    end

    if exist('imu_4_data','var')
        imu_4_data = imu_4_data(:,1:length(imu_5_data(1,:)));
    end
    
    if exist('imu_5_data','var')
        imu_5_data = imu_5_data(:,1:length(imu_5_data(1,:)));
    end
    
end
% Save data
% if exist('imu_1_data','var')
    % save(strcat(PathName_IMU1,FileName_IMU1(1:end-4),'_equalized.mat'),'imu_1_data');
% end    
% if exist('imu_2_data','var')
    % save(strcat(PathName_IMU2,FileName_IMU2(1:end-4),'_equalized.mat'),'imu_2_data');
% end
% if exist('imu_3_data','var')
    % save(strcat(PathName_IMU3,FileName_IMU3(1:end-4),'_equalized.mat'),'imu_3_data');
% end
% if exist('imu_4_data','var')
    % save(strcat(PathName_IMU4,FileName_IMU4(1:end-4),'_equalized.mat'),'imu_4_data');
% end
fprintf('\t -> Files stored in EqualizedData folder \n\n\t FINE!\n');
