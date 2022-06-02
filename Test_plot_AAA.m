clear all
close all
clc


%% definition initial data

% Posizione:
Qmax = [0 0 0];
Qmin = [0 -pi/4 -0.95*pi];

%test voluto
%Qmin = [0 -pi/4 pi/4];

% Dimensione link:
L = [10 5 2];


%% Test plot Workingspace 3D:

WS3D_AAA(L,Qmax,Qmin);


%% Test plot Workingspace 2D:

Qmin = [pi/4 0 -pi/2];
Qmax = [0 0 0];
WS2D_AAA(L,Qmax,Qmin,'xy');

Qmin = [0 -pi/4 -pi];
Qmax = [0 0 0];
WS2D_AAA(L,Qmax,Qmin,'xz');

Qmin = [pi/2 -pi/4 -pi];
Qmax = [-pi/2 0 0];
WS2D_AAA(L,Qmax,Qmin,'yz');


