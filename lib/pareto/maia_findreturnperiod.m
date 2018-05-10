function [exceedanceprob,returnperiod] = maia_findreturnperiod(gp_struct,exceedlevel)

exceedanceprob = gp_struct.exceedances./gp_struct.windowlength;
returnperiod = zeros(length(exceedanceprob),1);

for k = 1:1:length(exceedanceprob)
    if gp_struct.estimate(k,1) == 0
        returnperiod(k) = exceedanceprob * exp(-(exceedlevel-gp_struct.threshold)/gp_struct.estimate(k,2));
    else
        returnperiod(k) = exceedanceprob * (1+gp_struct.estimate(k,1)*(exceedlevel-gp_struct.threshold)/gp_struct.estimate(k,2))^(-1/gp_struct.estimate(k,1));
    end
end
