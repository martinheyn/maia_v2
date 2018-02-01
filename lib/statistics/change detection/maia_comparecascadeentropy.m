function [h_diff,percentage] = maia_comparecascadeentropy(h_casc,h_entr)

    h_diff = ones(length(h_casc),1);
    diff_count = 0;
    for k = 1:1:length(h_casc)
        if h_casc(k) == h_entr(k)
            h_diff(k) = 0;
        else
            h_diff(k) = 1;
            diff_count = diff_count + 1;
        end

    end

    percentage = diff_count / length(h_casc);

end