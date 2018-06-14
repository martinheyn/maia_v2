function [roll,pitch] = maia_attitudepreprocess(x,y,z,windowsize)

    roll = zeros(length(x),1);
    pitch = zeros(length(y),1);
    
    for k = windowsize+1:1:length(roll)
        roll(k-windowsize:k) = atand(mean(y(k-windowsize:k))./mean(z(k-windowsize:k)));
        pitch(k-windowsize:k) = atand(mean(x(k-windowsize:k))./sqrt((mean(y(k-windowsize:k)))^2+((mean(z(k-windowsize:k))^2))));
    end

end
