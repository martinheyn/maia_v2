function[cutshipdata] = cut_shipdata(shipdata,indatevecstart,indatevecstop)

    start = find(datenum(shipdata.timestamp)>indatevecstart,1,'first');
    stop = find(datenum(shipdata.timestamp)>indatevecstop,1,'first');

    cutshipdata.timestamp = shipdata.timestamp(start:stop);
    cutshipdata.heading = shipdata.heading(start:stop);
    cutshipdata.COG = shipdata.COG(start:stop);
    cutshipdata.SOG = shipdata.SOG(start:stop);
    cutshipdata.GPS_lon = shipdata.GPS_lon(start:stop);
    cutshipdata.GPS_lat = shipdata.GPS_lat(start:stop);
    cutshipdata.windDirTrue = shipdata.windDirTrue(start:stop);
    cutshipdata.windSpeedTrue = shipdata.windSpeedTrue(start:stop);
    cutshipdata.windDirRel = shipdata.windDirRel(start:stop);
    cutshipdata.windSpeedRel = shipdata.windSpeedRel(start:stop);
    try
    cutshipdata.SQL_depth = shipdata.SQL_depth(start:stop);
    catch
        fprintf('Depth sensor not available\n')
    end
    
end
