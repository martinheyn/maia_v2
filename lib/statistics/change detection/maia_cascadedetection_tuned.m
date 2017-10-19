function[g_Snu,h] = maia_cascadedetection_tuned(data,S_vec,nu_vec,windowsize)
 
    g_Snu = zeros(length(data),4);
    h = zeros(length(data),1);
    
    % Settings
    
    S_3 = [5e-4,-1.5e-4;-1.5e-4,5.0e-4];
    nu_3 = 2;
    S_2 = [1.4e-4,-0.8e-4;-0.8e-4,0.9e-4];
    nu_2 = 8;
    S_1 = [3.1e-5,-1.1e-5;-1.1e-5,1.4e-5];
    nu_1 = 12;
    S_0 = [5e-6,-2.4e-6;-2.4e-6,2.3e-6];
    nu_0 = 20;
    
    
    g_Snu(:,1) = maia_detectchangeintbi_parainject(data,S_0,nu_0,S_vec,nu_vec,windowsize);
    g_Snu(:,2) = maia_detectchangeintbi_parainject(data,S_1,nu_1,S_vec,nu_vec,windowsize);
    g_Snu(:,3) = maia_detectchangeintbi_parainject(data,S_2,nu_2,S_vec,nu_vec,windowsize);
    g_Snu(:,4) = maia_detectchangeintbi_parainject(data,S_3,nu_3,S_vec,nu_vec,windowsize);
    
end