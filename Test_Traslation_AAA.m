close all
clear all
clc

% Disegna una X nello spazio e poi un 3, entrambi in coordinate cartesia e 
% su un piano inclinato rispetto a un asse 


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
    
    s1 = rototrasla_Punto(S(:,i),alpha,T,'y');
    ss = rototrasla_Punto(S_specchiato(:,i),alpha,T,'y');
    
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





%% Test traiettoria numero 3

clear all
close all
clc

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


% gestione coordinate con raggio e angoli:
n = 50;
% th1 = linspace(pi/6,-pi,n);
% th2 = linspace(0,-pi-pi/6,n);
% 
% x1 = r1*cos(th1) + xc1;
% x2 = r2*cos(th2) + xc2;
% x_tot = [x1 x2]; 
% 
% y1 = r1*sin(th1) + yc1;
% y2 = r2*sin(th2) + yc2;
% y_tot = [y1 y2]; 


% gestione coordinate con x ed equazione circonferenza:
x1 = linspace(xc1+1.5,xc1-1.5,n);     % dovrei usare r1 ma c'è piccolo errore di approssimazione
x2 = linspace(xc2+1.5,xc2-1.5,n);
x_tot = [x1 x2];

y1 = [];
y2 = [];

for i = 1:n

    %y1a = yc1+sqrt(yc1^2-((x1(i)-xc1)^2-r1^2+yc1^2));
    y1b = yc1-sqrt(yc1^2-((x1(i)-xc1)^2-r1^2+yc1^2));
    y1(i) = y1b;
    %y2a = yc2+sqrt(yc2^2-((x2(i)-xc2)^2-r2^2+yc2^2));
    y2b = yc2-sqrt(yc2^2-((x2(i)-xc2)^2-r2^2+yc2^2));
    y2(i) = y2b;

end

y_tot = [y1 y2];


z_tot = zeros(1,2*n);

S = [x_tot;y_tot;z_tot];
S1 = [];

alpha = -pi/4;
T = [5,0,10];

Q = [];
Qs = [];


for i = 1:2*n
    
    s1 = rototrasla_Punto(S(:,i),alpha,T,'y');
    S1 = [S1 s1];
    q = Inverse_Kinematics_AAA(s1,L,2)';
    Q = [Q q];
    
end


Plot_Trajectory_animation_AAA(Q,S1,L,2*n,10,"Cartesiano")


% figure
% hold on
% for i = 1:2*n
%    
%     Plot_AAA(Q(:,i),L,"xyz");
%     
% end
% 
% plot3(x_tot,y_tot,z_tot,"--","LineWidth",2)
% plot3(S1(1,:),S1(2,:),S1(3,:),"-o","LineWidth",2)
% 
% axis equal
% pbaspect([20 20 20])
% grid on
% hold off

