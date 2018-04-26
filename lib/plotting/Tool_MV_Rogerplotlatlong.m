close all

spheroid = referenceEllipsoid('wgs84');
rEarth = 6378137.0; 
g0     = 9.80665;
we     = 7.292115e-5;
wie_e  = [0 0 we]';
Sie_e  = Smtrx(wie_e);


startinx = 421;
%endinx = length(Timest);
endinx = 721;

lat_in = Lat_position_Deg(startinx:endinx);
long_in = Lon_position_Deg(startinx:endinx);
Head = Heading_Deg(startinx:endinx);

Nav_t = datenum(Timest(startinx:endinx));

lat0 = lat_in(1);
lon0 = long_in(1);
h0   = 0; %rEarth;

C = linspecer(4);

h = h0;
[xNED,yNED,zNED]    = geodetic2ned(lat_in,long_in,h,lat0,lon0,h0,spheroid);
[xECEF,yECEF,zECEF] = geodetic2ecef(spheroid,lat_in,long_in,h);
pNED = [xNED,yNED,zNED]';

pECEF = [xECEF,yECEF,zECEF]';
Cent_ie_e = Sie_e*Sie_e*pECEF;
% nu_nb_n = [2 1 0]';
% 2*Sie_e*nu_nb_n

xUTM = North_position_UTM_M(startinx:endinx)-North_position_UTM_M(startinx);
yUTM = East_position_UTM_M(startinx:endinx)-East_position_UTM_M(startinx);

figure
subplot(3,1,[1,2]);
plot(yNED,xNED,'Color',C(3,:)');
hold
plot(yNED(1),xNED(1),'o');
plot(yUTM,xUTM,'Color',C(1,:)');
grid on
hold

subplot(3,1,3);
plot(Nav_t,Head,'Color',C(2,:)');
datetick
grid on

figure
subplot(3,1,[1,2]);
plot(long_in,lat_in,'Color',C(4,:)');
hold
plot(long_in(1),lat_in(1),'o');
grid on
hold

subplot(3,1,3);
plot(Nav_t,Head,'Color',C(2,:)');
datetick
grid on

figure
plot(yNED,xNED,'Color',C(3,:)');
xx=[yNED';yNED'];
yy=[xNED';xNED'];
cc=[Fx_Anchor_N(startinx:endinx)';Fx_Anchor_N(startinx:endinx)'];
zz=zeros(size(xx));
surf(xx,yy,zz,cc,'EdgeColor','interp','LineWidth',2)
colormap('jet')
%colorbar('southoutside')
view(2)
hold
grid on
dec = 150;
st = 0.7;
L = 1*200;
am = st*0.015;
arle = 0.1;

xlabel('East position (m)')
ylabel('North position (m)')
%colorbar('southoutside')

Fx_Anchor_N_max = max(Fx_Anchor_N(startinx:endinx));

for now=1:dec:length(xNED)
        %MS Fartoystyring
    tmpR=[cosd(Head(now)) -sind(Head(now)); sind(Head(now)) cosd(Head(now))];
    boat = tmpR*[am*L/2 am*.9*L/2 am*.5*L/2 am*-L/2 am*-L/2 am*.5*L/2 am*.9*L/2 am*L/2; 
              am*0 am*10 am*20 am*20 am*-20 am*-20 am*-10 am*0];
    
    if now == 1
        plot(yNED(now)+boat(2,:),xNED(now)+boat(1,:),'r');
        patch(yNED(now)+boat(2,:),xNED(now)+boat(1,:),'r');
    else      
        plot(yNED(now)+boat(2,:),xNED(now)+boat(1,:),'y');
        patch(yNED(now)+boat(2,:),xNED(now)+boat(1,:),'y');
    end
end

for now=1:dec:length(xNED)
    if exist('Ice_Drift_Direction_DB_deg','var')
        pos = get(gca, 'Position');
        [delta_y, delta_x] = pol2cart((Ice_Drift_Direction_DB_deg(now+startinx-1)*(pi/180)),arle);
        %[delta_y, delta_x] = pol2cart((24*(pi/180)),0.05);
        
        annotation('arrow',[(yNED(now) + abs(min(xlim)))/diff(xlim) * pos(3) + pos(1),...
         ((yNED(now) + abs(min(xlim)))/diff(xlim) * pos(3) + pos(1))+delta_x ],... 
        [(xNED(now) - min(ylim))/diff(ylim) * pos(4) + pos(2),...
         %((xNED(now) - min(ylim))/diff(ylim) * pos(4) + pos(2))+delta_y],'String',num2str(AverageofIce_Drift_Velocity_DB_ms(now)));
         %((xNED(now) - min(ylim))/diff(ylim) * pos(4) + pos(2))+delta_y],'String',num2str(Ice_Drift_Direction_DB_deg(now+startinx-1)));
         ((xNED(now) - min(ylim))/diff(ylim) * pos(4) + pos(2))+delta_y]);
    end
end

dim = [.6 .7 .2 .2];
annotation('textbox',dim,'String',strcat('Average ice drift velocity:','{ }',num2str(mean(AverageofIce_Drift_Velocity_DB_ms(startinx:endinx))),'{ }','ms^{-1}'),'FitBoxToText','on');

hold

clear dim pos arle am L dec tmpR boat tnow now Head h C h0 lon0 lat0 Nav_t long_in lat_in endinx startinx Sie_e wie_e we g0 rEarth spheroid