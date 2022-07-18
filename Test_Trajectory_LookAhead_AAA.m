clc
clear all
close all


% Test traiettoria numero 3
l1 = 12; l2 = 7; l3 = 4;
% dati
L = [l1, l2, l3];

A = [1,-2];
B = [2,-1];
C = [1,0];

D = C;
E = [2,1];
F = [1,2];

[xc1,yc1,r1] = Find_Circ(A,B,C);
[xc2,yc2,r2] = Find_Circ(D,E,F);

xc1 = double(xc1);  xc2 = double(xc2);
yc1 = double(yc1);  yc2 = double(yc2);
r1 = double(r1);    r2 = double(r2);

N = 500;

th1 = linspace(-pi/2-pi/6,pi/2,N);
th2 = linspace(-pi/2,pi/2+pi/6,N);
th_tot = [th1, th2];

l1 = (0-(-pi/6-pi))*r2;
l2 = (pi/6-(-pi))*r1;

L_t = [l1,l2];

x1 = r1*cos(th1) + xc1;
x2 = r2*cos(th2) + xc2;
x_tot = [x1 x2];

y1 = r1*sin(th1) + yc1;
y2 = r2*sin(th2) + yc2;
y_tot = [y1 y2];

z_tot = zeros(1,2*N);

S = [x_tot;y_tot;z_tot];
S1 = [];

alpha = -pi/4;
Tt = [5,0,12];
Ttva = [0,0,0];

for i = 1:2*N
    
    ss(i) = sqrt(S(1,i)^2 + S(2,i)^2 + S(3,i)^2);
    
end

% figure 
% hold on
% plot(x_tot,y_tot,"-","LineWidth",2)
% axis equal
% pbaspect([20 20 20])
% grid on
% hold off

% dati cinematici robot
n = 2;
A = 2; D = 2; L_t = L_t;

Vmax = 1; Vi = 0; Vf = 0;
Vt = [Vmax, Vmax];
Vn = [Vi, 0, Vf];


[s,sp,spp,tt] = LookAhead_AAA(n,N,L_t,ss,Vt,Vn,A,D);
T = tt(end) - tt(1);
dT = tt(2) - tt(1);
Plot_Single_Graph_Dir_Kinematics_AAA(s,sp,spp,tt,dT);


%% vecchio


x = s.*cos(th_tot);
y = s.*sin(th_tot);
z = s*0;
P = [x;y;z];

% calcoli valori per singoli assi
% velocità ------------GIUSTI

vx = -sp.*sin(th_tot);
vy = sp.*cos(th_tot);
vz = sp.*0;
Sp = [vx;vy;vz];
Sp1 = [];

% accelerazione ------------GIUSTI
sppc = -(sp.^2)./r1;
spp_tot = sqrt((spp.^2) + (sppc.^2));
atx = -spp.*sin(th_tot);    acx = sppc.*cos(th_tot);
aty = spp.*cos(th_tot);    acy = sppc.*sin(th_tot);
ax = atx + acx;
ay = aty + acy;
az = spp.*0;
Spp = [ax;ay;az];
Spp1 = [];

% Plot_Single_Graph_Dir_Kinematics_AAA(s,sp,spp,tt)
% Plot_Graphs_Dir_Kinematics_noDebug_AAA(S,Sp,Spp,tt)

dt = zeros(1,2*N);
DS = [];

for i=1:N-1
    
    ds = norm(S(:,i+1)-S(:,i));
    DS = [DS ds];
   if (sp(i) == Vmax || spp(i) == 0)
        dt(i)=ds/sp(i);
    else
        dt(i) = abs((sp(i+1)-sp(i))/spp(i));
    end
    
end

for i=N+1:2*N-1
    
    ds = norm(S(:,i+1)-S(:,i));
    DS = [DS ds];
    if (sp(i) == Vmax || spp(i) == 0)
        dt(i)=ds/sp(i);
    else
        dt(i) = abs((sp(i+1)-sp(i))/spp(i));
    end
end

tt=dt;
for i=2:length(dt)
    tt(i)=tt(i)+tt(i-1);
end


for i=1:2*N-1
   
    Spt(:,i) = (S(:,i+1)-S(:,i))/dt(i);
    
end

for i=1:2*N-2
   
    Sppt(:,i) = (Spt(:,i+1)-Spt(:,i))/dt(i);
    
end

Plot_Graphs_Dir_Kinematics_Debug_AAA(S,Sp,Spp,Spt,Sppt,tt);


%%
Q = [];
Qs = [];
Qp = [];
Qpp = [];
% calcolo traiettoria


for i = 1:2*N
    
    s1 = rototrasla_Punto(S(:,i),alpha,Tt,'y');
    S1 = [S1 s1];
    q = Inverse_Kinematics_AAA(s1,L,2)';
    Q = [Q q];
    sp1 = rototrasla_Punto(Sp(:,i),alpha,Ttva,'y');
    Sp1 = [Sp1 sp1];
    spp1 = rototrasla_Punto(Spp(:,i),alpha,Ttva,'y');
    Spp1 = [Spp1 spp1];
    
    j = Jac_AAA(q,L);
    sp_inv = sp1;
    jinv = (j^-1);
    qp = jinv*sp1(1:3);
    Qp = [Qp qp];
    
    
    jp = JacP_AAA(q,qp,L);
    qpp = jinv*(spp1(1:3)-jp*qp);
    Qpp = [Qpp qpp];
    
end

%%
% plot animato traiettoria robot
% figure
% Plot_Trajectory_animation_AAA(Q,S1,L,N,10,"Cartesiano")

% plot configurazioni assunte
figure
hold on

for i = 1:2*N
    
    Plot_AAA(Q(:,i),L,"xyz");
    
end

plot3(x_tot,y_tot,z_tot,"--","LineWidth",2)
plot3(S1(1,:),S1(2,:),S1(3,:),"-o","LineWidth",2)

axis equal
pbaspect([20 20 20])
grid on
hold off


% plot posizione, velocità e accelerazione X, Y, Z
Plot_Graphs_Dir_Kinematics_AAA(S1,Sp1,Spp1,tt,dT)

