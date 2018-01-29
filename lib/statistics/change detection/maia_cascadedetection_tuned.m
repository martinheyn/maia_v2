function[g_Snu,h] = maia_cascadedetection_tuned(data,S_vec,nu_vec,windowsize)
 
    g_Snu = zeros(length(data),4);
    h = zeros(length(data),4);
    
    % Settings
%     S_0 = [2e-4,1e-8;1e-8,6e-4];
    S_0 = [1e-4,1e-8;1e-8,3e-4];
    nu_0 = 15; 
    h_0 = 120;
%    S_1 = [2e-3,6.4e-5;6.4e-5,2e-3];
    S_1 = [2e-3,6.4e-5;6.4e-5,3e-3];
    nu_1 = 10; 
    h_1 = 90;
    S_2 = [6e-3,1.6e-5;1.6e-5,8e-3];
    nu_2 = 8; 
    h_2 = 90;
    S_3 = [1.5e-2,2e-3;2e-3,3e-2];
    nu_3 = 4;
    h_3 = 90;
%     S_0 = [0.8e-4,0;0,0.8e-4];
%     nu_0 = 20; 
%     h_0 = 100;
%     S_1 = [2.5e-4,5e-5;5e-5,2e-4];
%     nu_1 = 12; 
%     h_1 = 90;
%     S_2 = [2e-3,4e-4;4e-4,1.5e-3];
%     nu_2 = 8; 
%     h_2 = 90;
%     S_3 = [1e-2,2e-3;2e-3,1e-2];
%     nu_3 = 3;
%     h_3 = 60;
%     S_3 = [1e-3,-1.5e-4;-1.5e-4,1e-3];
%     nu_3 = 2;
%     h_3 = 150;
%     S_2 = [2e-4,-0.4e-4;-0.4e-4,0.9e-4];
%     nu_2 = 10;
%     h_2 = 100;
%     S_1 = [3.1e-5,-0.2e-5;0.2e-5,1.4e-5];
%     nu_1 = 12;
%     h_1 = 100;
%     S_0 = [5e-6,-2.4e-6;-2.4e-6,2.3e-6];
%     nu_0 = 20;
%     h_0 = 150;
    
%         S_3 = [1e-3,-1.5e-4;-1.5e-4,1e-3];
%     nu_3 = 2;
%     S_2 = [1.4e-4,-0.8e-4;-0.8e-4,0.9e-4];
%     nu_2 = 8;
%     S_1 = [3.1e-5,-1.1e-5;-1.1e-5,1.4e-5];
%     nu_1 = 12;
%     S_0 = [5e-6,-2.4e-6;-2.4e-6,2.3e-6];
%     nu_0 = 20;

    g_Snu(:,1) = maia_detectchangeintbi_parainject(data,S_0,nu_0,S_vec,nu_vec,windowsize);
    g_Snu(:,2) = maia_detectchangeintbi_parainject(data,S_1,nu_1,S_vec,nu_vec,windowsize);
    g_Snu(:,3) = maia_detectchangeintbi_parainject(data,S_2,nu_2,S_vec,nu_vec,windowsize);
    g_Snu(:,4) = maia_detectchangeintbi_parainject(data,S_3,nu_3,S_vec,nu_vec,windowsize);
    
    for k = 1:1:length(h)
          
      for m = 1:1:4               
            g_Snu(k,m) = abs(g_Snu(k,m));
      end
%         if g_Snu(k,1) < 0 % ??? WHY
%             g_Snu(k,1) = 0;
%         end
%         for m = 2:1:4
%             if g_Snu(k,m) < 0
%                 g_Snu(k,m) = abs(g_Snu(k,m));
%             end
%         end
        
        if g_Snu(k,4) <= h_3
            h(k,1) = 4;
            h(k,(2:4)) = [255 0 0];
        elseif g_Snu(k,3) <= h_2
            h(k,1) = 3;
            h(k,(2:4)) = [237 176 33];
        elseif g_Snu(k,2) <= h_1
            h(k,1) = 2;
            h(k,(2:4)) = [255 255 0];
        elseif g_Snu(k,1) <= h_0
            h(k,1) = 1;
            h(k,(2:4)) = [0 0 255];
        else
            h(k,1) = 0;
            h(k,(2:4)) = [255 255 255];
        end
    end
    
end