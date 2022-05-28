function [xc,yc,r,eq_circ] = Find_Circ(A,B,C)
% Ritorna centro e raggio della circonferenza dati 3 punti

    syms a b c;
    
    eq1 = A(1)^2+A(2)^2+a*A(1)+b*A(2)+c == 0;
    eq2 = B(1)^2+B(2)^2+a*B(1)+b*B(2)+c == 0;
    eq3 = C(1)^2+C(2)^2+a*C(1)+b*C(2)+c == 0;

    eqns = [eq1, eq2, eq3];

    angles = solve(eqns,[a b c]);

    syms x y;

    eq_circ = x^2+y^2+angles.a*x+angles.b*y+angles.c == 0;

    xc = -angles.a/2;
    yc = -angles.b/2;
    r = sqrt(xc^2+yc^2-angles.c);

end