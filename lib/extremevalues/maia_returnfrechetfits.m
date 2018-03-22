%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This functions returns the acceleration value of a desired return period
%based on the Frechet probability paper estimate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-05-31  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%

function [accreturn] = maia_returnfrechetfits(evaIMUstruct,IMUnumber,returnperi)

% Which IMU is used?
switch IMUnumber
    case 1
        selectedIMU = 'IMU1';
    case 2
        selectedIMU = 'IMU2';
    case 3
        selectedIMU = 'IMU3';
    case 4
        selectedIMU = 'IMU4';
end

% Find the data in the eva-struct (ExtremeValueAnalysis)
datasurge = evaIMUstruct.(selectedIMU).blockmax(:,1);
datasway = evaIMUstruct.(selectedIMU).blockmax(:,2);

% Get the acceleration for the desired returnperiod (returnperi)
[accreturn_surge, rsquare_surge] = maia_returnfrech(datasurge,evaIMUstruct.(selectedIMU).blocksize,returnperi);
[accreturn_sway, rsquare_sway] = maia_returnfrech(datasway,evaIMUstruct.(selectedIMU).blocksize,returnperi);

accreturn.period = returnperi;
accreturn.surge = accreturn_surge;
accreturn.sway = accreturn_sway;
accreturn.rsquaresurge = rsquare_surge;
accreturn.rsquaresway = rsquare_sway;
end

function [accreturn,rsquare] = maia_returnfrech(x,blocksize,returnperi)
lambda = 0*min(x);

F=edf(x);

u = log(F(:,1)-lambda);
v = -log(-log(F(:,2)));

inx = find(abs(u) == inf);
u(inx) = []; % Remove infinity values (where do they come from???)
v(inx) = [];

return_prob = 1-(blocksize/(100*returnperi)); % Calculate return probability
p_desired_inv = -log(-log(return_prob)); % Match to Frechet paper

[f,gof] = fit(u,v,'poly1');

a = f.p1;
b = f.p2;

u = (p_desired_inv - b) / a;

accreturn = exp(u)+lambda;
rsquare = gof.rsquare;

end