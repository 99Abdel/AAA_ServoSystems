function [xp,xpp]=tretratti_LookAhead(t,T,i,S,Vi,Vt,Vf,V,A,D,T1,T2,T3)
%
% legge di moto TreTratti (acc.costante)
%
% t tempo per cui calcolare la legge
% T tempo di azionamento
% S0 posizione iniziale
% dS ampiezza movimento
% l1 lambda1 (durata 1^ intervallo/T  0<l1<1)
% l3 lambda3 (durata 3^ intervallo/T  0<l3<1)
% 
% si assume Vini=Vfin=0


    Ta=T1+T2;

    if t<T1
       %x=1/2*A*t^2+S0;
       %xp=Vi+A*t;
       if V(i-1) < Vt
           xp = sqrt(V(i-1)^2 + 2*A*(abs(S(i)-S(i-1))));
           xpp=A;
       else
           xp = Vt;
           xpp = 0;
       end
       
    else
        
       if t<Ta
          xp=Vt;
          xpp=0;
       else
           
           if V(i-1) > Vf
               xp=sqrt(V(i-1)^2 - 2*D*(abs(S(i)-S(i-1))));
               xpp=-D;
           else
               xp = Vf;
               xpp = 0;
           end
       end
       
    end
    
end

           