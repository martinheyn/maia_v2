k = 1;

xi = {};

clear xi thresh paragp paragpCIup paragpCIdown

data_port = sqrt(imu_data.IMU5.signal_surge.^2 + imu_data.IMU5.signal_sway.^2).*1.33;
data_sb = sqrt(imu_data.IMU4.signal_surge.^2 + imu_data.IMU4.signal_sway.^2);
test = data_sb;

maxthres = 0.8*max(test);


for u = 0:0.01:maxthres
   
    xi(k,:) = {test(test>u)};
    thresh(k) = u;
    
   [paragp(k,[1:2]),temp] = gpfit(test(test>u)-u);
    paragp(k,3) = paragp(k,2) - paragp(k,1)*u;
    
    paragpCIup(k,[1:2]) = temp(2,:);
    paragpCIup(k,3) = paragpCIup(k,2) - paragp(k,1)*u;
    
    paragpCIdown(k,[1:2]) = temp(1,:);
    paragpCIdown(k,3) = paragpCIdown(k,2) - paragp(k,1)*u;
    
    k = k + 1;
       
    
end

figure
plot(thresh,paragp(:,1));
hold
plot(thresh,paragpCIdown(:,1),'r');
plot(thresh,paragpCIup(:,1),'r');
hold

figure
plot(thresh,paragp(:,3));
hold
plot(thresh,paragpCIdown(:,3),'r');
plot(thresh,paragpCIup(:,3),'r');
hold