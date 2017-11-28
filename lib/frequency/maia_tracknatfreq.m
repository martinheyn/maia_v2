% This script recursively runs through a acceleration data
% from icebreaker Frej and tracks the
% first modal frequency of the hull

function [natfreq] = maia_tracknatfreq(signal,window_size,sample_rate,modal_frequency1,omega1,modal_frequency2,omega2)
    
    natfreq = zeros(length(signal),2);
    freq_resolution = (0.5*sample_rate)/window_size;
    modal1_floor_inx = floor((modal_frequency1 - 0.5*omega1)/freq_resolution) + 1;
    modal1_ceil_inx = floor((modal_frequency1 + 0.5*omega1)/freq_resolution) + 1;
    modal2_floor_inx = floor((modal_frequency2 - 0.5*omega2)/freq_resolution) + 1;
    modal2_ceil_inx = floor((modal_frequency2 + 0.5*omega2)/freq_resolution) + 1;

    for k = window_size:1:length(signal)
        
        signal_cut = signal(k-window_size+1:k);        
        [tfd,~,f,~] = maia_tfd(signal_cut);
        freqspec = sum(tfd,2);
        
        search_window = freqspec(modal1_floor_inx:modal1_ceil_inx);
        [~,maxtemp1] = max(search_window);
        maxtemp1 = maxtemp1 -2 + modal1_floor_inx;
        natfreq(k,1) = maxtemp1 * freq_resolution;
        
        search_window = freqspec(modal2_floor_inx:modal2_ceil_inx);
        [~,maxtemp2] = max(search_window);
        maxtemp2 = maxtemp2 + modal2_floor_inx;
        natfreq(k,2) = maxtemp2 * freq_resolution;
       
    end
    
end