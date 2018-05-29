function [outang] = maia_subdegrees(in1,in2)

    outang = zeros(length(in1),1);
    
    outang_t = in1 - in2;
    
    for l = 1:1:length(in1)
       if outang_t(l) <  0
           outang(l) = 360 + outang_t(l);
       elseif outang_t(l) > 360
           outang(l) = outang_t(l) - 360;
       else
           outang(l) = outang_t(l);
       end
    end

end