clear all
close all
clc


%% definition initial data

% Posizione:
Q = [0 0 0];

% Dimensione link:
L = [10 5 2];



%% Test plot Workingspace:

[x_ws,y_ws,z_ws]=WS3D_AAA(L);

figure
hold on
grid on
plot3(x_ws,y_ws,z_ws,'.','color','[0.5 0.9 0.6]','MarkerSize',0.7)
Plot_AAA(Q,L)
title("Robot's Working Space (3D Rapresentation)")
axis equal
view(27,26)
xlabel('x')
ylabel('y')
zlabel('z')


