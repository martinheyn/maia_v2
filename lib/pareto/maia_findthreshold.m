k = 1;

xi = {};

clear xi thresh paragp paragpCIup paragpCIdown

% imu_data = imu_data_aligned;

% data_1 = sqrt(imu_data.IMU1.signal_surge.^2 + imu_data.IMU1.signal_sway.^2);
% data_port = sqrt(imu_data.IMU5.signal_surge.^2 + imu_data.IMU5.signal_sway.^2);
% data_sb = sqrt(imu_data.IMU4.signal_surge.^2 + imu_data.IMU4.signal_sway.^2);
% 
% gam_sb = mean(data_sb)/mean(data_1);
% gam_port = mean(data_port)/mean(data_1);



test = gam_sb.*data_sb;

maxthres = 0.8*max(test);


for u = 0:0.01:maxthres
   
    xi(k,:) = {test(test>u)};
    thresh(k) = u;
    
    mrlp(k) = mean(test(test>u));
    
   [paragp(k,[1:2]),temp] = gpfit(test(test>u)-u);
    paragp(k,3) = paragp(k,2) - paragp(k,1)*u;
    
    paragpCIup(k,[1:2]) = temp(2,:);
    paragpCIup(k,3) = paragpCIup(k,2) - paragp(k,1)*u;
    
    paragpCIdown(k,[1:2]) = temp(1,:);
    paragpCIdown(k,3) = paragpCIdown(k,2) - paragp(k,1)*u;
    
    k = k + 1;
       
    
end

figure
subplot 211
plot(thresh,paragp(:,1));
hold
plot(thresh,paragpCIdown(:,1),'r--');
plot(thresh,paragpCIup(:,1),'r--');
ylabel('Shape parameter estimate \xi')
xlabel('Threshold u starboard')
hold
grid on

subplot 212
plot(thresh,paragp(:,3));
hold
plot(thresh,paragpCIdown(:,3),'r--');
plot(thresh,paragpCIup(:,3),'r--');
ylabel('Scale parameter estimate \sigma')
xlabel('Threshold u starboard')
hold
grid on

figure
plot(thresh,mrlp)
ylabel('Mean residual')
xlabel('Threshold u starboard')
grid on

k = 1;

test = gam_port.*data_port;

maxthres = 0.8*max(test);


for u = 0:0.01:maxthres
   
    xi(k,:) = {test(test>u)};
    thresh(k) = u;
    mrlp(k) = mean(test(test>u));
    
   [paragp(k,[1:2]),temp] = gpfit(test(test>u)-u);
    paragp(k,3) = paragp(k,2) - paragp(k,1)*u;
    
    paragpCIup(k,[1:2]) = temp(2,:);
    paragpCIup(k,3) = paragpCIup(k,2) - paragp(k,1)*u;
    
    paragpCIdown(k,[1:2]) = temp(1,:);
    paragpCIdown(k,3) = paragpCIdown(k,2) - paragp(k,1)*u;
    
    k = k + 1;
       
    
end

figure
subplot 211
plot(thresh,paragp(:,1));
hold
plot(thresh,paragpCIdown(:,1),'r--');
plot(thresh,paragpCIup(:,1),'r--');
ylabel('Shape parameter estimate \xi')
xlabel('Threshold u port')
hold
grid on

subplot 212
plot(thresh,paragp(:,3));
hold
plot(thresh,paragpCIdown(:,3),'r--');
plot(thresh,paragpCIup(:,3),'r--');
ylabel('Scale parameter estimate \sigma')
xlabel('Threshold u port')
hold
grid on


figure
plot(thresh,mrlp)
ylabel('Mean residual')
xlabel('Threshold u port')
grid on