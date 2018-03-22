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

mapt = [0,1,0;1,1,0;1,0,0]; % Colour mapping

clear probreturn_surge probreturn_sway probreturn_r2surge probreturn_r2sway probreturn_time
for n = 1:1:length(imu_package_data)
    probreturn_surge(n) = (1-imu_package_data(n).(variname).probreturn.surge);
    probreturn_sway(n) = (1-imu_package_data(n).(variname).probreturn.sway);
    probreturn_r2surge(n) = imu_package_data(n).(variname).probreturn.rsquaresurge;
    probreturn_r2sway(n) = imu_package_data(n).(variname).probreturn.rsquaresway;
    probreturn_time(n) = imu_package_data(n).(variname).timestep;
    
    if ((probreturn_surge(n) >= (0.1)) && (probreturn_sway(n) >= (0.1)))
        warning_colour(n) = 2;
    elseif ((probreturn_surge(n) >= (0.1)) || (probreturn_sway(n) >= (0.1)))
        warning_colour(n) = 1;
    else
        warning_colour(n) = 0; 
    end
        
end

probreturn_threshold = imu_package_data(1).(variname).probreturn.threshold;
probreturn_blocksize = imu_package_data(1).eva.(variname).blocksize;

h = figure

subplot(12,1,1)
heatmap(warning_colour,[],'',[],'Colormap',mapt,'MaxColorValue',2,'MinColorValue',0)
title(strcat('Exceedance of threshold of',' ',num2str(probreturn_threshold),'m\cdots^{-2}'))

subplot(12,1,[2:9])
yyaxis left
plot(probreturn_time,(probreturn_surge),'b','LineWidth',1)
set(gca,'YColor',[0 0 0])
ylabel('Probability of exceeding threshold within the next second')
yTack = [0.00001 0.02 0.04 0.06 0.08 0.10 0.12 0.14 0.16];
set(gca,'YLim',[0.000001 0.18]);
set(gca,'YTick',yTack);
set(gca,'YTicklabel',yTack);
%xlabel('Time')
set(gca,'XLim',[probreturn_time(1) probreturn_time(end)])
grid on

yyaxis right
plot(probreturn_time,(probreturn_sway),'r','LineWidth',1)
datetick
set(gca,'YColor',[0 0 0])
ylabel('Return period of threshold [s]')
set(gca,'YTick',yTack);
yTackret = (probreturn_blocksize/100).*(1./(1-(1-yTack)));
set(gca,'YLim',[0.000001 0.18]);
set(gca,'YTicklabel',yTackret);
%xlabel('Time')
set(gca,'XLim',[probreturn_time(1) probreturn_time(end)])
legend('Return period of threshold for a_x (surge)','Return period of threshold for a_y (sway)')
%text(0.98,-0.10,strcat('Threshold: ',' ',num2str(probreturn_threshold),'m\cdots^{-2}'),'Units','normalized','HorizontalAlignment','right','FontSize',10)

subplot(12,1,[10:12])
plot(probreturn_time,probreturn_r2surge,'b.');
hold on
grid on
plot(probreturn_time,probreturn_r2sway,'r.');
hold off
datetick
set(gca,'YLim',[0.6 1])
set(gca,'YColor',[0 0 0])
set(gca,'XLim',[probreturn_time(1) probreturn_time(end)])
xlabel('Time')
ylabel('Quality of fit (R^2)')
legend('R^2 for a_x (surge)','R^2 for a_y (sway)')


clear accdata_surge accdata_sway accdata_r2surge accdata_r2sway accdata_time
end