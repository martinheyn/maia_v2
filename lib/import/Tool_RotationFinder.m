%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script calculates and stores the IMUs Euler angles in the body  %
% frame and stores it in the CalibrationParam folder                   % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------------------------------------------------------%

% Source files

%---------------------------------------------------------------------%

fprintf('o---------------------------------------------------o\n')
fprintf('|\t IMU TOOLS v1.1: THE ROTATION CALC. SCRIPT  \t|\n')
fprintf('o---------------------------------------------------o\n\n');

fprintf('\t -> Finding R-matrix and Eulers relative to bow IMU\n');

inputOptions = {'Find rotation angles','Use given rotation angles'};
defSelection = inputOptions{end};
buttona = bttnChoiseDialog(inputOptions,'Rotation angle finder',defSelection,'Will you try to find the rotation angles?'); 
    
if buttona == 1
    estimate = 1;
else
    estimate = 0;
    try
        [path_output,file_output] = uigetfile(pwd,'Select the rotation angle file...');
        load(fullfile(file_output,path_output));
        
        try
            roll_1 = rotations.IMU1.alignment(1);
            pitch_1 = rotations.IMU1.alignment(2);
            yaw_1 = rotations.IMU1.alignment(3);
        catch
            fprintf('IMU1 data not found')
        end
        
        try
            roll_2 = rotations.IMU2.alignment(1);
            pitch_2 = rotations.IMU2.alignment(2);
            yaw_2 = rotations.IMU2.alignment(3);
        catch
            fprintf('IMU2 data not found')
        end
        
        roll_3 = rotations.IMU3.alignment(1);
        pitch_3 = rotations.IMU3.alignment(2);
        yaw_3 = rotations.IMU3.alignment(3);
        
        roll_4 = rotations.IMU4.alignment(1);
        pitch_4 = rotations.IMU4.alignment(2);
        yaw_4 = rotations.IMU4.alignment(3);

        try
            roll_5 = rotations.IMU5.alignment(1);
            pitch_5 = rotations.IMU5.alignment(2);
            yaw_5 = rotations.IMU5.alignment(3);
        catch
            fprintf('IMU5 data not found')
        end

    catch
        fprintf('Could not load the rotation angle file, activating estimate instead')
        estimate = 1;
    end
    
end

inputOptions = {'Removes bias','Do not remove bias'};
defSelection = inputOptions{end};
buttonb = bttnChoiseDialog(inputOptions,'Bias removal',defSelection,'Do you want to remove the bias?'); 

if buttonb == 1
    removebias = 1;
else
    removebias = 0;
end

inputOptions = {'Convert to SI units','Do not convert to SI units'};
defSelection = inputOptions{end};
buttonc = bttnChoiseDialog(inputOptions,'Convert to SI',defSelection,'Do you want to convert to SI units?'); 

if buttonc == 1
    convert = 1;
else
    convert = 0;
end

inputOptions = {'Filter','Do not filter'};
defSelection = inputOptions{end};
buttond = bttnChoiseDialog(inputOptions,'Filter the data',defSelection,'Do you want to filter the data?'); 

if buttond == 1
    df = filterdesigner();
    filterreq = 1;
else
    filterreq = 0;
end
% WARNING: THIS SCRIPT USES X-Y-Z rotation convention from body to NED
% CORRECT WOULD BE: Z-Y-X rotation convention from NED to body
%Large_configuration = 1;

% % Load data
% if ~exist('imu_1_data','var') && ~exist('imu_2_data','var') && ~exist('imu_3_data','var') && ~exist('imu_4_data','var')
%     fprintf('\t -> Loading data\n');
%     load(path_to_source_file_1);
%     load(path_to_source_file_2);
%     load(path_to_source_file_3);
%     load(path_to_source_file_4);
%     IMU_2_aligned = 0;
% else
%     fprintf('\t -> Data existed in workspace\n');
% end

%%

% Fixing acc data directions
acc_1_data(1:3,:) = [-imu_data.IMU1.signal_surge,-imu_data.IMU1.signal_sway,-imu_data.IMU1.signal_heave]';
acc_2_data(1:3,:) = [-imu_data.IMU2.signal_surge,-imu_data.IMU2.signal_sway,-imu_data.IMU2.signal_heave]';
acc_3_data(1:3,:) = [-imu_data.IMU3.signal_surge,-imu_data.IMU3.signal_sway,-imu_data.IMU3.signal_heave]';
acc_4_data(1:3,:) = [-imu_data.IMU4.signal_surge,-imu_data.IMU4.signal_sway,-imu_data.IMU4.signal_heave]';

