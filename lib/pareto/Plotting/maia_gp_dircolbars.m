tempdate = datenum(Timest);

startinx = find(tempdate>=timevect(1),1);
endinx = find(tempdate<=timevect(end),1,'last');

comp = gp_port.exceedlevel50 - gp_sb.exceedlevel50;
compentropy = gp_port.entropy - gp_sb.entropy;
directionesti = zeros(length(comp),1);
directionestientropy = zeros(length(comp),1);

tempHeading = maia_from180to360(Heading_Deg(startinx:endinx));
bodyDrift = maia_subdegrees(Ice_Drift_Direction_DB_deg(startinx:endinx),tempHeading);
bodyDrift2 = maia_subdegrees(Ice_Drift_Direction_IPS_deg(startinx:endinx),tempHeading);
directionDB = zeros(length(bodyDrift),1);
zeitvektor = tempdate(startinx:endinx);

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
       
% comp = gp_port.returnlevel15u - gp_sb.returnlevel15u;
% for k=1:1:length(comp)
%    if (comp(k) > 0.06) % Port side dominates
%        if gp_port.returnlevel15u(k) > 0.06 % Port side is significant enough
%            directionesti(k) = 1; % PORT
%        else
%            directionesti(k) = 0; % NOT PORT
%        end
%        
%    elseif (comp(k) < -0.06) % Starboard side dominates
%        if gp_sb.returnlevel15u(k) > 0.06 % Starboard side is significant enough
%            directionesti(k) = 2; % STARBOARD
%        else
%            directionesti(k) = 0; % NOT STARBOARD
%        end
%        
%    else
%     if gp_sb.returnlevel15u(k) > 0.06 % Starboard side is significant enough
%         if gp_port.returnlevel15u(k) > 0.06 % AND Port side is significant enough
%             directionesti(k) = 3; % BOTH SIDES AFFECTED => AHEAD ATTACK
%         end
%     end
%    end
%     
% end
for k=1:1:length(comp)
   if (comp(k) > 0.0015) % Port side dominates
       if gp_port.exceedlevel50(k) > 0.01 % Port side is significant enough
           directionesti(k) = 1; % PORT
       else
           directionesti(k) = 0; % NOT PORT
       end
       
   elseif (comp(k) < -0.0015) % Starboard side dominates
       if gp_sb.exceedlevel50(k) >  0.01% Starboard side is significant enough
           directionesti(k) = 2; % STARBOARD
       else
           directionesti(k) = 0; % NOT STARBOARD
       end
       
   else
    if gp_sb.exceedlevel50(k) > 0.01 % Starboard side is significant enough
        if gp_port.exceedlevel50(k) > 0.01 % AND Port side is significant enough
            directionesti(k) = 3; % BOTH SIDES AFFECTED => AHEAD ATTACK
        end
    end
   end
    
end

for k=1:1:length(compentropy)
   if (compentropy(k) > 0.20) % Port side dominates
           directionestientropy(k) = 1; % PORT
       
   elseif (compentropy(k) < -0.20) % Starboard side dominates
           directionestientropy(k) = 2; % STARBOARD
   
   else
    if gp_sb.entropy(k) > -4.5 % Starboard side is significant enough
        if gp_port.entropy(k) > -4.5 % AND Port side is significant enough
            directionestientropy(k) = 3; % BOTH SIDES AFFECTED => AHEAD ATTACK
        end
    end
   end
    
end

clear comp tempHeading k

% figure
% plot(zeitvektor,bodyDrift);
% figure
% heatmap(directionesti');