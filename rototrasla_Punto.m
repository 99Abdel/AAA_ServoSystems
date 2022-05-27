function [S] = rototrasla_Punto(S,alpha,T)
% Crea un piano inclinato di alpha rispetto al piano x y, e con origine in T (x,y,z)
    
    S = [S;1];
    t1 = T(1);  t2 = T(2);   t3 = T(3);

     M01 = [cos(alpha),   0,  sin(alpha),  t1;
            0,       1,    0,        t2;
           -sin(alpha),  0,  cos(alpha),  t3;
            0,       0,    0,         1];

     S = M01*S;

end

