data_port = sqrt(detrend(imu_data_aligned.IMU5.signal_surge).^2 + detrend(imu_data_aligned.IMU5.signal_sway).^2).*1.33;
data_sb = sqrt(detrend(imu_data_aligned.IMU4.signal_surge).^2 + detrend(imu_data_aligned.IMU4.signal_sway).^2);

timevect = imu_data_aligned.IMU5.matdatenum;

% windowlength = 3000;
% frequency = 100;

windowlength = 300;
frequency = 20;

[gamma_port] = maia_recursivegamma(data_port,timevect,windowlength,frequency);
[gamma_sb] = maia_recursivegamma(data_sb,timevect,windowlength,frequency);

function [gammapar] = maia_recursivegamma(data,timevect,windowlength,frequency)

L = length(data);

gammapar.windowlength = windowlength;
gammapar.frequency = frequency;
gammapar.estimate = zeros(L,2);
gammapar.CIdown = zeros(L,2);
gammapar.CIup = zeros(L,2);
gammapar.matdatenum = timevect;
%mleevSEs = zeros(L,3);

for k = 1+windowlength:1:L
    
    if mod(k,1000) == 0
    k    
    end
    
    datawindow = data(k-windowlength:k);
    [gptemp,gpCItemp] = gamfit(datawindow);
        
    gammapar.estimate(k,:) = gptemp;
    gammapar.CIdown(k,:) = gpCItemp(1,:);
    gammapar.CIup(k,:) = gpCItemp(2,:);
end

end