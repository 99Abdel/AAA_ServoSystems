clear all

x = linspace(-1,1,20);
y = linspace(-1,1,20);
z = zeros(1,20);
w = ones(1,20);

S = [x;y;z;w];
S_specchiato = [x;flip(y);z;w];
S1 = [];
SS = [];

alpha = -pi/4;
T = [10,3,10];

for i = 1:20
    
S1 = [S1 rototrasla_Punto(S(:,i),alpha,T)];
SS = [SS rototrasla_Punto(S_specchiato(:,i),alpha,T)];

end

hold on
plot3(x,y,z,"--","LineWidth",2)
plot3(x,flip(y),z,"--","LineWidth",2)
plot3(S1(1,:),S1(2,:),S1(3,:),"-o","LineWidth",2)
plot3(SS(1,:),SS(2,:),SS(3,:),"-o","LineWidth",2)
pbaspect([5 5 5]);
axis equal
grid on


