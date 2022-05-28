function [xc,yc,r] = Find_Circ(A,B,C)
% Ritorna centro e raggio della circonferenza dati 3 punti

    syms alpha beta gamma;

    eq1 = A(1)^2+A(2)^2+alpha*A(1)+beta*A(2)+gamma == 0;
    eq2 = B(1)^2+B(2)^2+alpha*B(1)+beta*B(2)+gamma == 0;
    eq3 = C(1)^2+C(2)^2+alpha*C(1)+beta*C(2)+gamma == 0;

    eqns = [eq1, eq2, eq3];

    angles = solve(eqns,[alpha beta gamma]);

    syms x y;

    eq_circ = x^2+y^2+angles.aplha*x+angles.beta*y+angles.gamma == 0;

    xc = -angles.aplha;
    yc = -angles.beta;
    r = sqrt(angles.alpha^2+angles.beta^2-angles.gamma);


end