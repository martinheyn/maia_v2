figure
subplot 211
plot(TimeStrain,OneSpan_1035P)
hold
plot(TimeStrain,OneSpan_104P)
plot(TimeStrain,OneSpan_1045P)
plot(TimeStrain,OneSpan_105P)
plot(TimeStrain,OneSpan_1065P)
plot(TimeStrain,OneSpan_107P)
plot(TimeStrain,OneSpan_1075P)
plot(TimeStrain,OneSpan_108P)
title('Port')
ylabel('Strain Force (N)')
xlabel('Time')
datetick
grid on
legend('103.5','104','104.5','105','106.5','107','107.5','108')

subplot 212
plot(TimeStrain,OneSpan_1035S)
hold
plot(TimeStrain,OneSpan_104S)
plot(TimeStrain,OneSpan_1045S)
plot(TimeStrain,OneSpan_105S)
plot(TimeStrain,OneSpan_1065S)
plot(TimeStrain,OneSpan_107S)
plot(TimeStrain,OneSpan_1075S)
plot(TimeStrain,OneSpan_108S)
title('Starboard')
ylabel('Strain Force (N)')
xlabel('Time')
datetick
grid on
legend('103.5','104','104.5','105','106.5','107','107.5','108')