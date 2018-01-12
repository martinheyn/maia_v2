function [data_rotated] = maia_rotatetoNED(data_body,heading)

    data_rotated = zeros(size(data_body));
    
    for i=1:1:length(data_body)
        data_rotated(i,1) = cosd(heading(i))*data_body(i,1) - sind(heading(i))*data_body(i,1);
        data_rotated(i,2) = sind(heading(i))*data_body(i,2) + cosd(heading(i))*data_body(i,2);
    end
end