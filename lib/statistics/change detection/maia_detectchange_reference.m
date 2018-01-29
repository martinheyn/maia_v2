function[g_Snu] = maia_detectchange_reference(data,S_vec,nu_vec,windowsize)
 
    % Settings
    %S_0 = [1.6e-4,4.7e-6;4.7e-6,2.8e-4];
    %nu_0 = 20; 
%     S_0 = [1.1e-3,6.4e-5;6.4e-5,1.1e-3];
%     nu_0 = 10; 
%     S_0 = [3.4e-3,1.6e-5;1.6e-5,2.8e-3];
%     nu_0 = 8;     
    S_0 = [7.5e-3,-2e-3;-2e-3,1.2e-2];
    nu_0 = 3;     


    g_Snu = maia_detectchangeintbi_parainject(data,S_0,nu_0,S_vec,nu_vec,windowsize);
    
end