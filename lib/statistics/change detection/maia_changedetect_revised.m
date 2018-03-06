function[h,h_closest] = maia_changedetect_revised(g_Snu)

% Threshold definitions
    h_0 = 120; % Open water
    h_1 = 90; % Open ice
    h_2 = 90; % Close ice
    h_3 = 90; % Very close ice

    g_Snu_mod(:,1) = g_Snu(:,1)./h_0;
    g_Snu_mod(:,2) = g_Snu(:,2)./h_1;
    g_Snu_mod(:,3) = g_Snu(:,3)./h_2;
    g_Snu_mod(:,4) = g_Snu(:,4)./h_3;
    
    h = zeros(length(g_Snu),4);
    h_closest = zeros(length(g_Snu),4);
    
    for k = 1:1:length(h)
        
        [Y,I] = min(g_Snu_mod(k,:));
        
        switch I
            case 4
            h_closest(k,1) = 4;
            h_closest(k,(2:4)) = [255 0 0];
            case 3
            h_closest(k,1) = 3;
            h_closest(k,(2:4)) = [237 176 33];
            case 2
            h_closest(k,1) = 2;
            h_closest(k,(2:4)) = [255 255 0];
            case 1
            h_closest(k,1) = 1;
            h_closest(k,(2:4)) = [0 0 255];
        end
        
        if g_Snu_mod(k,I) <= 1
            h(k,:) = h_closest(k,:);
        else
            h_closest(k,1) = h_closest(k,1)-0.5;
        end
    end
end