rot_1_data(1:3,:) = [imu_data.IMU1.signal_roll,imu_data.IMU1.signal_pitch,imu_data.IMU1.signal_yaw]';
rot_2_data(1:3,:) = [imu_data.IMU2.signal_roll,imu_data.IMU2.signal_pitch,imu_data.IMU2.signal_yaw]';
rot_3_data(1:3,:) = [imu_data.IMU3.signal_roll,imu_data.IMU3.signal_pitch,imu_data.IMU3.signal_yaw]';
rot_4_data(1:3,:) = [imu_data.IMU4.signal_roll,imu_data.IMU4.signal_pitch,imu_data.IMU4.signal_yaw]';

if missionselect == 5
    acc_5_data(1:3,:) = [-imu_data.IMU5.signal_surge,-imu_data.IMU5.signal_sway,-imu_data.IMU5.signal_heave]';
    rot_5_data(1:3,:) = [imu_data.IMU5.signal_roll,imu_data.IMU5.signal_pitch,imu_data.IMU5.signal_yaw]';
end

matdatenum = imu_data.IMU1.matdatenum;
frequency = imu_data.frequency;

if estimate == 1
    
    if missionselect == 4

    roll_1 = 0.5*pi/180;
    pitch_1 = 180.5*pi/180;
    yaw_1 = 106*pi/180;

    roll_2 = -3*pi/180;
    pitch_2 = 180*pi/180;
    yaw_2 = 90*pi/180;

    roll_3 = 179.5*pi/180;
    pitch_3 = 316.5*pi/180;
    yaw_3 = 270*pi/180;

    roll_4 = 182*pi/180;
    pitch_4 = 315*pi/180;
    yaw_4 = 90*pi/180;
    
    end

    if missionselect == 5

    roll_1 = 0.5*pi/180;
    pitch_1 = 180.5*pi/180;
    yaw_1 = 106*pi/180;

    roll_2 = -3*pi/180;
    pitch_2 = 180*pi/180;
    yaw_2 = 90*pi/180;

    roll_3 = 179.5*pi/180;
    pitch_3 = 316.5*pi/180;
    yaw_3 = 270*pi/180;

    roll_4 = 182*pi/180;
    pitch_4 = 315*pi/180;
    yaw_4 = 90*pi/180;

    roll_5 = 0*pi/180;
    pitch_5 = 0*pi/180;
    yaw_5 = 0*pi/180;
    
    end

% end

% Fine alignment
% Find roll and pitch angles based on maximizng the gravity channel
sp_rp   = 1*pi/180;    % search space
res     = 0.025*pi/180;   % angular resolution

