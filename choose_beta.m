function [b] = choose_beta(b)
    
    if((b > 0 & b < pi/2) || (b > pi & b < 3/2*pi))
         b = pi+b;
    else
         b = pi-b;
    end

end

