
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This functions creates blocks of data and returns the maximum value   %%
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
%    Date created:  2016-04-07  Hans-Martin Heyn (NTNU)
%---------------------------------------------------------------------%
%http://se.mathworks.com/help/stats/probplot.html?requestedDomain=www.mathworks.com

function[blockmax_vec] = maia_blockandmax(data,blocksize,datastring,h)

datapreproc = data;
%datapreproc = detrend(data);
datapreproc(datapreproc<0)=0;

blockmax_vec = zeros(floor(length(data)/blocksize),1);

for k = 1:1:length(blockmax_vec)
     %blockmax_vec(k) =
     %max(abs(data((((k-1)*blocksize)+1):(k*blocksize)))); %<= That is a
     %terrible terrible terrible idea!!
     
     %blockmax_vec(k) = max(abs(detrend(data((((k-1)*blocksize)+1):(k*blocksize)))));
     %blockmax_vec(k) = max((detrend(data((((k-1)*blocksize)+1):(k*blocksize)))));
     blockmax_vec(k) = max(datapreproc((((k-1)*blocksize)+1):(k*blocksize)));
    
end

if nargin == 4
h = plot([1,1:(length(blockmax_vec)-1)]',blockmax_vec);
end