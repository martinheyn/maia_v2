function[] = maia2_plotevreturnperiod(mleevestimateport,mleevestimatesb,threshold)

thresholdvec = threshold.*ones(length(mleevestimateport.estimate),1);
probreturn_threshold_port = 1-gevcdf(thresholdvec,mleevestimateport.estimate(:,1),mleevestimateport.estimate(:,2),mleevestimateport.estimate(:,3));
probreturn_threshold_sb = 1-gevcdf(thresholdvec,mleevestimatesb.estimate(:,1),mleevestimatesb.estimate(:,2),mleevestimatesb.estimate(:,3));

probreturn_p_port = mleevestimateport.ks(:,2);
probreturn_p_sb = mleevestimatesb.ks(:,2);

probreturn_time_port = mleevestimateport.matdatenum;
probreturn_time_sb = mleevestimatesb.matdatenum;

h = figure

subplot(12,1,[1:9])
yyaxis left
plot(probreturn_time_port,(probreturn_threshold_port),'b','LineWidth',1)
set(gca,'YColor',[0 0 0])
ylabel('Probability of exceeding threshold within the next second')
yTack = [0.00001 0.05 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95 0.995 0.998];
set(gca,'YLim',[0.000001 1.0]);
set(gca,'YTick',yTack);
set(gca,'YTicklabel',yTack);
%xlabel('Time')
set(gca,'XLim',[probreturn_time_port(1) probreturn_time_port(end)])
grid on

yyaxis right
plot(probreturn_time_sb,(probreturn_threshold_sb),'r','LineWidth',1)
datetick
set(gca,'YColor',[0 0 0])
ylabel('Return period of threshold [s]')
set(gca,'YTick',yTack);
yTackret = (mleevestimatesb.blocklength/mleevestimatesb.frequency).*(1./(1-(1-yTack)));
set(gca,'YLim',[0.000001 1.0]);
set(gca,'YTicklabel',yTackret);
%xlabel('Time')
set(gca,'XLim',[probreturn_time_sb(1) probreturn_time_sb(end)])
legend('Return period of threshold for port','Return period of threshold for starboard')
%text(0.98,-0.10,strcat('Threshold: ',' ',num2str(probreturn_threshold),'m\cdots^{-2}'),'Units','normalized','HorizontalAlignment','right','FontSize',10)

subplot(12,1,[10:12])
plot(probreturn_time_port,probreturn_p_port,'b');
hold on
grid on
plot(probreturn_time_sb,probreturn_p_sb,'r');
hold off
datetick
set(gca,'YLim',[0.6 1])
set(gca,'YColor',[0 0 0])
set(gca,'XLim',[probreturn_time_port(1) probreturn_time_port(end)])
xlabel('Time')
ylabel('KS Test Statistics')
legend('Port','Starboard')

end