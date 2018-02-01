function[h_backward,h_forward] = maia_cascadedetection_twoway(g_Snu)

    h_0 = 120;
    h_1 = 90;
    h_2 = 90;
    h_3 = 90;
    
    h_forward = zeros(length(g_Snu),1);
    h_backward = zeros(length(g_Snu),1);
    for k = 1:1:length(g_Snu)
        % Worst condition to best condition cascade
        if g_Snu(k,4) <= h_3
            h_forward(k) = 4;
        elseif g_Snu(k,3) <= h_2
            h_forward(k) = 3;
        elseif g_Snu(k,2) <= h_1
            h_forward(k) = 2;
        elseif g_Snu(k,1) <= h_0
            h_forward(k) = 1;
        else
            h_forward(k) = 0;
        end
        % Best condition to worst condition cascade
        if g_Snu(k,1) <= h_0
            h_backward(k) = 1;
        elseif g_Snu(k,2) <= h_1
            h_backward(k) = 2;
        elseif g_Snu(k,3) <= h_2
            h_backward(k) = 3;
        elseif g_Snu(k,4) <= h_3
            h_backward(k) = 4;
        else
            h_backward(k) = 0;
        end
    end
end
