function [x,v,a,tt] = PredictiveCircularValues(T,n,S0,S1)
% Ritorna valori legge Predictive Circular

    for i=1:n

        t = (i-1)*T/(n-1);      % time from 0 to T with step dT
        tt(i) = t;
        [x(i),v(i),a(i)] = PredictiveCircularLaw(t,T,S0,S1);
    
    end

    
end
