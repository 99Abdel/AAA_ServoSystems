function [x,v,a,tt] = treTrattiValues(T,n,xi,dx,lambda1,lambda3)

    for i=1:n
    t=(i-1)*T/(n-1); % time from 0 to T with step dT
    tt(i)=t;
    [x(i),v(i),a(i)]=tretratti(t,T,xi,dx,lambda1,lambda3);
    end

end