sp_rp_yaw = 10*pi/180; % search space yaw
res_yaw = 0.5*pi/180; % angular resolution yaw

    fprintf('\n\t -> IMU2, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_2,(180/pi)*pitch_2,(180/pi)*yaw_2);
    %[roll_2, pitch_2] = rollPitchFinder(acc_2_data,roll_2,pitch_2,yaw_2,3*(pi/180),0.05*(pi/180));
    [roll_2, pitch_2] = rollPitchFinder(acc_2_data,roll_2,pitch_2,yaw_2,sp_rp,res);
    %yaw_2 = yawFinder(acc_2_data, roll_2, pitch_2, yaw_2, acc_2_data, rot_2_data, roll_1, pitch_1, yaw_1, 5*pi/180, 0.05*pi/180);
    fprintf('\t -> IMU2, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_2,(180/pi)*pitch_2,(180/pi)*yaw_2);

    fprintf('\n\t -> IMU1, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_1,(180/pi)*pitch_1,(180/pi)*yaw_1);
    %[roll_1, pitch_1] = rollPitchFinder(acc_1_data,roll_1,pitch_1,yaw_1,1*(pi/180),0.05*(pi/180));
    [roll_1, pitch_1] = rollPitchFinder(acc_1_data,roll_1,pitch_1,yaw_1,sp_rp,res);
    %yaw_1 = yawFinder(acc_1_data, rot_1_data, roll_2, pitch_2, yaw_2, acc_2_data, rot_2_data, roll_1, pitch_1, yaw_1, 10*pi/180, res);
    %yaw_1 = yawFinder(acc_1_data, rot_1_data, roll_1, pitch_1, yaw_1, acc_2_data, rot_2_data, roll_2, pitch_2, yaw_2, sp_rp_yaw, res_yaw);
    fprintf('\t -> IMU1, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_1,(180/pi)*pitch_1,(180/pi)*yaw_1);

    fprintf('\n\t -> IMU3, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_3,(180/pi)*pitch_3,(180/pi)*yaw_3);
    %[roll_3, pitch_3] = rollPitchFinder(acc_3_data,roll_3,pitch_3,yaw_3,3*(pi/180),0.05*(pi/180));
    [roll_3, pitch_3] = rollPitchFinder(acc_3_data,roll_3,pitch_3,yaw_3,sp_rp,res);
    %yaw_3 = yawFinder(acc_3_data, rot_3_data, roll_3, pitch_3, yaw_3, acc_2_data, rot_2_data, roll_1, pitch_1, yaw_1, 10*pi/180, res);
    %yaw_3 = yawFinder(acc_3_data, rot_3_data, roll_3, pitch_3, yaw_3, acc_2_data, rot_2_data, roll_2, pitch_2, yaw_2, sp_rp_yaw, res_yaw);
    fprintf('\t -> IMU3, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_3,(180/pi)*pitch_3,(180/pi)*yaw_3);

    if (exist('acc_5_data','var'))
    fprintf('\n\t -> IMU5, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_5,(180/pi)*pitch_5,(180/pi)*yaw_5);
        %[roll_4, pitch_4] = rollPitchFinder(acc_4_data,roll_4,pitch_4,yaw_4,2*(pi/180),0.05*(pi/180));
        [roll_5, pitch_5] = rollPitchFinder(acc_5_data,roll_5,pitch_5,yaw_5,sp_rp,res);
        %yaw_4 = yawFinder(acc_4_data, rot_4_data, roll_4, pitch_4, yaw_4, acc_2_data, rot_2_data, roll_1, pitch_1, yaw_1, 10*pi/180, res);
        % yaw_4 = yawFinder(acc_4_data, rot_4_data, roll_4, pitch_4, yaw_4, acc_2_data, rot_2_data, roll_2, pitch_2, yaw_2, sp_rp_yaw, res_yaw);
        fprintf('\t -> IMU5, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_5,(180/pi)*pitch_5,(180/pi)*yaw_5);
    end
end
% alignment
R_1 = Rzyx(roll_1,pitch_1,yaw_1);
R_2 = Rzyx(roll_2,pitch_2,yaw_2);
R_3 = Rzyx(roll_3,pitch_3,yaw_3);
R_4 = Rzyx(roll_4,pitch_4,yaw_4);

alignment_1 = [roll_1,pitch_1,yaw_1];
alignment_2 = [roll_2,pitch_2,yaw_2];
alignment_3 = [roll_3,pitch_3,yaw_3];
alignment_4 = [roll_4,pitch_4,yaw_4];

if (exist('acc_5_data','var'))
    R_5 = Rzyx(roll_5,pitch_5,yaw_5);
    alignment_5 = [roll_5,pitch_5,yaw_5];
end
% Rotate data
for i = 1:length(acc_1_data(1,:))
    acc_1_data(1:3,i) = R_1*acc_1_data(1:3,i);
    rot_1_data(1:3,i) = R_1*rot_1_data(1:3,i);
end

for i = 1:length(acc_2_data(1,:))
    acc_2_data(1:3,i) = R_2*acc_2_data(1:3,i);
    rot_2_data(1:3,i) = R_2*rot_2_data(1:3,i);
end
for i = 1:length(acc_3_data(1,:))
    acc_3_data(1:3,i) = R_3*acc_3_data(1:3,i);
    rot_3_data(1:3,i) = R_3*rot_3_data(1:3,i);
end
for i = 1:length(acc_4_data(1,:))
    acc_4_data(1:3,i) = R_4*acc_4_data(1:3,i);
    rot_4_data(1:3,i) = R_4*rot_4_data(1:3,i);
end

if (exist('acc_5_data','var'))
    for i = 1:length(acc_5_data(1,:))
        acc_5_data(1:3,i) = R_5*acc_5_data(1:3,i);
        rot_5_data(1:3,i) = R_5*rot_5_data(1:3,i);
    end
end

if removebias == 1
% Remove bias from data
    acc_1_data(1,:) = detrend(acc_1_data(1,:));
    acc_1_data(2,:) = detrend(acc_1_data(2,:));
    acc_1_data(3,:) = detrend(acc_1_data(3,:));
    acc_2_data(1,:) = detrend(acc_2_data(1,:));
    acc_2_data(2,:) = detrend(acc_2_data(2,:));
    acc_2_data(3,:) = detrend(acc_2_data(3,:));
    acc_3_data(1,:) = detrend(acc_3_data(1,:));
    acc_3_data(2,:) = detrend(acc_3_data(2,:));
    acc_3_data(3,:) = detrend(acc_3_data(3,:));
    acc_4_data(1,:) = detrend(acc_4_data(1,:));
    acc_4_data(2,:) = detrend(acc_4_data(2,:));
    acc_4_data(3,:) = detrend(acc_4_data(3,:));

    rot_1_data(1,:) = detrend(rot_1_data(1,:));
    rot_1_data(2,:) = detrend(rot_1_data(2,:));
    rot_1_data(3,:) = detrend(rot_1_data(3,:));
    rot_2_data(1,:) = detrend(rot_2_data(1,:));
    rot_2_data(2,:) = detrend(rot_2_data(2,:));
    rot_2_data(3,:) = detrend(rot_2_data(3,:));
    rot_3_data(1,:) = detrend(rot_3_data(1,:));
    rot_3_data(2,:) = detrend(rot_3_data(2,:));
    rot_3_data(3,:) = detrend(rot_3_data(3,:));
    rot_4_data(1,:) = detrend(rot_4_data(1,:));
    rot_4_data(2,:) = detrend(rot_4_data(2,:));
    rot_4_data(3,:) = detrend(rot_4_data(3,:));


    if (exist('acc_5_data','var'))
        acc_5_data(1,:) = detrend(acc_5_data(1,:));
        acc_5_data(2,:) = detrend(acc_5_data(2,:));
        acc_5_data(3,:) = detrend(acc_5_data(3,:));    

        rot_5_data(1,:) = detrend(rot_5_data(1,:));
        rot_5_data(2,:) = detrend(rot_5_data(2,:));
        rot_5_data(3,:) = detrend(rot_5_data(3,:));
    end
end

if filterreq == 1
% Apply a filter
    acc_1_data(1,:) = maia_allfilter(acc_1_data(1,:)',frequency,df);
    acc_1_data(2,:) = maia_allfilter(acc_1_data(2,:)',frequency,df);
    acc_1_data(3,:) = maia_allfilter(acc_1_data(3,:)',frequency,df);
    acc_2_data(1,:) = maia_allfilter(acc_2_data(1,:)',frequency,df);
    acc_2_data(2,:) = maia_allfilter(acc_2_data(2,:)',frequency,df);
    acc_2_data(3,:) = maia_allfilter(acc_2_data(3,:)',frequency,df);
    acc_3_data(1,:) = maia_allfilter(acc_3_data(1,:)',frequency,df);
    acc_3_data(2,:) = maia_allfilter(acc_3_data(2,:)',frequency,df);
    acc_3_data(3,:) = maia_allfilter(acc_3_data(3,:)',frequency,df);
    acc_4_data(1,:) = maia_allfilter(acc_4_data(1,:)',frequency,df);
    acc_4_data(2,:) = maia_allfilter(acc_4_data(2,:)',frequency,df);
    acc_4_data(3,:) = maia_allfilter(acc_4_data(3,:)',frequency,df);

    rot_1_data(1,:) = maia_allfilter(rot_1_data(1,:)',frequency,df);
    rot_1_data(2,:) = maia_allfilter(rot_1_data(2,:)',frequency,df);
    rot_1_data(3,:) = maia_allfilter(rot_1_data(3,:)',frequency,df);
    rot_2_data(1,:) = maia_allfilter(rot_2_data(1,:)',frequency,df);
    rot_2_data(2,:) = maia_allfilter(rot_2_data(2,:)',frequency,df);
    rot_2_data(3,:) = maia_allfilter(rot_2_data(3,:)',frequency,df);
    rot_3_data(1,:) = maia_allfilter(rot_3_data(1,:)',frequency,df);
    rot_3_data(2,:) = maia_allfilter(rot_3_data(2,:)',frequency,df);
    rot_3_data(3,:) = maia_allfilter(rot_3_data(3,:)',frequency,df);
    rot_4_data(1,:) = maia_allfilter(rot_4_data(1,:)',frequency,df);
    rot_4_data(2,:) = maia_allfilter(rot_4_data(2,:)',frequency,df);
    rot_4_data(3,:) = maia_allfilter(rot_4_data(3,:)',frequency,df);
 
    if (exist('acc_5_data','var'))
        acc_5_data(1,:) = detrend(maia_allfilter(acc_5_data(1,:)',frequency,df));
        acc_5_data(2,:) = detrend(maia_allfilter(acc_5_data(2,:)',frequency,df));
        acc_5_data(3,:) = detrend(maia_allfilter(acc_5_data(3,:)',frequency,df));
           
        rot_5_data(1,:) = detrend(maia_allfilter(rot_5_data(1,:)',frequency,df));
        rot_5_data(2,:) = detrend(maia_allfilter(rot_5_data(2,:)',frequency,df));
        rot_5_data(3,:) = detrend(maia_allfilter(rot_5_data(3,:)',frequency,df));
    end
end

if convert == 1
% Convert to SI units
    acc_1_data(1,:) = acc_1_data(1,:)*0.001;
    acc_1_data(2,:) = acc_1_data(2,:)*0.001;
    acc_1_data(3,:) = acc_1_data(3,:)*0.001;
    acc_2_data(1,:) = acc_2_data(1,:)*0.001;
    acc_2_data(2,:) = acc_2_data(2,:)*0.001;
    acc_2_data(3,:) = acc_2_data(3,:)*0.001;
    acc_3_data(1,:) = acc_3_data(1,:)*0.001;
    acc_3_data(2,:) = acc_3_data(2,:)*0.001;
    acc_3_data(3,:) = acc_3_data(3,:)*0.001;
    acc_4_data(1,:) = acc_4_data(1,:)*0.001;
    acc_4_data(2,:) = acc_4_data(2,:)*0.001;
    acc_4_data(3,:) = acc_4_data(3,:)*0.001;

    if (exist('acc_5_data','var'))
        acc_5_data(1,:) = acc_5_data(1,:)*0.001;
        acc_5_data(2,:) = acc_5_data(2,:)*0.001;
        acc_5_data(3,:) = acc_5_data(3,:)*0.001;
    end
    if removebias == 1
        acc_1_data(3,:) = acc_1_data(3,:) + 9.81;
        acc_2_data(3,:) = acc_2_data(3,:) + 9.81;
        acc_3_data(3,:) = acc_3_data(3,:) + 9.81;
        acc_4_data(3,:) = acc_4_data(3,:) + 9.81;
        if (exist('acc_5_data','var'))
            acc_5_data(3,:) = acc_5_data(3,:) + 9.81;
        end
    end
else
    if removebias == 1
        acc_1_data(3,:) = acc_1_data(3,:) + 1000;
        acc_2_data(3,:) = acc_2_data(3,:) + 1000;
        acc_3_data(3,:) = acc_3_data(3,:) + 1000;
        acc_4_data(3,:) = acc_4_data(3,:) + 1000;
        if (exist('acc_5_data','var'))
            acc_5_data(3,:) = acc_5_data(3,:) + 1000;
        end
    end
end


%%
%Debias sensors
% imu_1_data(5,:) = imu_1_data(5,:) - mean(imu_1_data(5,:));
% imu_1_data(6,:) = imu_1_data(6,:) - mean(imu_1_data(6,:));
% imu_1_data(7,1:44250) = imu_1_data(7,1:44250) - mean(imu_1_data(7,1:44250)+9.81);
% imu_1_data(7,44251:end) = imu_1_data(7,44251:end) - mean(imu_1_data(7,44251:end)+9.81);
% imu_1_data(8,:) = imu_1_data(8,:) - mean(imu_1_data(8,:));
% imu_1_data(9,:) = imu_1_data(9,:) - mean(imu_1_data(9,:));
% imu_1_data(10,:) = imu_1_data(10,:) - mean(imu_1_data(10,:));

% acc_1_data = detrend(acc_1_data,'constant');
% acc_1_data(3,:) = acc_1_data(3,:) + 1000;
% rot_1_data = detrend(rot_1_data,'constant');
% 
% acc_2_data = detrend(acc_2_data,'constant');
% acc_2_data(3,:) = acc_2_data(3,:) + 1000;
% rot_2_data = detrend(rot_2_data,'constant');
% 
% acc_3_data = detrend(acc_3_data,'constant');
% acc_3_data(3,:) = acc_3_data(3,:) + 1000;
% rot_3_data = detrend(rot_3_data,'constant');
% 
% acc_4_data = detrend(acc_4_data,'constant');
% acc_4_data(3,:) = acc_4_data(3,:) + 1000;
% rot_4_data = detrend(rot_4_data,'constant');

%% Save data in new struct
imu_data_aligned = struct;
imu_data_aligned = struct_adddata(imu_data_aligned,acc_1_data,rot_1_data,matdatenum,1);
imu_data_aligned.IMU1.R = R_1;
imu_data_aligned.IMU1.alignment = alignment_1;
imu_data_aligned.accunits = 'mg';
imu_data_aligned.rotunits = 'deg/s';
if convert == 1
    imu_data_aligned.accunits = 'ms^-2';
end
imu_data_aligned.frequency = imu_data.frequency;

imu_data_aligned = struct_adddata(imu_data_aligned,acc_2_data,rot_2_data,matdatenum,2);
imu_data_aligned.IMU2.R = R_2;
imu_data_aligned.IMU2.alignment = alignment_2;

imu_data_aligned = struct_adddata(imu_data_aligned,acc_3_data,rot_3_data,matdatenum,3);
imu_data_aligned.IMU3.R = R_3;
imu_data_aligned.IMU3.alignment = alignment_3;

imu_data_aligned = struct_adddata(imu_data_aligned,acc_4_data,rot_4_data,matdatenum,4);
imu_data_aligned.IMU4.R = R_4;
imu_data_aligned.IMU4.alignment = alignment_4;

if estimate == 1
        rotations.IMU1.alignment = [roll_1 pitch_1 yaw_1];
        rotations.IMU2.alignment = [roll_2 pitch_2 yaw_2];
        rotations.IMU3.alignment = [roll_3 pitch_3 yaw_3];
        rotations.IMU4.alignment = [roll_4 pitch_4 yaw_4];
        try
            [path_output,file_output] = uiputfile(pwd,'Select where to save rotation angle file...');
            save(fullfile(file_output,path_output),'rotations');  
        catch
            fprintf('I did not save\n')
        end
end

if filterreq == 1
    imu_data_aligned.df = df;
end

fprintf('Cleaning up \n')
clear acc_1_data acc_2_data acc_3_data acc_4_data rot_1_data rot_2_data rot_3_data rot_4_data
clear matdatenum roll_1 roll_2 roll_3 roll_4 pitch_1 pitch_2 pitch_3 pitch_4 yaw_1 yaw_2 yaw_3 yaw_4
clear sp_rp res R_1 R_2 R_3 R_4 alignment_1 alignment_2 alignment_3 alignment_4 i rotations path_output file_output
clear buttonc buttond frequency df

%%
%close all;

%figure;
%plotCompare(imu_1_data,imu_1_data,0,1,2000,1,0);

%figure;
%plotCompare(imu_2_data,imu_2_data,0,1,2000,1,0);

%figure;
%plotCompare(imu_3_data,imu_3_data,0,1,2000,1,0);

%figure;%figure('units','normalized','outerposition',[0 0 1 1])
%plotCompare(imu_4_data,imu_4_data,0,1,2000,1,0);
%saveas(gcf,strcat('IMU3_',num2str(yaw_4*180/pi),'.png'));
%%
%figure;
%plotCompare(imu_1_data,imu_2_data,imu_3_data,1,5000,1,0);

%figure;
%plotCompare(imu_4_data,imu_2_data,imu_3_data,1,5000,1,0);
%%

% save(strcat('RotatedData',path_to_source_file_1(14:end)),'imu_1_data');
% save(strcat('RotatedData',path_to_source_file_2(14:end)),'imu_2_data');
% save(strcat('RotatedData',path_to_source_file_3(14:end)),'imu_3_data');
% save(strcat('RotatedData',path_to_source_file_4(14:end)),'imu_4_data');
% 
% fprintf('\t -> Files stored in RotatedData folder \n\n\t FINE!\n');





% %%
% 
% 
% 
% 
% 
% 
% % Correctly rotate imu_2_data
% %if IMU_2_aligned == 0
% %    fprintf('\t -> Rotating imu 2 data\n');
%     
%     R_2 = angle2dcm(yaw_2,pitch_2,roll_2);
%     for i = 1:length(imu_2_data(1,:))
%         imu_2_data(5:7,i) = R_2*(diag([-1 -1 -1])*imu_2_data(5:7,i));
%         imu_2_data(8:10,i) = R_2*imu_2_data(8:10,i);
%     end
%     fprintf('\t -> BOW, imu, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_2,(180/pi)*pitch_2,(180/pi)*yaw_2);
%     %var(imu_2_data(5,:))
%     %[mean(imu_2_data(5,:)) mean(imu_2_data(6,:)) mean(imu_2_data(7,:))]
%     %clf;
%     %plotCompare(imu_2_data,imu_1_data,0,1,1000,1,0);
% %else
% %    fprintf('\t -> Imu 2 data has been aligned\n');
% %end
% 
% %%
% l = 3000;
% 
% % Run search for best r,p,y values
% 
% 
% 
% %[roll_3,pitch_3,yaw_3] = rollPitchYawFinder(imu_3_data(:,1:l),imu_2_data(:,1:l),roll_3,pitch_3,yaw_3,[0 0 1 1 1 1],20,1);
% %fprintf('\t -> CG, imu, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_1,(180/pi)*pitch_1,(180/pi)*yaw_1);
% 
% 
% 
% 
% %[roll_3,pitch_3,yaw_3] = rollPitchYawFinder(imu_3_data(:,1:l),imu_2_data(:,1:l),roll_3,pitch_3,yaw_3, [10 0.5 20 10 10 1],0.1,0.01);
% %fprintf('\t -> PORT, imu, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_3,(180/pi)*pitch_3,(180/pi)*yaw_3);
% 
% fprintf('\n\t -> CG, imu, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_1,(180/pi)*pitch_1,(180/pi)*yaw_1);
% fprintf('\n\t -> PORT, imu, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_3,(180/pi)*pitch_3,(180/pi)*yaw_3);
% fprintf('\n\t -> STRB, imu, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_4,(180/pi)*pitch_4,(180/pi)*yaw_4);
% 
% %[roll_4,pitch_4,yaw_4] = rollPitchYawFinder(imu_4_data(:,1:l),imu_2_data(:,1:l),roll_4,pitch_4,yaw_4, [10 0.5 20 10 10 1],0.1,0.01);
% %fprintf('\t -> STRB, imu, Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll_4,(180/pi)*pitch_4,(180/pi)*yaw_4);
% %%
% R_1 = angle2dcm(roll_1,pitch_1,yaw_1,'XYZ');
% R_3 = angle2dcm(yaw_3,pitch_3,roll_3);
% R_4 = angle2dcm(yaw_4,pitch_4,roll_4);
% 
% % Rotate data
% for i = 1:length(imu_1_data(1,:))
%     imu_1_data(5:7,i) = R_1*(diag([-1 -1 -1])*imu_1_data(5:7,i));
%     imu_1_data(8:10,i) = R_1*imu_1_data(8:10,i);
% end
% 
% 
% for i = 1:length(imu_3_data(1,:))
%     imu_3_data(5:7,i) = R_3*(diag([-1 -1 -1])*imu_3_data(5:7,i));
%     imu_3_data(8:10,i) = R_3*imu_3_data(8:10,i);
% end
% 
% for i = 1:length(imu_4_data(1,:))
%     imu_4_data(5:7,i) = R_4*(diag([-1 -1 -1])*imu_4_data(5:7,i));
%     imu_4_data(8:10,i) = R_4*imu_4_data(8:10,i);
% end
% %%
% 
% if Large_configuration
%     temp_1_data = imu_1_data;
%     temp_2_data = imu_2_data;
%     temp_3_data = imu_3_data;
%     temp_4_data = imu_4_data;
% 
%     r_2 = [32 -2.22 8]';
%     r_3 = [-16.8 -10.97 7.6]';
%     r_4 = [-49.41 3.05 1.6]';
% 
%     temp_1_data(8,:) = temp_1_data(8,:) - mean(temp_1_data(8,:)); 
%     temp_1_data(9,:) = temp_1_data(9,:) - mean(temp_1_data(9,:)); 
% 
%     alpha = (10*diff(temp_1_data(8:10,:)'))';
%     for i=2:length(temp_3_data(1,:))
%         temp_2_data(5:7,i) = temp_1_data(5:7,i) + cross(alpha(:,i-1),r_2) + cross(temp_1_data(8:10,i),cross(temp_1_data(8:10,i),r_2));
%         temp_3_data(5:7,i) = temp_1_data(5:7,i) + cross(alpha(:,i-1),r_3) + cross(temp_1_data(8:10,i),cross(temp_1_data(8:10,i),r_3));
%         temp_4_data(5:7,i) = temp_1_data(5:7,i) + cross(alpha(:,i-1),r_4) + cross(temp_1_data(8:10,i),cross(temp_1_data(8:10,i),r_4));
%     end
% end

%clf;
%figure;
%plotCompare(imu_1_data,imu_4_data,0,1,5000,1,0);
%plotCompare(imu_2_data,temp_2_data,0,1,5000,1,0);
%drawnow;
% 
% %clf;
% figure;
% plotCompare(imu_2_data,imu_3_data,0,1,1000,1,0);
% %plotCompare(imu_3_data,temp_3_data,0,1,5000,1,0);
% %drawnow;
% 
% 
% 
% figure;
% plotCompare(imu_1_data,imu_4_data,0,1,1000,1,0);
% %plotCompare(imu_4_data,temp_4_data,0,1,5000,1,0);
% %drawnow;
% 
% save(strcat('RotatedData',path_to_source_file_1(14:end)),'imu_1_data');
% save(strcat('RotatedData',path_to_source_file_2(14:end)),'imu_2_data');
% save(strcat('RotatedData',path_to_source_file_3(14:end)),'imu_3_data');
% save(strcat('RotatedData',path_to_source_file_4(14:end)),'imu_4_data');
% 
% fprintf('\t -> Files stored in RotatedData folder \n\n\t FINE!\n');


% %%
% %figure('Name','Not rotated vectors')
% %plotCompare(imu_2_data,imu_2calib_data,0,0,1000,1);
% 
% %[roll,pitch] = rollPitchFinder(imu_2_data,imu_2calib_data);
% roll = 0;
% pitch = 0;
% 
% imu_2_data(8,:) = imu_2_data(8,:) - ones(1,length(imu_2_data(8,:)))*mean(imu_2_data(8,:));
% imu_2_data(9,:) = imu_2_data(9,:) - ones(1,length(imu_2_data(9,:)))*mean(imu_2_data(9,:));
% 
% yaw_i = 0;
% 
% % + to increase yaw by 1 degree
% % - to decrease yaw by 1 degree
% % e to end
% 
% while yaw_i ~= 'e'
%     R = angle2dcm(yaw,pitch,roll);
%     temp_data = imu_2calib_data;
%     
%     fprintf('\t -> Roll: %1.4f \t Pitch: %1.4f \t Yaw: %1.4f\n',(180/pi)*roll,(180/pi)*pitch,(180/pi)*yaw);
%     
%     for i = 1:length(temp_data)
%         temp_data(5:7,i) = R*temp_data(5:7,i);
%         temp_data(8:10,i) = R*temp_data(8:10,i);
%     end
% 
%     temp_data(8,:) = temp_data(8,:) - ones(1,length(temp_data(8,:)))*mean(temp_data(8,:));
%     temp_data(9,:) = temp_data(9,:) - ones(1,length(temp_data(9,:)))*mean(temp_data(9,:));
%     
%     %figure('Name','Rotated vectors')
%     plotCompare(imu_2_data,temp_data,0,1,1000,1,0);
%     drawnow;
%     
%     yaw_i = input('     -> Yaw increase:','s');
%     roll_i = input('     -> Roll increase:','s');
%     pitch_i = input('     -> Pitch increase:','s');
%     
%     yaw_i = str2double(yaw_i);
%     roll_i = str2double(roll_i);
%     pitch_i = str2double(pitch_i);
%     
%     yaw = yaw + yaw_i*(pi/180);
%     roll = roll + roll_i*(pi/180);
%     pitch = pitch + pitch_i*(pi/180);
%     
%     if yaw_i == 0 && roll_i == 0 && pitch_i == 0
%         fprintf('\t -> Euler angles are found!!?\n');
%         break;
%     end
% end
% 
% %%
% 
% % imu_2 = struct;
% % imu_2.R = eye(3);
% % imu_2.yaw = 0;
% % imu_2.pitch = 0;
% % imu_2.roll = 0;
% % imu_2.leverarm = -1;
% % save('CalibrationParam/imu_2.mat','imu_2');
% % fprintf('\t -> IMU 2 parameters saved!\n')
% %     
% % if path_to_source_file_cal(19) == '3'
% %     imu_3 = struct;
% %     imu_3.R = R;
% %     imu_3.yaw = yaw;
% %     imu_3.pitch = pitch;
% %     imu_3.roll = roll;
% %     imu_3.leverarm = -1;
% %     save('CalibrationParam/imu_3.mat','imu_3');
% %     fprintf('\t -> IMU 3 parameters saved!\n')
% %     
% % else
% %     imu_4 = struct;
% %     imu_4.R = R;
% %     imu_4.yaw = yaw;
% %     imu_4.pitch = pitch;
% %     imu_4.roll = roll;
% %     imu_4.leverarm = -1;
% %     save('CalibrationParam/imu_4.mat','imu_4');
% %     fprintf('\t -> IMU 4 parameters saved!\n')
% % end
% 
% fprintf('FINE!\n')