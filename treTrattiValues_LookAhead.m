function [v,a,tt] = treTrattiValues_LookAhead(T,S,Vi,Vf,A,D,ta,tb,tc)

    n = length(S);
    v = zeros(1,n);
    
    v(1) = Vi;
    
    for i=2:n
        t=(i-1)*T/(n-1); % time from 0 to T with step dT
        tt(i)=t;
        [v(i),a(i)]=tretratti_LookAhead(t,T,i,S,v,Vf,A,D,ta,tb,tc);
    end

end

