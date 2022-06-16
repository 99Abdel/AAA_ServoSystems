function [v,a,tt] = treTrattiValues_AAA_old(T,S,Vi,Vf,Vmax,Amax,Dmax,lambda1,lambda3)

    n = length(S);
    v = zeros(1,n);
    
    v(1) = Vi;
    
    for i = 2:n
        
        t = (i-1)*T/(n-1);    % time from 0 to T with step dT
        tt(i) = t;
        [v(i),a(i)] = tretratti_AAA_old(t,T,i,S,v,Vf,Vmax,Amax,Dmax,lambda1,lambda3);
        
    end

end

