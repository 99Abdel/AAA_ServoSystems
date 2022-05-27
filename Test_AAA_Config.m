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


% for i = 6:8
%   
%     q = [pi/6,0,pi/6]*i;
%     
%     Q = [Q q'];
%     
%     Plot_AAA(q,L,"xyz")
% 
% 
%     S = Direct_Kinematics_AAA(q,L);
% 
%     q2 = Inverse_Kinematics_AAA(S,L);
% 
%     Q2 = [Q2 q2'];
% 
%     Plot_AAA(q2,L,"xyz")
% 
% end