close all
clear all
clc

n = 20;
L = [10, 5, 2];

x = linspace(-1,1,n);
y = linspace(-1,1,n);
z = zeros(1,n);

S = [x;y;z];
S_specchiato = [x;flip(y);z];
S1 = [];
SS = [];

Qmax = [0 0 0];
Qmin = [0 -pi/4 -0.95*pi];

alpha = -pi/4;
T = [5,2,8];
Q = [];
Qs = [];

for i = 1:n
    
    s1 = rototrasla_Punto(S(:,i),alpha,T);
    ss = rototrasla_Punto(S_specchiato(:,i),alpha,T);
    
    S1 = [S1 s1];
    SS = [SS ss];
    
    q = Inverse_Kinematics_AAA(s1,L,2)';
    qs = Inverse_Kinematics_AAA(ss,L,2)';
    
    Q = [Q q];
    Qs = [Qs qs];
    
end

Q_tot = [Q Qs]

figure
hold on
for i = 1:n*2
   
    Plot_AAA(Q_tot(:,i),L,"xyz");
    
end

axis equal
pbaspect([20 20 20])
grid on

plot3(x,y,z,"--","LineWidth",2)
plot3(x,flip(y),z,"--","LineWidth",2)
plot3(S1(1,:),S1(2,:),S1(3,:),"-o","LineWidth",2)
plot3(SS(1,:),SS(2,:),SS(3,:),"-o","LineWidth",2)

axis equal
grid on
hold off

Plot_Trajectory_animation_AAA(Q_tot,[S1 SS],L,2*n,10,"Cartesiano")
