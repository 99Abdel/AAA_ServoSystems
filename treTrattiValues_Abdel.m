function [v,a,tt] = treTrattiValues_Abdel(S,Vi,Vt,Vf,A,D,ta,tb,tc)

    n = length(S);
    T = ta+tb+tc;
    cost = 1;
    
    for i=1:n
        t=(i-1)*T/(n-1); % time from 0 to T with step dT
        tt(i)=t;
        
        if i ~= 1
            [v(i),a(i),cost]=tretratti_Abdel(t,T,i,S,Vi,Vt,Vf,v,A,D,ta,tb,tc,cost);
        else
            
            v(1) = Vi;
            if ta > 0
                a(1) = A;
            end
            
        end
        
    end

end

