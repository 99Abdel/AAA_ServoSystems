function [x,xp,xpp]=tretratti(t,T,S0,dS,lambda1,lambda3)
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
%
V=dS/T*2/(2-lambda1-lambda3);
A=dS/T^2*2/(lambda1*(2-lambda1-lambda3));
D=dS/T^2*2/(lambda3*(2-lambda1-lambda3));

T1=T*lambda1;
T2=T*(1-lambda1-lambda3);
Ta=T1+T2;
if t<T1
   x=1/2*A*t^2+S0;
   xp=A*t;
   xpp=A;
else
   if t<Ta
      x=1/2*A*T1^2+V*(t-T1)+S0;
      xp=V;
      xpp=0;
   else
      x=1/2*A*T1^2+V*T2+V*(t-Ta)-1/2*D*(t-Ta)^2+S0;
      xp=V-D*(t-Ta);
      xpp=-D;
   end
end

           