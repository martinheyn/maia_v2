function [data_resampled,time_resampled,data_original,time_original] = datasetResampler(data_original,f_d)
% CSV2dataset resamples the dataset with a new frequency given by f_d
%
%   data_resampled is the calculated re-sampled data matrix  
%   time_resampled is the calculated re-sampled time vector   
%   data_original is the cut original data matrix
%   time_original is calculated original time vector of the cut original
%   data
%

% cut end of data to whole secound
j = length(data_original);
while data_original(j,end-1) ~= 1
    j = j - 1;
end
data_original = data_original(1:j-1,:);

% Create time vector from start of dataseries
time_original = zeros(size(data_original(:,1)));

sec_starts = find(data_original(:,19) == 1);
sec_ends = sec_starts(2:end) - ones(size(sec_starts(2:end)));
sec_ends(length(sec_ends)+1) = data_original(end,20);

c = 1;
for i = 1:length(time_original)
    time_fract = 0;
    if i <= sec_ends(c)+1
       time_fract = 1/data_original(sec_ends(c),19);
    else
       c = c + 1;
       time_fract = 1/data_original(sec_ends(c),19);
    end
    if i > 1
        time_original(i) = time_original(i-1) + time_fract;
    end
end

data_resampled = zeros(20,ceil(f_d*time_original(end)));
time_resampled = zeros(1,ceil(f_d*time_original(end)));

for j = 1:20
    time_n = 0;
    prev_dataindex = 0;
    for i = 1:length(data_resampled(1,:))
        if i == 1
           data_resampled(j,1) = data_original(1,j);
           time_n = time_n + 1/f_d;
           prev_dataindex = 1;
        else
            while time_n > time_original(prev_dataindex)
                prev_dataindex = prev_dataindex + 1;    
            end
            data_resampled(j,i) = data_original(prev_dataindex,j);
            time_n = time_n + 1/f_d;
        end
        time_resampled(i) = time_n;
    end
end

end