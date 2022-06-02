clear all
close all
clc

l1 = 10; l2 = 5; l3 = 2;
n = (pi^4);
toll = 1e-13;
max_angle = 2*pi;
L = [l1, l2, l3];
a = linspace(0,max_angle,n);
b = linspace(0,max_angle,n);
c = linspace(0,max_angle,n);

S = [];
Sing = [];
R = [];


for i=a
    
    for j=b
       
        for k=c
           
            result = l3^3*cos(i)^2*cos(j)^3*cos(k)^2*sin(k) - l3^3*cos(j)*cos(k)^2*sin(i)^2*sin(k) - l3^3*cos(i)^2*cos(j)*cos(k)^2*sin(k) + l3^3*cos(j)^3*cos(k)^2*sin(i)^2*sin(k) + l2^2*l3*cos(i)^2*cos(j)^3*sin(k) + l2^2*l3*cos(j)^3*sin(i)^2*sin(k) - l2*l3^2*cos(i)^2*cos(j)*cos(k)*sin(k) - l2*l3^2*cos(j)*cos(k)*sin(i)^2*sin(k) + l3^3*cos(i)^2*cos(j)*cos(k)^2*sin(j)^2*sin(k) + l3^3*cos(j)*cos(k)^2*sin(i)^2*sin(j)^2*sin(k) + 2*l2*l3^2*cos(i)^2*cos(j)^3*cos(k)*sin(k) + l2^2*l3*cos(i)^2*cos(j)*sin(j)^2*sin(k) + 2*l2*l3^2*cos(j)^3*cos(k)*sin(i)^2*sin(k) + l2^2*l3*cos(j)*sin(i)^2*sin(j)^2*sin(k) + 2*l2*l3^2*cos(i)^2*cos(j)*cos(k)*sin(j)^2*sin(k) + 2*l2*l3^2*cos(j)*cos(k)*sin(i)^2*sin(j)^2*sin(k);
            
            if abs(result) < toll
                sing = [i;j;k];
                Sing = [Sing sing];
                R = [R result];
                q = [i,j,k];
                s = Direct_Kinematics_AAA(q,L);
                S = [S s];
            end
                        
        end
        
    end
    
end

dot_size = 3;

figure
title("Configurazioni Singolarità Giunti")
plot3(Sing(1,:),Sing(2,:),Sing(3,:),".","MarkerSize",dot_size)
xlabel('alpha')
ylabel('beta')
zlabel('gamma')
grid on
axis equal

figure
title("Configurazioni Singolarità Spazio")
plot3(S(1,:),S(2,:),S(3,:),".","MarkerSize",dot_size)
xlabel('x')
ylabel('y')
zlabel('z')
grid on
axis equal

%% con fimpicit come verifica.
fun = @(i,j,k) l3^3*cos(i)^2*cos(j)^3*cos(k)^2*sin(k) - l3^3*cos(j)*cos(k)^2*sin(i)^2*sin(k) - l3^3*cos(i)^2*cos(j)*cos(k)^2*sin(k) + l3^3*cos(j)^3*cos(k)^2*sin(i)^2*sin(k) + l2^2*l3*cos(i)^2*cos(j)^3*sin(k) + l2^2*l3*cos(j)^3*sin(i)^2*sin(k) - l2*l3^2*cos(i)^2*cos(j)*cos(k)*sin(k) - l2*l3^2*cos(j)*cos(k)*sin(i)^2*sin(k) + l3^3*cos(i)^2*cos(j)*cos(k)^2*sin(j)^2*sin(k) + l3^3*cos(j)*cos(k)^2*sin(i)^2*sin(j)^2*sin(k) + 2*l2*l3^2*cos(i)^2*cos(j)^3*cos(k)*sin(k) + l2^2*l3*cos(i)^2*cos(j)*sin(j)^2*sin(k) + 2*l2*l3^2*cos(j)^3*cos(k)*sin(i)^2*sin(k) + l2^2*l3*cos(j)*sin(i)^2*sin(j)^2*sin(k) + 2*l2*l3^2*cos(i)^2*cos(j)*cos(k)*sin(j)^2*sin(k) + 2*l2*l3^2*cos(j)*cos(k)*sin(i)^2*sin(j)^2*sin(k);
figure
H = fimplicit3(fun,[0 2*pi]);
