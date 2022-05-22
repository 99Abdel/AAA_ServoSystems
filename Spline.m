function [x,xp,xpp,tetapp] = Spline(t,teta)
% ALTERNATIVE SPLINE ALGORITHM:
% t = 1:7;
% x = [0.6,0.45,0.42,0.55,0.42,0.45,0.6];

numero_nodi = length(teta);

% Matrice A:
V = zeros(numero_nodi,numero_nodi);

V(1,1) = 1/3*(t(2)-t(1));
V(1,2) = 1/6*(t(2)-t(1));

for i = 2:numero_nodi-1
    for j = 1:numero_nodi
         if j == i-1
           V(i,j) = 1/6*(t(j+1)-t(j));
        end
        if j == i
            V(i,j) = 1/3*(t(j+1)-t(j-1));
        end
        if j == i+1
            V(i,j) = 1/6*(t(j)-t(j-1));
        end
    end
end

V(numero_nodi,numero_nodi-1) = V(numero_nodi-1,numero_nodi);
V(numero_nodi,numero_nodi) = 1/3*(t(numero_nodi)-t(numero_nodi-1));

% Matrice b;
b = zeros(7,1);

b(1) = (teta(2)-teta(1))/(t(2)-t(1));
for i = 2:(numero_nodi-1)
    b(i) = (teta(i+1)-teta(i))/(t(i+1)-t(i))-(teta(i)-teta(i-1))/(t(i)-t(i-1));
end
b(numero_nodi) = -(teta(numero_nodi)-teta(numero_nodi-1))/(t(numero_nodi)-t(numero_nodi-1));

% Accelerazioni:
tetapp = V\b;

% Generazione delle Spline:
syms T;
x = [];
xp = [];
xpp = [];

for i = 1:(numero_nodi-1)
    tempo = t(i):0.01:t(1+i)-0.01;
    A = (t(i+1)-T)/(t(i+1)-t(i));
    B = 1-A;
    C = 1/6*(A^3-A)*(t(i+1)-t(i))^2;
    D = 1/6*(B^3-B)*(t(i+1)-t(i))^2;
    s = A*teta(i)+B*teta(i+1)+C*tetapp(i)+D*tetapp(i+1);
    s = matlabFunction(s);
    sp = -teta(i)+teta(i+1)+1/6*(1-3*A^2)*(t(i+1)-t(i))^2*tetapp(i)+1/6*(3*(1-A)^2-1)*(t(i+1)-t(i))^2*tetapp(i+1);
    sp = matlabFunction(sp);
    spp = A*(t(i+1)-t(i))^2*tetapp(i)+(1-A)*(t(i+1)-t(i))^2*tetapp(i+1);
    spp = matlabFunction(spp);
    x = [x s(tempo)];
    xp = [xp sp(tempo)];
    xpp = [xpp spp(tempo)];
end
end