function [exceedanceprob,avexceedlevel] = maia_findavexceedlevel(gp_struct,returnprob)

exceedanceprob = gp_struct.exceedances./gp_struct.windowlength;
avexceedlevel = gpinv(returnprob,gp_struct.estimate(:,1),gp_struct.estimate(:,2),gp_struct.threshold);

end
