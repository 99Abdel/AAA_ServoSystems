function [xp,xpp]=tretratti_AAA(t,T,i,S,V,Vf,Vmax,Amax,Dmax,lambda1,lambda3)
% Legge di moto TreTratti (accelerazione e decelerazione costanti)
%
% t tempo per cui calcolare la legge
% T periodo per eseguire lo spostamento
%
% S vettore contenente la traiettoria
% V vettore storico velocità
% Vi velocità inizale
% Vf velocità finale
% lambda1 coef tempo accelerazione
% lambda3 coef tempo decelerazione


    T1 = T*lambda1;
    T2 = T*(1-lambda1-lambda3);
    Ta = T1+T2;


    if t < T1   % verifico di esser nel tratto di accelerazione

        if V(i-1) <= Vmax
            xp=sqrt(V(i-1)^2 + 2*Amax*(abs(S(i)-S(i-1))));
            xpp=Amax;
          else
            xp = V(i-1);
            xpp = 0;
        end

      else

        if t <= Ta   % verifico di esser nel tratto velocità costante
            xp=V(i-1);
            xpp=0;

        else   % verifico di esser nel tratto di decelerazione

            if V(i-1) >= Vf
                xp=sqrt(V(i-1)^2 - 2*Dmax*(abs(S(i)-S(i-1))));
                xpp=-Dmax;
              else
                xp = V(i-1);
                xpp = 0;
            end
            
        end
    end

    
end

