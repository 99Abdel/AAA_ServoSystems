clear all
close all
clc


%% definition initial data

% Posizione:
Qmax = [0 0 0];
Qmin = [0 -pi/4 -0.95*pi];


% Dimensione link:
L = [10 5 2];



%% Test plot Workingspace 3D:

[x_ws,y_ws,z_ws]=WS3D_AAA(L);

figure
hold on
grid on
plot3(x_ws,y_ws,z_ws,'.','color','[0.5 0.9 0.6]','MarkerSize',0.7)

Plot_AAA(Qmax,L)    % plot robot in max position
Plot_AAA(Qmin,L)    % plot robot in min position

title("Robot's Working Space (3D Rapresentation)")
axis equal
view(27,26)
xlabel('x')
ylabel('y')
zlabel('z')


%% Test plot Workingspace 2D:

Qmin = [pi/2 0 -pi];
Qmax = [0 0 0];

WS2D_AAA(L,Qmax,Qmin,2);

