function [entropy] = maia_gpentropy(gp_struct)

entropy = log(gp_struct.estimate(:,2)) + gp_struct.estimate(:,1) + 1;

end