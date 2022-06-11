function [xp,xpp,cost]=tretratti_Abdel(t,T,i,S,Vi,Vt,Vf,V,A,D,T1,T2,T3,cost)
%
% legge di moto TreTratti (acc.costante)
%
% t tempo per cui calcolare la legge
% T tempo di azionamento
% S0 posizione iniziale
% dS ampiezza movimento
% l1 lambda1 (durata 1^ intervallo/T  0<l1<1)
% l3 lambda3 (durata 3^ intervallo/T  0<l3<1)


    Ta=T1+T2;

    if t<T1
        
        if V(i-1) < Vt
            %x=1/2*A*t^2+S0;
            xp=Vi+A*t;
            xpp=A;
            cost = i;
       else
           xp = Vt;
           xpp = 0;
        end
        
    else
        
       if t<Ta
          %x=1/2*A*T1^2+V(i)*(t-T1)+S0;
          xp=Vt;
          xpp=0;
       else
           
           if V(i-1) > Vf
               %x=1/2*A*T1^2+V*T2+V*(t-Ta)-1/2*D*(t-Ta)^2+S0;
               if V(cost) == Vt
                   xp=Vt-D*(t-Ta);
                   xpp=-D;
               else
                   xp=V(cost)-D*(t-Ta);
                   xpp=-D;
               end
           else
               xp = Vf;
               xpp = 0;
           end
           
       end
       
    end
    
end

           