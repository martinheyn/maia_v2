function[g_Snu,h] = maia_cascadedetection_tuned_R2(data,S_vec,nu_vec,windowsize)
 
    g_Snu = zeros(length(data),4);
    com_fac = zeros(length(data),4);
    h = zeros(length(data),1);
    
    % Settings
    %REV 2
    S_0 = [1.5e-4,1e-8;1e-8,2.8e-4];
    %     S_0 = [1.5e-4,1e-8;1e-8,2.8e-4];
    nu_0 = 20; 
    %h_0 = 120;
    S_1 = [0.8e-3,6.3e-5;6.3e-5,0.8e-3];
    %     S_1 = [1.1e-3,6.3e-5;6.3e-5,1.1e-3];
    nu_1 = 9.5;
    %nu_1 = 10;
    %h_1 = 90;
    %S_2 = [3.4e-3,1.6e-5;1.6e-5,2.8e-3];
    S_2 = [4.5e-3,6e-4;6e-4,4.5e-3];
    %nu_2 = 9.3; 
    nu_2 = 8;
    %h_2 = 90;
    %S_3 = [1.0e-2,2.0e-3;2.0e-3,1.2e-2];
         S_3 = [1.5e-2,2e-3;2e-3,3e-2];
    nu_3 = 2.8;
    %h_3 = 90;
    %REV 1
%     S_0 = [1.5e-4,4.7e-6;4.7e-6,2.8e-4];
%     nu_0 = 20; 
%     h_0 = 120;
%     S_1 = [1.1e-3,6.3e-5;6.3e-5,1.1e-3];
%     nu_1 = 9.5; 
%     h_1 = 90;
%     S_2 = [3.4e-3,1.6e-5;1.6e-5,2.8e-3];
%     nu_2 = 9.3; 
%     h_2 = 90;
%     S_3 = [0.7e-2,2.0e-3;2.0e-3,1.2e-2];
%     nu_3 = 2.8;
%     h_3 = 90;
    %REV 0
%     S_0 = [1.5e-4,1e-8;1e-8,2.8e-4];
%     nu_0 = 20; 
%     %h_0 = 120;
%     S_1 = [1.1e-3,6.3e-5;6.3e-5,1.1e-3];
%     nu_1 = 10; 
%     %h_1 = 90;
%     S_2 = [5e-3,1.6e-4;1.6e-4,5e-3];
%     nu_2 = 8; 
%     %h_2 = 90;
%     S_3 = [1.5e-2,2e-3;2e-3,3e-2];
%     nu_3 = 2.8;
%     %h_3 = 90;
    
%     
%     S_0 = [2e-4,1e-8;1e-8,6e-4];
%     S_0 = [1.6e-4,1e-8;1e-8,2.8e-4];
%     nu_0 = 20; 
%     h_0 = 120;

    [g_Snu(:,1)] = maia_detectchangeintbi_parainject_R2(data,S_0,nu_0,S_vec,nu_vec,windowsize);
    [g_Snu(:,2)] = maia_detectchangeintbi_parainject_R2(data,S_1,nu_1,S_vec,nu_vec,windowsize);
    [g_Snu(:,3)] = maia_detectchangeintbi_parainject_R2(data,S_2,nu_2,S_vec,nu_vec,windowsize);
    [g_Snu(:,4)] = maia_detectchangeintbi_parainject_R2(data,S_3,nu_3,S_vec,nu_vec,windowsize);
    
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
        
            [~,h(k)] = min(g_Snu(k,:));

    end
    
end