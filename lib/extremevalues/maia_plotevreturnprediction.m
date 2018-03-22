function[] = maia_plotevprediction(imu_package_data,IMUnumber)

switch IMUnumber
    case 1
        variname = 'IMU1';
    case 2
        variname = 'IMU2';
    case 3
        variname = 'IMU3';
    case 4
        variname = 'IMU4';
    case 5
        variname = 'IMU5';
end

clear probreturn_surge probreturn_sway probreturn_r2surge probreturn_r2sway probreturn_time

probreturn_threshold = imu_package_data(1).(variname).probreturn.threshold;
probreturn_blocksize = imu_package_data(1).eva.(variname).blocksize;

for n = 1:1:length(imu_package_data)
    probreturn_surge(n) = (probreturn_blocksize/100).*(1./(imu_package_data(n).(variname).probreturn.surge));
    probreturn_sway(n) = (probreturn_blocksize/100).*(1./(imu_package_data(n).(variname).probreturn.sway));
    probreturn_r2surge(n) = imu_package_data(n).(variname).probreturn.rsquaresurge;
    probreturn_r2sway(n) = imu_package_data(n).(variname).probreturn.rsquaresway;
    probreturn_time(n) = imu_package_data(n).(variname).timestep;
end

h = figure

subplot(4,1,[1:3])
plot(probreturn_time,probreturn_surge,'b','LineWidth',1)
hold on 
grid on
plot(probreturn_time,probreturn_sway,'r','LineWidth',1)
datetick
hold off
set(gca,'YColor',[0 0 0])
ylabel('Return period of threshold value [s]')
xlabel('Time')
set(gca,'XLim',[probreturn_time(1) probreturn_time(end)])
legend('Return period of acceleration higher or equal threshold for a_x (surge)','Return period of acceleration higher or equal threshold for a_y (sway)')
title(strcat('Exceedance of threshold of',' ',num2str(probreturn_threshold),'m\cdots^{-2}'))
%text(0.98,-0.10,strcat('Threshold: ',' ',num2str(probreturn_threshold),'m\cdots^{-2}'),'Units','normalized','HorizontalAlignment','right','FontSize',10)

subplot(4,1,4)
plot(probreturn_time,probreturn_r2surge,'b.');
hold on
grid on
plot(probreturn_time,probreturn_r2sway,'r.');
hold off
datetick
set(gca,'YLim',[0.7 1])
set(gca,'YColor',[0 0 0])
set(gca,'XLim',[probreturn_time(1) probreturn_time(end)])
xlabel('Time')
ylabel('Quality of fit (R^2)')
legend('R^2 for a_x (surge)','R^2 for a_y (sway)')


clear accdata_surge accdata_sway accdata_r2surge accdata_r2sway accdata_time
end