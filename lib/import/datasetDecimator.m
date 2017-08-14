function [data_resampled,time_resampled] = datasetDecimator(data_original,time_original,freq_d,basefreq)

    freq_frac = ceil(basefreq/freq_d);
    
    for j = 1:1:3
        [data_temp] = downsample(data_original(j,:),freq_frac);
        data_resampled(j,:) = data_temp;
    end
    clear data_temp j
    
    for j = 4:1:12    
        [data_temp] = decimate(data_original(j,:),freq_frac); 
        data_resampled(j,:) = data_temp;
    end
    clear data_temp j
    
    for j = 13:1:20
        [data_temp] = downsample(data_original(j,:),freq_frac);
        data_resampled(j,:) = data_temp;
    end
      
    time_resampled = linspace(time_original(1),time_original(end),length(data_temp));

end