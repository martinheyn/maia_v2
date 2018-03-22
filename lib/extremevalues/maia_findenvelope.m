
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This functions returns the enevelope function for given data          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
%
% Inputs:
% [data] = Acceleration data to be analysed
% [blocksize] = Number of samples in each block
% [datastring] = String containing name of data, e.g. 'a_x'
% [h] = Handle to figure, not compulsory
%
% Outputs:
% [blockmax_vec] = Return of the maximum values in each block
%  
%
%    Copyright:     NTNU
%    Project:	    SAmCoT, AMOS
%    Author:        Hans-Martin Heyn
%    Date created:  2016-11-23  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%
%http://se.mathworks.com/help/stats/probplot.html?requestedDomain=www.mathworks.com

function[envelope_up, envelope_down] = maia_findenvelope(data,windowsize,h)

%datapreproc = detrend(data);
%datapreproc(datapreproc<0)=0;

%blockmax_vec = zeros(floor(length(data)/blocksize),1);

[envelope_up, envelope_down] = envelope(data,windowsize,'peak');



if nargin == 4
h = plot(envelope_up,'b--');
hold
plot(envelope_down,'b--');
plot(data,'r');
end

end