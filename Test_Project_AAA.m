clear all
close all

%% Inizio

syms a b c l1 l2 l3;

M01 = [cos(a),-sin(a), 0, 0;
       sin(a), cos(a), 0, 0;
        0,       0,    1, l1;
        0,       0,    0, 1];


% matrice del link 2 rispetto a link 1

M12 = [cos(b),   0,  sin(b), l2*cos(b);
        0,       1,    0,    0;
      -sin(b),   0,  cos(b), -l2*sin(b);
        0,       0,    0,    1];


% matrice del link 3 rispetto a link 2

M23 = [cos(c),-sin(c), 0, l3*cos(c);
       sin(c), cos(c), 0, l3*sin(c);
        0,       0,    1, 0;
        0,       0,    0, 1];


M02 = M01*M12;
M03 = M02*M23;

M03(:,4)

X = M03(1,4);
Y = M03(2,4);
Z = M03(3,4);


Jac = [diff(X,'a'), diff(X,'b'), diff(X,'c');
       diff(Y,'a'), diff(Y,'b'), diff(Y,'c');
       diff(Z,'a'), diff(Z,'b'), diff(Z,'c');];

syms a(t) b(t) c(t);

Jacp = diff(Jac,'t');

l2 = 2; l3 = 3; a = 0.8; b =1.5; c = 3.14; 

ciccio = l2*cos(a)*cos(b) - l3*sin(a)*sin(c) + l3*cos(a)*cos(b)*cos(c);

abdel = l2*cos(a)*cos(b) + l3*cos(b)*cos(a+c);

pippo = l2*cos(a)*cos(b) + l3*cos(b)*[-sin(a)*sin(c) + cos(a)*cos(c)]; % == abdel

%% osservare det Jac = 0 per vedere dopve sono le singolarità

detJ = det(J);
factor(detJ);
