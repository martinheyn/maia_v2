function[cutenginedata] = cut_enginedataOden(enginedata,indatevecstart,indatevecstop)

    start = find(datenum(enginedata.timestamp)>datenum(indatevecstart),1,'first');
    stop = find(datenum(enginedata.timestamp)>datenum(indatevecstop),1,'first');

    cutenginedata.timestamp = enginedata.timestamp(start:stop);
    cutenginedata.rudder_port = enginedata.rudder_port(start:stop);
    cutenginedata.rudder_stbd = enginedata.rudder_stbd(start:stop);
    cutenginedata.pitch_port = enginedata.pitch_port(start:stop);
    cutenginedata.pitch_stbd = enginedata.pitch_stbd(start:stop);
    cutenginedata.rpm_port = enginedata.rpm_port(start:stop);
    cutenginedata.rpm_stbd = enginedata.rpm_stbd(start:stop);
    cutenginedata.torque_port = enginedata.torque_port(start:stop);
    cutenginedata.torque_stbd = enginedata.torque_stbd(start:stop);
    cutenginedata.power_port = enginedata.power_port(start:stop);
    cutenginedata.power_stbd = enginedata.power_stbd(start:stop);

end
