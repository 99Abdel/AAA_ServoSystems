clear all
clc
close all

% xi=3; xf=5; dx=xf-xi;
% v0=0; vf=0.3; a0=0; af=0.2;
% k1=1;
% k2=3;
% k3=1;
% k4=3;
% k5=1;
% k6=5;
% k7=1;

xi=3; xf=5; dx=xf-xi;
v0=0; vf=0; a0=0; af=0;
k1=1;
k2=2;
k3=3;
k4=3;
k5=1;
k6=3;
k7=1;

T=5;
tt=0:0.01:5;
nn=max(size(tt));

L1=k1*T/(k1+k2+k3+k4+k5+k6+k7);
L2=k2*T/(k1+k2+k3+k4+k5+k6+k7);
L3=k3*T/(k1+k2+k3+k4+k5+k6+k7);
L4=k4*T/(k1+k2+k3+k4+k5+k6+k7);
L5=k5*T/(k1+k2+k3+k4+k5+k6+k7);
L6=k6*T/(k1+k2+k3+k4+k5+k6+k7);
L7=k7*T/(k1+k2+k3+k4+k5+k6+k7);

[sc,vc,A,D]=settetratti_generica_coeff(T,xi,dx,v0,vf,a0,af,L1,L2,L3,L4,L5,L6,L7);
for i=1:nn
    t=tt(i);
    [xx7(i),vv7(i),aa7(i)]=settetratti_generica(t,T,xi,dx,v0,vf,a0,af,L1,L2,L3,L4,L5,L6,L7,sc,vc,A,D);
end

figure
subplot(3,1,1)
plot(tt,xx7)
ylabel('position')
xlabel('time')
subplot(3,1,2)
plot(tt,vv7,[tt(1) tt(end)], [0 0])
ylabel('velocity')
xlabel('time')
subplot(3,1,3)
plot(tt,aa7,[tt(1) tt(end)], [0 0])
ylabel('acceleration')
xlabel('time')
