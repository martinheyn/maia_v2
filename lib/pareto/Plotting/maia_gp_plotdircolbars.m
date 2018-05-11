comp = gp_port.returnperiod15u - gp_sb.returnperiod15u;
directionesti = zeros(length(comp),1);

tempHeading = maia_from180to360(Heading_Deg(startinx:endinx));
bodyDrift = maia_addtodegrees(tempHeading,Ice_Drift_Direction_DB_deg);
directionDB = zeros(length(bodyDrift),1);
zeitvektor = datenum(Timest);

for k=1:1:length(bodyDrift)
   if bodyDrift < 340
       if bodyDrift > 200
        directionDB(k) = 1;
       end
   elseif bodyDrift > 20 
       if bodyDrift < 160
        directionDB(k) = 2;
       end
   elseif bodyDrift < 20 
        directionDB(k) = 3;
   elseif bodyDrift > 340
        directionDB(k) = 3;
   end
end
       

for k=1:1:length(comp)
   if (comp(k) > 0.02)
       if gp_port.returnperiod15u(k) > 0.01
           directionesti(k) = 1;
       else
           directionesti(k) = 0;
       end
       
   elseif (comp(k) < -0.02)
       if gp_sb.returnperiod15u(k) > 0.01
           directionesti(k) = 2;
       else
           directionesti(k) = 0;
       end
       
   else
    if gp_sb.returnperiod15u(k) > 0.01
        if gp_port.returnperiod15u(k) > 0.01
            directionesti(k) = 3;
        end
    end
   end
    
end

clear comp tempHeading k

figure
plot(zeitvektor,bodyDrift);
figure
heatmap(directionesti');