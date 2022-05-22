function [x,xp,xpp] = PredictiveCircularLaw(t,T,S0,dS)
% legge di moto Cicloidal (acc.costante)
% t tempo per cui calcolare la legge
% T tempo di azionamento
% S0 posizione iniziale
% dS ampiezza movimento
    
    

    A = dS*2*pi/T^2;
    V = A*T/(2*pi);
    U = S0;

    xpp = A*sin((2*pi*t)/T);
    xp = -A*(T/(2*pi))*cos((2*pi*t)/T) + V;
    x = -A*((T/(2*pi))^2)*sin((2*pi*t)/T) + A*(T/(2*pi))*t + U;

end

           