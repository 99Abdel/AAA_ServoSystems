function [x,v,a,tt] = treTrattiValues_Abdel(T,n,xi,dx,Vi,A,D,ta,tb,tc)

    
    for i=1:n
        t=(i-1)*T/(n-1); % time from 0 to T with step dT
        tt(i)=t;
        [x(i),v(i),a(i)]=tretratti_Abdel(t,T,xi,dx,Vi,A,D,ta,tb,tc);
    end

end

