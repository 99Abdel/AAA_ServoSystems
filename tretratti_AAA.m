function [xp,xpp]=tretratti_AAA(t,T,i,S,V,Vf,Vmax,Amax,Dmax,lambda1,lambda3)
%
% legge di moto TreTratti (acc.costante)
%
% t tempo per cui calcolare la legge
%
% si assume Vini=Vfin=0

    T1=T*lambda1;
    T2=T*(1-lambda1-lambda3);
    Ta=T1+T2;

    if t<T1
        if V(i-1) <= Vmax
            xp=sqrt(V(i-1)^2 + 2*Amax*(abs(S(i)-S(i-1))));
            xpp=Amax;
        else
            xp = V(i-1);
            xpp = 0;
        end
    else
        if t<=Ta
            xp=V(i-1);
            xpp=0;
        else
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

