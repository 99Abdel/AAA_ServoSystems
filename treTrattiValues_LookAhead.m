function [v,a,tt] = treTrattiValues_LookAhead(S,Vi,Vt,Vf,A,D,ta,tb,tc)

    n = length(S);
    T = ta+tb+tc;
    
    for i=1:n
        t=(i-1)*T/(n-1); % time from 0 to T with step dT
        tt(i)=t;
        
        if i ~= 1
            [v(i),a(i)]=tretratti_LookAhead(t,T,i,S,Vi,Vt,Vf,v,A,D,ta,tb,tc);
        else
            
            v(1) = Vi;
            if ta > 0
                a(1) = A;
            end
            
        end
        
    end

end

