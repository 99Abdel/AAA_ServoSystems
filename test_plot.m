clear all
close all
clc


%% definition initial data

% Posizione:
Q = [0 -pi/2 0];

% Dimensione link:
L = [10 5 2];


% Test plot Robot:

figure
hold on

Plot_AAA(Q,L,"r");

pbaspect([50 50 50])    % serve per definire l'area di plot massima
axis equal
grid on
%hold off


%% Test plot Workingspace:

[x_ws,y_ws,z_ws]=WS3D(L);

figure
plot3(x_ws,y_ws,z_ws,'.','color','[0.5 0.9 0.6]','MarkerSize',0.7)
title("Robot's Working Space (3D Rapresentation)")
hold on
grid on
axis equal
view(27,26)
xlabel('x')
ylabel('y')
zlabel('z')