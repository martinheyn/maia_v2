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

function [probreturn] = maia_returnfrechetprobs(evaIMUstruct,IMUnumber,accthreshold)
warning('off','all') % Otherwise there are a lot of warnings
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
    case 5
        selectedIMU = 'IMU5';
end

% Find the data in the eva-struct (ExtremeValueAnalysis)
datasurge = evaIMUstruct.(selectedIMU).blockmax(:,1);
datasway = evaIMUstruct.(selectedIMU).blockmax(:,2);

% Get the acceleration for the desired returnperiod (returnperi)
[prob_surge, rsquare_surge] = maia_returnfrechprob(datasurge,accthreshold);
[prob_sway, rsquare_sway] = maia_returnfrechprob(datasway,accthreshold);

probreturn.threshold = accthreshold;
probreturn.surge = prob_surge;
probreturn.sway = prob_sway;
probreturn.rsquaresurge = rsquare_surge;
probreturn.rsquaresway = rsquare_sway;
end

function [probreturn,rsquare] = maia_returnfrechprob(x,accthreshold)
lambda = 0*min(x);

F=edf(x);

u = log(F(:,1)-lambda);
v = -log(-log(F(:,2)));

inx = find(abs(u) == inf);
u(inx) = []; % Remove infinity values (where do they actually come from???)
v(inx) = [];

[f,gof] = fit(u,v,'poly1');

a = f.p1;
b = f.p2;

u_threshold = log(accthreshold-lambda);
probreturn_temp = a*u_threshold+b;

%probreturn = 1-exp(-exp(-probreturn_temp)); % Probability of exceedence
probreturn = exp(-exp(-probreturn_temp)); % Probability of exceedence
rsquare = gof.rsquare;

warning('on','all') % Otherwise there are a lot of warnings
end