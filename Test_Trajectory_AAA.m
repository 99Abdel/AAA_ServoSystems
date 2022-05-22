%% definition initial data

clear all
close all
clc

l1 = 10;   % 
l2 = 5;   % 
l3 = 2;   % 


L = [l1 l2 l3]';

%-------- cinematic configuration ----------

Qi=[0, -pi/2, 0]';
Qf=[0, 0, pi]';

Qi2 = Qf;
Qf2=[0, pi/3, 0]';


%% Law of motion

T = 5;
n = 500;
dT = T/n;
dQ = Qf-Qi;
dQ2 = Qf2-Qi2;


%% Transizione Velocità da giunti angolari a cartesiano

S = [];
S2 = [];

for i=1:n

    t=(i-1)*T/(n-1); % time from 0 to T with step dT
    tt(i)=t;
    [a(i),ap(i),app(i)] = cycloidLaw(t,T,Qi(1),dQ(1));
    [b(i),bp(i),bpp(i)] = cycloidLaw(t,T,Qi(2),dQ(2));
    [c(i),cp(i),cpp(i)] = cycloidLaw(t,T,Qi(3),dQ(3));
    
    q = [a(i);b(i);c(i)];
    qp = [ap(i);bp(i);cp(i)];
    qpp = [app(i);bpp(i);cpp(i)];
    
    [s,M01,M12,M23] = Rotation_Matrixes_AAA(q,L); 
    S = [S s];
    
    
    [a2(i),ap2(i),app2(i)] = cycloidLaw(t,T,Qi2(1),dQ2(1));
    [b2(i),bp2(i),bpp2(i)] = cycloidLaw(t,T,Qi2(2),dQ2(2));
    [c2(i),cp2(i),cpp2(i)] = cycloidLaw(t,T,Qi2(3),dQ2(3));
    
    q2 = [a2(i);b2(i);c2(i)];
    qp2 = [ap2(i);bp2(i);cp2(i)];
    qpp2 = [app2(i);bpp2(i);cpp2(i)];
    
    [s2,M01,M12,M23] = Rotation_Matrixes_AAA(q2,L); 
    S2 = [S2 s2];
    
    
end

S = [S S2];

%% plot configurations

Plot_Trajectory_AAA(Qi,Qf2,L,S(1,:),S(2,:),S(3,:),n,'xyz');






%% Test piano inclinato

gamma = pi/4;

[N01,N02,N03,N12,N23]=PianoInclinato(S,gamma);

t = 1:7;
tempo = t(1):dT:(t(end)-dT);

% x = [0.6,0.45,0.42,0.55,0.42,0.45,0.6]-0.6;
% y = [0.66,0.64,0.55,0.55,0.55,0.4,0.38]-0.66;
x = [0.6,0.45,0.42,0.55,0.42,0.45,0.6]*15;
y = [0.66,0.64,0.55,0.55,0.55,0.4,0.38]*15;

[xe,xpe,xppe] = Spline(t,x);
[ye,ype,yppe] = Spline(t,y);

ze = zeros(1,length(xe));
zpe = zeros(1,length(xe));
zppe = zeros(1,length(xe));

Pe_primo = diag([1 1 1 1]);
Pep_primo = diag([1 1 1 1]);
Pepp_primo = diag([1 1 1 1]);


for i=1:length(tempo)

    Pe_primo(1,4) = xe(i);
    Pe_primo(2,4) = ye(i);
    Pe_primo(3,4) = ze(i);
    Pe = N03*Pe_primo*N03';
    P2_e(:,i) = Pe(1:3,end);

end


figure
Plot_AAA(Qi(:,end),L,'xyz')
hold on
grid on
plot3(P2_e(1,:),P2_e(2,:),P2_e(3,:),'r--')
legend('','','Trajectory');
title('e');
pbaspect([20 20 20])
xlabel('x');
ylabel('y');
zlabel('z');
view(27,26)
hold off

Plot_Trajectory_AAA(Qi,Qf2,L,P2_e(1,:),P2_e(2,:),P2_e(3,:),n,'xyz');

