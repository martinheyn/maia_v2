% This script fixes the timestamp bug during the Arctic Ocean 2016
% expedition

if ((missionselect == 3) || (missionselect == 4) || (missionselect == 5))
    
    display('Fixing Timestamp bug')
    startzeit.IMU1 = imu_1_data(14:19,1);
    startzeit.IMU2 = imu_2_data(14:19,1);
    startzeit.IMU3 = imu_3_data(14:19,1);
    startzeit.IMU4 = imu_4_data(14:19,1);
    
    if exist('imu_5_data','var')
        startzeit.IMU5 = imu_5_data(14:19,1);     
    end
    currentime = startzeit.IMU1;
    
    for m = 1:1:length(imu_1_data)
        
        if mod(m,100) == 0
               currentime(6) = currentime(6) + 1; % Seconds
            if currentime(6) == 60
                currentime(6) = 0;
                currentime(5) = currentime(5) + 1; % Minutes
                if currentime(5) == 60
                    currentime(5) = 0;
                    currentime(4) = currentime(4) + 1; % Hours
                    if currentime(4) == 24
                        currentime(4) = 0;
                        currentime(3) = currentime(3) + 1; % Days
                    end
                end
            end
        end
       imu_1_data(14:19,m) = currentime;
       imu_2_data(14:19,m) = currentime;
       imu_3_data(14:19,m) = currentime;
       imu_4_data(14:19,m) = currentime;
       if exist('imu_5_data','var')
           imu_5_data(14:19,m) = currentime;     
       end
    end
end
  