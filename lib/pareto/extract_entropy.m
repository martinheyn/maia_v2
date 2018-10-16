port_entro_pre = gp_port.entropy;
sb_entro_pre = gp_sb.entropy;


sb_entro = resample(sb_entro_pre,1,20);
port_entro = resample(port_entro_pre,1,20);
sb_entro = sb_entro(1:end-1);
port_entro = port_entro(1:end-1);

sb_exceedlevel_pre = gp_sb.exceedlevel50-gp_sb.threshold;
port_exceedlevel_pre = gp_port.exceedlevel50-gp_port.threshold;

sb_exceedlevel = resample(sb_exceedlevel_pre,1,20);
port_exceedlevel = resample(port_exceedlevel_pre,1,20);

sb_exceedlevel = sb_exceedlevel(1:end-1);
port_exceedlevel = port_exceedlevel(1:end-1);

clear sb_exceedlevel_pre port_exceedlevel_pre sb_entro_pre port_entro_pre