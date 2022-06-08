clc
clear all
close all

% look ahead è una generalizzazione della 3 tratti, prendere il percorso e
% rappresentarlo a tratti per ogni tratto mettere velocità maxima da
% raggiungere stesso ragionamento alla fine, andamaneto velotaà in funzione
% della distanza da trasformare in velocità in funzione del tempo
% generalizzare la tre tratti in modo da partire da velocità v1 e finire a
% velocità v2  non per forza uguali a zero.

n = 5;
L = [1.5, 3, 4, 1, 2];
Vt = [1, 1.5, 0.5, 2, 3];
Vn = [0, 1.1, 1, 2, 2.5, 0.5];
A = 1; D = 2;

Vn_f1 = zeros(1,n+1);
Vn_f23 = zeros(1,n+1);
Vnf_f2 = zeros(1,n);
Vni_f3 = zeros(1,n);

V_ast = zeros(1,n);

ta = zeros(1,n);
tb = zeros(1,n);
tc = zeros(1,n);

sa = zeros(1,n);
sb = zeros(1,n);
sc = zeros(1,n);

s_tot = zeros(1,n);
t_tot = zeros(1,n);

l = zeros(1,n);
t = zeros(1,n);

%% Look Ahead fasi Set Velocità nodi

% Fase 1
vel = min(Vn(1),Vt(1));
Vn_f1(1) = min(vel);

for i = 2:n
    
    vel = [Vn(i),Vt(i-1),Vt(i)];
    Vn_f1(i) = min(vel);
 
end

vel = min(Vn(n+1),Vt(n));
Vn_f1(n+1) = min(vel);


% Fase 2
for i = 1:n
    
    Vnf = sqrt(Vn(i)^2 + 2*A*L(i));
    vel = [Vn_f1(i+1),Vnf];
    Vn_f23(i+1) = min(vel);
    
end

a = 0;

% Fase 3
for i = n:-1:1
    
    Vni = sqrt(Vn(i+1)^2 + 2*D*L(i));
    vel = [Vn_f1(i),Vni];
    Vn_f23(i) = min(vel);
    
end


%% Look Ahead fase Calcolo Tempi

for i = 1:n
    
    ta(i) = (Vt(i)-Vn_f23(i))/A;
    tc(i) = (Vt(i)-Vn_f23(i+1))/D;
    
    sa(i) = (Vt(i)+Vn_f23(i))*ta(i)/2;
    sc(i) = (Vn_f23(i+1)+Vt(i))*tc(i)/2;
    sb(i) = L(i) - sa(i) - sc(i);
    
    tb(i) = sb(i)/Vt(i);
    
    if(tb(i) < 0)
       
        V_ast(i) = sqrt((Vn_f23(i)^2*D + Vn_f23(i+1)^2*A + 2*A*D*L(i))/(A+D)); 
        
        ta(i) = (V_ast(i)-Vn_f23(i))/A;
        tb(i) = 0;
        tc(i) = (V_ast(i)-Vn_f23(i+1))/D;
        
        sa(i) = (V_ast(i)+Vn_f23(i))*ta(i)/2;
        sb(i) = 0;
        sc(i) = (V_ast(i)+Vn_f23(i+1))*tc(i)/2;
        
    end
    
    l(i) = sa(i) + sb(i) + sc(i);
    t(i) = ta(i) + tb(i) + tc(i);
 
    if i == 1
       s_tot(i) = l(i);
       t_tot(i) = t(i);
    else
        s_tot(i) = s_tot(i-1) + l(i);
        t_tot(i) = t_tot(i-1) + t(i);
    end
    
end

%% tempi

s = [0 s_tot];

S = [];
Sp = [];
Spp = [];

Y = [];
Yp = [];
Ypp = [];

TT = [];
N = 50;

for i = 1:n
   
    % velocità in funzione del tempo
    T_tratto = ta(i)+tb(i)+tc(i); %periodo della tretratti
    [x,xp,xpp,tt] = treTrattiValues_Abdel(T_tratto,N,s(i),L(i),Vn_f23(i),A,D,ta(i),tb(i),tc(i));
    
    % velocità in funzione dello spazio
    ss = linspace(s(i),s(i+1),N);%spazio percorso nella tretratti
    [yp,ypp] = treTrattiValues_LookAhead(T_tratto,ss,Vn_f23(i),Vn_f23(i+1),A,D,ta(i),tb(i),tc(i));
    
    % vettori di spostamento velocità  e acc totali nei 5 tratti in
    % funzione del tempo
    S = [S x];
    Sp = [Sp xp];
    Spp = [Spp xpp];
    
    % vettori di spostamento velocità  e acc totali nei 5 tratti in
    % funzione dello spostamento
    Y = [Y ss];
    Yp = [Yp yp];
    Ypp = [Ypp ypp];
    
    if i == 1
        TT = [TT tt];
    else
        TT = [TT TT(end)+tt];
    end
    
end

figure
treTrattiPlot(TT,S,Sp,Spp,"Cartesiano")

figure
treTrattiPlot(TT,Y,Yp,Ypp,"Cartesiano")
