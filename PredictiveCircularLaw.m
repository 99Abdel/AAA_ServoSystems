function [x,xp,xpp] = PredictiveCircularLaw(t,T,S0,S1)
% legge di moto Cicloidal (acc.costante)
% t tempo per cui calcolare la legge
% T tempo di azionamento
% S0 posizione iniziale
% S1 posizione finale
   

    dS = S1-S0;
    
    for i = 1:dS(1,end)

        y_up = dS(2)/2+sqrt(r^2-(dS(i)-dS(1)/2)^2)
        y_down = dS(2)/2-sqrt(r^2-(dS(i)-dS(1)/2)^2)

        Y_up = [Y_up y_up];
        Y_down = [Y_down y_down];

    end
    
    Y_down = flip(Y_down);
    Y_tot = [Y_up Y_down];

    X_tot = dS(1,:);


    A = dS*2*pi/T^2;
    V = A*T/(2*pi);
    U = S0;

    xpp = A*sin((2*pi*t)/T);
    xp = -A*(T/(2*pi))*cos((2*pi*t)/T) + V;
    x = -A*((T/(2*pi))^2)*sin((2*pi*t)/T) + A*(T/(2*pi))*t + U;

    
end

           