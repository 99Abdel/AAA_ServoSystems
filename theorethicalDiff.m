function [x_p,x_pp] = theorethicalDiff(x,dT)

    x_p=diff(x)/dT;
    x_pp=diff(x_p)/dT;

end

