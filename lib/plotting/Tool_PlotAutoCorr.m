for k = 201:1:length(data_IMU2)
   window_x = data_IMU2(k-200:k,1);
   [out_x(:,k-200)] = autocorr(detrend(window_x),20,[],2);
end

for k = 201:1:length(data_IMU2)
   window_y = data_IMU2(k-200:k,2);
   [out_y(:,k-200)] = autocorr(detrend(window_y),20,[],2);
end
