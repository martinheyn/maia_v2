figure

spheroid = referenceEllipsoid('wgs84');
rEarth = 6378137.0; 
g0     = 9.80665;
we     = 7.292115e-5;
wie_e  = [0 0 we]';
Sie_e  = Smtrx(wie_e);


startinx = 1;
endinx = length(Timest);

lat_in = Lat_position_Deg(startinx:endinx);
long_in = Lon_position_Deg(startinx:endinx);
Head = Heading_Deg(startinx:endinx);

Nav_t = datenum(Timest(startinx:endinx));

lat0 = lat_in(1);
lon0 = long_in(1);
h0   = 0; %rEarth;

C = linspecer(3);

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

figure(1); subplot(3,1,[1,2]);
plot(yNED,xNED,'Color',C(3,:)');
hold
plot(yUTM,xUTM,'Color',C(1,:)');
grid on
hold

subplot(3,1,3);
plot(Nav_t,Head,'Color',C(2,:)');
datetick
grid on
