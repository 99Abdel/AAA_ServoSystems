function [x,xp,xpp,cost]=tretratti_AAA(t,T,i,S,Vi,Vt,Vf,V,A,D,T1,T2,T3,cost)
% legge di moto TreTratti (acc.costante)
%
% t tempo per cui calcolare la legge
% T tempo di azionamento
% S0 posizione iniziale
% dS ampiezza movimento
% l1 lambda1 (durata 1^ intervallo/T  0<l1<1)
% l3 lambda3 (durata 3^ intervallo/T  0<l3<1)


    Ta = T1+T2;

    if t < T1
    % tratto accelerazione:
%        if V(i-1) < Vt
            x = 1/2*A*t^2+Vi*t+S(1);
            xp = Vi+A*t;
            xpp = A;
            cost = i;
%         else
%            x=1/2*A*t^2+Vt*(t-T1)+S(1);
%            xp = Vt;
%            xpp = 0;
%         end
        
    else

       % tratto v cost:
       if t < Ta
          x = (S(1)+Vi*T1+1/2*A*T1^2)+Vt*(t-T1);
          xp = Vt;
          xpp = 0;
       else
           
           % tratto decelerazione
%            if V(i-1) > Vf
               if T2 ~= 0     % se presente tratto a v cost
                   x = (S(1)+Vi*T1+1/2*A*T1^2+Vt*T2)+Vt*(t-Ta)-1/2*D*(t-Ta)^2;
                   xp = Vt-D*(t-Ta);
                   xpp = -D;
               else     % se non presente tratto a v cost
                   x = (S(1)+Vi*T1+1/2*A*T1^2)+V(cost)*(t-Ta)-1/2*D*(t-Ta)^2;
                   xp = V(cost)-D*(t-Ta);
                   xpp = -D;
               end
%            else
%                x=1/2*A*T1^2+V(cost)*T2+V(cost)*(t-Ta)-1/2*D*(t-Ta)^2+S(1);
%                xp = Vf;
%                xpp = 0;
%            end
           
       end
       
    end
    
end

