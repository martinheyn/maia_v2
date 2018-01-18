function [ang360vec] = maia_from180to360(ang180vec)

    ang360vec = zeros(length(ang180vec),1);
    for l = 1:1:length(ang180vec)
       if ang180vec(l) <  0
           ang360vec(l) = 360 + ang180vec(l);
       else
           ang360vec(l) = ang180vec(l);
       end
    end

end