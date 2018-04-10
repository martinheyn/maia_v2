function [exceedanceprob,avexceedlevel] = maia_findavexceedlevel(gp_struct,returnperiod)

exceedanceprob = gp_struct.exceedances./gp_struct.windowlength;
avexceedlevel = zeros(length(exceedanceprob),1);

for k = 1:1:length(exceedanceprob)
    if gp_struct.estimate(k,1) == 0
        avexceedlevel(k) = gp_struct.threshold + gp_struct.estimate(k,2).*log(returnperiod*exceedanceprob(k));
    else
        avexceedlevel(k) = gp_struct.threshold + gp_struct.estimate(k,2)/gp_struct.estimate(k,1) * ((returnperiod*exceedanceprob(k))^gp_struct.estimate(k,1)-1);
    end
end