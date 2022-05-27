clear all
close all

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
hold off

