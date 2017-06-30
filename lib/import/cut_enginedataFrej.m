function[cutenginedata] = cut_enginedataFrej(enginedata,indatevecstart,indatevecstop)

    start = find(datenum(enginedata.timestamp)>datenum(indatevecstart),1,'first');
    stop = find(datenum(enginedata.timestamp)>datenum(indatevecstop),1,'first');

    cutenginedata.timestamp = enginedata.timestamp(start:stop);
    cutenginedata.id = enginedata.id(start:stop);
    cutenginedata.RPM1 = enginedata.RPM1(start:stop);
    cutenginedata.RPM2 = enginedata.RPM2(start:stop);
    cutenginedata.RPM3 = enginedata.RPM3(start:stop);
    cutenginedata.RPM4 = enginedata.RPM4(start:stop);
    cutenginedata.PWR1 = enginedata.PWR1(start:stop);
    cutenginedata.PWR2 = enginedata.PWR2(start:stop);
    cutenginedata.PWR3 = enginedata.PWR3(start:stop);
    cutenginedata.PWR4 = enginedata.PWR4(start:stop);
    cutenginedata.Rudder = enginedata.Rudder(start:stop);

end
