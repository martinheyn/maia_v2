function [roll,pitch] = rollPitchFinder(acc_data,roll_0,pitch_0,yaw_0,sp_rp,res)
%ROLLPITCHCOMPUTER Summary of this function goes here
%   Detailed explanation goes here

roll = roll_0;
pitch = pitch_0;

max_z = 0;
for r = roll_0-sp_rp:res:roll_0+sp_rp
    for p = pitch_0-sp_rp:res:pitch_0+sp_rp
        temp_data = acc_data(1:3,1:10:6000);
        R = Rzyx(r,p,yaw_0); 
        for i=1:length(temp_data(1,:))
            temp_data(:,i) = R*temp_data(:,i);
        end
        
        z_mean = abs(mean(temp_data(3,:)));
        %z_err = abs((mean(temp_data(3,:)))+1000);
        if max_z < z_mean
           max_z =  z_mean;
           roll = r;
           pitch = p;
        end
    end
end


end
