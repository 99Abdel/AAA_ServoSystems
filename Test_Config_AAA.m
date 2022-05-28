clear all
close all
clc

L = [10,5,3];
S = [4,4,12];

Q1 = Inverse_Kinematics_AAA(S,L,1);
Q2 = Inverse_Kinematics_AAA(S,L,2);
Q3 = Inverse_Kinematics_AAA(S,L,3);
Q4 = Inverse_Kinematics_AAA(S,L,4);


hold on

Plot_AAA(Q1,L,"xyz");
Plot_AAA(Q2,L,"xyz");
Plot_AAA(Q3,L,"xyz");
Plot_AAA(Q4,L,"xyz");

pbaspect([20,20,20]);
axis equal
grid on
hold off

A = [0,-1];
B = [0,1];
C = [1,0];

[xc,yc,r] = Find_Circ(A,B,C)