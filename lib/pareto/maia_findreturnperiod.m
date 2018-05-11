function [exceedanceprob,returnperiod] = maia_findreturnperiod(gp_struct,exceedlevel)

exceedanceprob = gp_struct.exceedances./gp_struct.windowlength;

threshold = gp_struct.threshold * ones(length(exceedanceprob),1);

exceedlevelv = exceedlevel * ones(length(exceedanceprob),1);

returnperiod = (exceedanceprob .* (1 - gpcdf(exceedlevelv,gp_struct.estimate(:,1),gp_struct.estimate(:,2),threshold)));

end
