function [drift_estimate] = estimate_drift(entropy_port,entropy_sb,samplerate)

    entropy_port_d = decimate(entropy_port(~isinf(entropy_port)),samplerate);
    entropy_sb_d = decimate(entropy_sb(~isinf(entropy_sb)),samplerate);

    drift_estimate(:,1) = (3.385 + entropy_port_d)./-0.002064;    
    drift_estimate(:,2) = (6.765 + entropy_sb_d)./0.01584;
    drift_estimate(:,3) = 0.5.*(drift_estimate(:,1) + drift_estimate(:,2));
    
end