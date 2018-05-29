imu_data = imu_data_aligned;

data_1 = sqrt(imu_data.IMU1.signal_surge.^2 + imu_data.IMU1.signal_sway.^2);
data_port = sqrt(imu_data.IMU5.signal_surge.^2 + imu_data.IMU5.signal_sway.^2);
data_sb = sqrt(imu_data.IMU4.signal_surge.^2 + imu_data.IMU4.signal_sway.^2);
% data_port2 = sqrt(imu_data.IMU3.signal_surge.^2 + imu_data.IMU3.signal_sway.^2);
% data_sb2 = sqrt(imu_data.IMU2.signal_surge.^2 + imu_data.IMU2.signal_sway.^2);

% gam_sb = mean(data_sb(10000:20000))/mean(data_1);
% gam_port = mean(data_port(10000:20000))/mean(data_1);

gam_sb = 1.11;
gam_port = 0.88;

data_port =  data_port ./ gam_port;
data_sb = data_sb ./ gam_sb;

warning('off','all')
timevect = imu_data_aligned.IMU5.matdatenum;

% windowlength = 3000;
% frequency = 100;

windowlength = 200;
frequency = 20;
threshold = 0.01;
%threshold = 0.10;

[gp_port] = maia_recursivegp(data_port,timevect,windowlength,threshold,frequency);
[gp_sb] = maia_recursivegp(data_sb,timevect,windowlength,threshold,frequency);

[gp_sb.exceedtime,gp_sb.exceedlevel50] = maia_findavexceedlevel(gp_sb,0.5);
[gp_port.exceedtime,gp_port.exceedlevel50] = maia_findavexceedlevel(gp_port,0.5);

[gp_sb.exceedtime,gp_sb.returnlevel15u] = maia_findreturnlevel(gp_sb,1.5*threshold);
[gp_port.exceedtime,gp_port.returnlevel15u] = maia_findreturnlevel(gp_port,1.5*threshold);

% [gp_MLE_sb.exceedtime,gp_MLE_sb.exceedlevel1000] = maia_findavexceedlevel(gp_MLE_sb,1000);
% [gp_MLE_port.exceedtime,gp_MLE_port.exceedlevel1000] = maia_findavexceedlevel(gp_MLE_port,1000);

% [gp_PWM_sb.exceedtime,gp_PWM_sb.exceedlevel1000] = maia_findavexceedlevel(gp_PWM_sb,1000);
% [gp_PWM_port.exceedtime,gp_PWM_port.exceedlevel1000] = maia_findavexceedlevel(gp_PWM_port,1000);
% 
% [gp_MOM_sb.exceedtime,gp_MOM_sb.exceedlevel1000] = maia_findavexceedlevel(gp_MOM_sb,1000);
% [gp_MOM_port.exceedtime,gp_MOM_port.exceedlevel1000] = maia_findavexceedlevel(gp_MOM_port,1000);

function [gp_MLE] = maia_recursivegp(data,timevect,windowlength,threshold,frequency)

L = length(data);

gp_MLE.windowlength = windowlength;
gp_MLE.frequency = frequency;
gp_MLE.threshold = threshold;
gp_MLE.estimate = zeros(L,2);
gp_MLE.CIdown = zeros(L,2);
gp_MLE.CIup = zeros(L,2);
gp_MLE.matdatenum = timevect;

% gp_MOM.windowlength = windowlength;
% gp_MOM.frequency = frequency;
% gp_MOM.threshold = threshold;
% gp_MOM.estimate = zeros(L,2);
% gp_MOM.matdatenum = timevect;
% 
% gp_PWM.windowlength = windowlength;
% gp_PWM.frequency = frequency;
% gp_PWM.threshold = threshold;
% gp_PWM.estimate = zeros(L,2);
% gp_PWM.matdatenum = timevect;

for k = 1+windowlength:1:L
    
    if mod(k,1000) == 0
    k    
    end
    
    datawindow = data(k-windowlength:k);
%    datawindowsorted = sort(datawindow);
%     datawindowmean = mean(datawindow);
%     datawindowvar = var(datawindow);
%    datawindowt = 0;
    
    %for o = 1:1:length(datawindow)
       %datawindowt = datawindowt + (1-((o-0.35)/length(datawindow))*datawindowsorted(o));
%     end
%     
%     % MOM estimation
%     gp_MOM.exceedances(k,:) = length(datawindow(datawindow>threshold));
%     gp_MOM.estimate(k,1) = 0.5*(1-((datawindowmean^2)/datawindowvar));
%     gp_MOM.estimate(k,2) = 0.5*datawindowmean*(((datawindowmean^2)/datawindowvar)+1);
%     
%     % PWM estimate
%     gp_PWM.exceedances(k,:) = length(datawindow(datawindow>threshold));
%     gp_PWM.estimate(k,1) = -datawindowmean/(datawindowmean-2*datawindowt)+2;
%     gp_PWM.estimate(k,2) = 2*datawindowmean*datawindowt/(datawindowmean-2*datawindowt);
%     
    % MLE estimator
    gp_MLE.exceedances(k,:) = length(datawindow(datawindow>threshold));
    
    if gp_MLE.exceedances(k,:) > 0
        [gptemp,gpCItemp] = gpfit(datawindow(datawindow>threshold)-threshold);
        
    else
        gptemp = [NaN NaN];
        gpCItemp = [NaN NaN; NaN NaN];
    end
        
    gp_MLE.estimate(k,:) = gptemp;
    gp_MLE.CIdown(k,:) = gpCItemp(1,:);
    gp_MLE.CIup(k,:) = gpCItemp(2,:);
        
 
        
    
end

end