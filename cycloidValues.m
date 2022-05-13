function [x,v,a,tt] = cycloidValues(T,n,xi,dx)

    for i=1:n
    t=(i-1)*T/(n-1); % time from 0 to T with step dT
    tt(i)=t;
    [x(i),v(i),a(i)]=cycloidLaw(t,T,xi,dx);
    end

end
