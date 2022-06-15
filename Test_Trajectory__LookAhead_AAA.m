clc
clear all
close all


%% Test traiettoria numero 3


L = [10, 7, 4];

A = [6,4];
B = [4,2];
C = [3,3];

D = C;
E = [2,2];
F = [0,4];

[xc1,yc1,r1] = Find_Circ(A,B,C);
[xc2,yc2,r2] = Find_Circ(D,E,F);

xc1 = double(xc1);  xc2 = double(xc2);   
yc1 = double(yc1);  yc2 = double(yc2);  
r1 = double(r1);    r2 = double(r2);

N = 500;

th1 = linspace(pi/6,-pi,N/2);
th2 = linspace(0,-pi-pi/6,N/2);
th_tot = [th1, th2];

l1 = abs(-pi-pi/6)*r1;
l2 = abs((-pi/6-pi)-0)*r2;
L_t = [l1,l2];

x1 = r1*cos(th1) + xc1;
x2 = r2*cos(th2) + xc2 - 0.16228;
x_tot = [x1 x2]; 

y1 = r1*sin(th1) + yc1;
y2 = r2*sin(th2) + yc2;
y_tot = [y1 y2];

z_tot = zeros(1,N);

S = [x_tot;y_tot;z_tot];
S1 = [];

alpha = -pi/4;
Tt = [5,0,10];
Ttva = [0,0,0];

Q = [];
Qs = [];

for i = 1:N
   
    ss(i) = sqrt(S(1,i)^2 + S(2,i)^2 + S(3,i)^2);
    
end


n = 2;
A = 10; D = 5;
L_t = L_t;

Vmax = 2; Vi = 1; Vf = 1;
Vt = [Vmax, Vmax];
Vn = [Vi, Vmax/2, Vf];

[s,sp,spp,tt] = LookAhead_AAA(n,N,L_t,ss,Vt,Vn,A,D);
T = tt(end) - tt(1);

vx = sp.*sin(th_tot);
vy = -sp.*cos(th_tot);
vz = sp.*0;
Sp = [vx;vy;vz];
Sp1 = [];

sppc = -(sp.^2)./r1;
spp_tot = sqrt((spp.^2) + (sppc.^2));
atx = spp.*sin(th_tot);    acx = sppc.*cos(th_tot);    
aty = spp.*cos(th_tot);    acy = sppc.*sin(th_tot);
ax = atx + acx;
ay = aty + acy;
az = spp.*0;
Spp = [ax;ay;az];
Spp1 = [];

for i = 1:N
    
    s1 = rototrasla_Punto(S(:,i),alpha,Tt,'y');
    S1 = [S1 s1];
    q = Inverse_Kinematics_AAA(s1,L,2)';
    Q = [Q q];
    sp1 = rototrasla_Punto(Sp(:,i),alpha,Ttva,'y');
    Sp1 = [Sp1 sp1];
    spp1 = rototrasla_Punto(Spp(:,i),alpha,Ttva,'y');
    Spp1 = [Spp1 spp1];
    
end


%Plot_Trajectory_animation_AAA(Q,S1,L,2*n,10,"Cartesiano")

figure
hold on
% for i = 1:2*n
%    
%     Plot_AAA(Q(:,i),L,"xyz");
%     
% end

plot3(x_tot,y_tot,z_tot,"--","LineWidth",2)
plot3(S1(1,:),S1(2,:),S1(3,:),"-o","LineWidth",2)

axis equal
pbaspect([20 20 20])
grid on
hold off

dT = T/(N);
Plot_Graphs_Dir_Kinematics_AAA(S1,Sp1,Spp1,tt,dT)



