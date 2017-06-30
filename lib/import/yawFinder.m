function yaw_0 = yawFinder(acc_data, rot_data, roll, pitch, yaw, ref_acc_data, ref_rot_data, roll_r, pitch_r, yaw_r, delta, res)
%YAWFINDER Summary of this function goes here
%   Detailed explanation goes here

yaw_0 = 0;

%% Downsample data
%acc_data = acc_data(1:3,1:10:end);
%rot_data = rot_data(1:3,1:10:end);
data = [acc_data;rot_data];
%ref_acc_data = ref_acc_data(1:3,1:10:end);
%ref_rot_data = ref_rot_data(1:3,1:10:end);
ref_data = [ref_acc_data;ref_rot_data];

% rotate ref data
R = Rzyx(roll_r,pitch_r,yaw_r);
for i = 1:length(ref_data(1,:))
    ref_data(1:3,i) = R*ref_data(1:3,i);
    ref_data(4:6,i) = R*ref_data(4:6,i);
end

% remove reference data gyro bias
%ref_data(4,:) = ref_data(4,:) - mean(ref_data(4,:));
%ref_data(5,:) = ref_data(5,:) - mean(ref_data(5,:));
ref_data(1,:) = detrend(ref_data(1,:));
ref_data(2,:) = detrend(ref_data(2,:));

guards = zeros(1,length(yaw-delta:res:yaw+delta));
counter = 1;
guard = inf;

for y = yaw-delta:res:yaw+delta
    %y*180/pi
    temp_data = data;
    R = Rzyx(roll,pitch,y);
    
    for i = 1:length(temp_data(1,:))
        temp_data(1:3,i) = R*temp_data(1:3,i);
        temp_data(4:6,i) = R*temp_data(4:6,i);
    end 
    
    %temp_data(4,:) = temp_data(4,:) - mean(temp_data(4,:));
    %temp_data(5,:) = temp_data(5,:) - mean(temp_data(5,:));
    temp_data(1,:) = detrend(temp_data(1,:));
    temp_data(2,:) = detrend(temp_data(2,:));
    
    e_gx = temp_data(1,:)-ref_data(1,:);
    e_gx = e_gx.*e_gx;
    sum_x = sum(e_gx);
    
    e_gy = temp_data(2,:)-ref_data(2,:);
    e_gy = e_gy.*e_gy;
    sum_y = sum(e_gy);
    
    %varz = 1*var(temp_data(1,:));
    guards(counter) = sqrt(sum_x + sum_y);
    
    %[sum_x sum_y varz]./(sum_x + sum_y + varz)
    
    if guard > guards(counter)
        guard = guards(counter);
        yaw_0 = y;
    end
    counter = counter + 1;
end

figure;
plot((yaw-delta:res:yaw+delta)*180/pi,guards)
drawnow;


