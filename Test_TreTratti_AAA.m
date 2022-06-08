clear all
close all
clc


n = int32(pi*300);   T = 5;   R = 2;
Vi = 1;   Vf = 3;
Vmax = 5;   Amax = 10;   Dmax = 10; 
lambda1 = 0.3;   lambda3 = 0.5;

theta = linspace(0,pi,n);
z = zeros(1,n);
dT = T/n;

x = R*cos(theta);
y = R*sin(theta);


[xp,xpp,tt] = treTrattiValues_AAA(T,x,Vi,Vf,Vmax,Amax,Dmax,lambda1,lambda3);
[yp,ypp,tt] = treTrattiValues_AAA(T,y,Vi,Vf,Vmax,Amax,Dmax,lambda1,lambda3);
[zp,zpp,tt] = treTrattiValues_AAA(T,z,Vi,Vf,Vmax,Amax,Dmax,lambda1,lambda3);

S = [x;y;z];
Sp = [xp;yp;zp];
Spp = [xpp;ypp;zpp];

Plot_Graphs_Dir_Kinematics_noDebug_AAA(S,Sp,Spp,tt);


