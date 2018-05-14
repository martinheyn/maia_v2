startinx = 1;
endinx = length(Heading_Deg);

comp = gp_port.returnlevel15u - gp_sb.returnlevel15u;
directionesti = zeros(length(comp),1);

tempHeading = maia_from180to360(Heading_Deg(startinx:endinx));
bodyDrift = maia_addtodegrees(tempHeading,Ice_Drift_Direction_DB_deg);
directionDB = zeros(length(bodyDrift),1);
zeitvektor = datenum(Timest);

for k=1:1:length(bodyDrift)
   if bodyDrift < 340
       if bodyDrift > 200
        directionDB(k) = 1; % PORT
       end
   elseif bodyDrift > 20 
       if bodyDrift < 160
        directionDB(k) = 2; % STARBOARD
       end
   elseif bodyDrift < 20 
        directionDB(k) = 3;
   elseif bodyDrift > 340
        directionDB(k) = 3; % AHEAD
   end
end
       

for k=1:1:length(comp)
   if (comp(k) > 0.02) % Port side dominates
       if gp_port.returnlevel15u(k) > 0.01 % Port side is significant enough
           directionesti(k) = 1; % PORT
       else
           directionesti(k) = 0; % NOT PORT
       end
       
   elseif (comp(k) < -0.02) % Starboard side dominates
       if gp_sb.returnlevel15u(k) > 0.01 % Starboard side is significant enough
           directionesti(k) = 2; % STARBOARD
       else
           directionesti(k) = 0; % NOT STARBOARD
       end
       
   else
    if gp_sb.returnlevel15u(k) > 0.01 % Starboard side is significant enough
        if gp_port.returnlevel15u(k) > 0.01 % AND Port side is significant enough
            directionesti(k) = 3; % BOTH SIDES AFFECTED => AHEAD ATTACK
        end
    end
   end
    
end

clear comp tempHeading k

% figure
% plot(zeitvektor,bodyDrift);
% figure
% heatmap(directionesti');