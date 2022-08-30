function [T,lambda1,lambda3] = min_actuation_time_AAA(A,D,V,dS)

t1 = V/A; % tempo accelerazione
t3 = V/D; % tempo decelerazione 
t2 = dS/V - 1/2*V*(A+D)/(A*D); % tempo a velocità costante (se negativo non c'è il tratto).

if t2 <= 0
   t1 = sqrt(D/A * (2*dS)/(A+D));
   t2 = 0;
   t3 = sqrt(A/D * (2*dS)/(A+D));
end

T = t1+t2+t3;
lambda1 = t1/T;
lambda3 = t3/T;

end

