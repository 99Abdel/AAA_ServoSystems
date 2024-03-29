%% definition initial data

clear all
close all
clc


%% ------------------------------------------------------------------------------
%  ---------------------------- KINEMATICS DATA ---------------------------------
%  ------------------------------------------------------------------------------

l1 = 10;   % link 1
l2 = 5;    % link 2
l3 = 2;    % link 3

L = [l1; l2; l3];    % matrice link


%-------- Direct kinematic configuration ----------

Qi = [0, -pi/2, 0]';
Qf = [0, 0, pi/2]';


%-------- Inverse kinematic configuration ----------

Qini_Inv = [0.1 -pi/8 -0.5*pi];
Si = [-2 -4 12];
Sf = [-3 -5 8];


T = 5;
n = 500;
dT = T/n;
dQ = Qf-Qi;
dS = Sf-Si;


%-------- Direct kinematic angular Speed Matrixes ----------

Lry= [0, 0, 1, 0;
      0, 0, 0, 0;
     -1, 0, 0, 0;
      0, 0, 0, 0];

Lrz=[0,-1, 0, 0;
     1, 0, 0, 0;
     0, 0, 0, 0;
     0, 0, 0, 0];

 
%% ------------------------------------------------------------------------------
%  ------------------------------ DYNAMICS DATA ---------------------------------
%  ------------------------------------------------------------------------------


%-------- external forces ----------
  
Fx = 1; Fy = 1; Fz = 1;
F_ext = [0,  0,  0,  Fx;
         0,  0,  0,  Fy;
         0,  0,  0,  Fz;
        -Fx,-Fy,-Fz, 0];

Hg = zeros(4); Hg(3,4) = -9.81;


% --------- centri di gravità ------------

g1 = 5;
g2 = 2.5;
g3 = 1;

G = [g1 g2 g3 1]; % non so se serve


% --------- masse e inerzie ------------

m1 = 11;
m2 = 7;
m3 = 4;

Jx = [0 0 0];
Jy = [0.427 0.286 0.0533];
Jz = [0.427 0.286 0.0533];

Jg = [0.427 0.286 0.0533];
Jxy = 0; Jxz = 0; Jyz = 0;


% ---------- Martrici Momenti di inerzia -------------

J1 = [Jx(1) Jxy Jxz;
      Jxy Jy(1) Jyz;
      Jxz Jyz Jz(1)];

J2 = [Jx(2) Jxy Jxz;
      Jxy Jy(2) Jyz;
      Jxz Jyz Jz(2)];

J3 = [Jx(3) Jxy Jxz;
      Jxy Jy(3) Jyz;
      Jxz Jyz Jz(3)];
  
 
% --------- shift Matrixes -----------

M1_1 = [1, 0, 0, -(l1-g1);
        0, 1, 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1];

M2_2 = [1, 0, 0, -(l2-g2);
        0, 1, 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1];

M3_3 = [1, 0, 0, -(l3-g3);
        0, 1, 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1];
    

 %% Pseudo insertia matrixes

J1_1 = pseudoInertia(J1,m1);
J11 = M1_1*J1_1*M1_1';

J2_2 = pseudoInertia(J2,m2);
J22 = M2_2*J2_2*M2_2';

J3_3 = pseudoInertia(J3,m3);
J33 = M3_3*J3_3*M3_3';



%% Transizione Velocità da giunti angolari a cartesiano

S = [];
Sp = [];
Spp = [];


% Dynamic Evaluation

J11_0 = [];
J22_0 = [];
J33_0 = [];

FF1 = [];
FF2 = [];
FF3 = [];

F_ext_0 = [];

EK_tot = [];
EP_tot = [];

CC1 = [];
CC2 = [];
CC3 = [];

WW1 = [];
WW2 = [];
WW3 = [];
WW4 = [];
WW_tot = [];




for i = 1:n
    
    
    % ---------------------------------------------------------------------
    % ----------------------- DIRECT KINEMATICS ---------------------------
    % ---------------------------------------------------------------------

    
    t=(i-1)*T/(n-1);      % time from 0 to T with step dT
    tt(i)=t;
    [a(i),ap(i),app(i)] = cycloidLaw(t,T,Qi(1),dQ(1));
    [b(i),bp(i),bpp(i)] = cycloidLaw(t,T,Qi(2),dQ(2));
    [c(i),cp(i),cpp(i)] = cycloidLaw(t,T,Qi(3),dQ(3));
    
    q = [a(i);b(i);c(i)];
    qp = [ap(i);bp(i);cp(i)];
    qpp = [app(i);bpp(i);cpp(i)];
    
    [s,M01,M12,M23] = Rotation_Matrixes_AAA(q,L); 
    
    S = [S s];
    
    M02 = M01*M12;
    M03 = M02*M23;
    
    
    % -------------------------------------IMPORTANTE--------------------------------
    % -------------------------------------------------------------------------------
    
    % In generale Hij_k significa accelerazione di (j) rispetto ad (i) vista dal sistema 
    % (k)  (in maniera analoga anche per le velocità)
    
    % -------------------------------------IMPORTANTE--------------------------------
    % -------------------------------------------------------------------------------
    
    
    % ------------ SPEED EVALUATION -------------
    
    w01_0 = Lrz*qp(1);      %speed in 0-1 seen by the referece system 0
    w12_0 = M01*Lry*qp(2)*inv(M01);     %speed in 1-2 seen by the referece system 0
    w23_0 = M02*Lrz*qp(3)*inv(M02);     %speed in 2-3 seen by the referece system 0
    
    w02_0 = w01_0 + w12_0;      %speed in 0-2 seen by the referece system 0 (sum of speed 0-1 % 1-2)
    w03_0 = w02_0 + w23_0;      %speed in 0-3 (gripper total speed) seen by the referece system 0 (sum of speed 0-2 % 2-3)
    
    sp = w03_0*s;       % linear speed of gripper is angular velocity multiplied by s.
    Sp = [Sp sp];
    
    
    % ------------ ACCELERATION EVALUATION -------------
    
    h01_0 = (Lrz*qpp(1) + Lrz^2*qp(1)^2);       %acceleration in 0-1 seen by the referece system 0
    h12_0 = M01*(Lry*qpp(2) + Lry^2*qp(2)^2)*inv(M01);      %acceleration in 1-2 seen by the referece system 0
    h23_0 = M02*(Lrz*qpp(3) + Lrz^2*qp(3)^2)*inv(M02);      %acceleration in 2-3 seen by the referece system 0
    
    h02_0 = h01_0 + h12_0 + 2*w01_0*w12_0;      %acc in 0-2 seen by the referece system 0 (sum of acc 0-1 % 1-2 and coriolis between them)
    h03_0 = h02_0 + h23_0 + 2*w02_0*w23_0;      %acc in 0-3 seen by the referece system 0 (sum of acc 0-2 % 2-3 and coriolis between them)
    
    spp = h03_0*s;
    Spp = [Spp spp];




    % ---------------------------------------------------------------------
    % ----------------------- DYNAMICS EVALUATION -------------------------
    % ---------------------------------------------------------------------


    j11_0 = M01*J11*M01';
    j22_0 = M02*J22*M02';
    j33_0 = M03*J33*M03';
    
    J11_0 = [J11_0 j11_0];
    J22_0 = [J22_0 j22_0];
    J33_0 = [J33_0 j33_0];
    
    
    % -------aggiungere la forza di gravità alle ff------
    
    ff1i = -(h01_0*j11_0 - j11_0*h01_0');
    ff2i = -(h02_0*j22_0 - j22_0*h02_0');
    ff3i = -(h03_0*j33_0 - j33_0*h03_0');
    
    ff1g = Hg*j11_0 - j11_0*Hg';
    ff2g = Hg*j22_0 - j22_0*Hg';
    ff3g = Hg*j33_0 - j33_0*Hg';
    
    
    M0a=eye(4,4);
    M0a(:,4)=M03(:,4); 
    fext_0 = M0a*F_ext*M0a'; 

    ff3 = ff3i+ff3g+fext_0;
    ff2 = ff2i+ff2g+ff3;
    ff1 = ff1i+ff1g+ff2; 
    
    FF1 = [FF1 ff1];
    FF2 = [FF2 ff2];
    FF3 = [FF3 ff3];
    
    F_ext_0 = [F_ext_0 fext_0];
    

    %----------------- KINETIC ENERGY -------------------
    
    ek1 = trace(1/2*w01_0*j11_0*w01_0');
    ek2 = trace(1/2*w02_0*j22_0*w02_0');
    ek3 = trace(1/2*w03_0*j33_0*w03_0');
    
    ek_tot = ek1 + ek2 + ek3;
    
    EK_tot = [EK_tot ek_tot];
    
    
    %----------------- POTENTIAL ENERGY ------------------- 
    
    ep1 = -trace(Hg*j11_0);
    ep2 = -trace(Hg*j22_0);
    ep3 = -trace(Hg*j33_0);

    ep_tot = ep1 + ep2 + ep3;
    
    EP_tot = [EP_tot ep_tot];
    
    
    %----------------- TORQUE OF FORCES -------------------
    
    L12_0 = M01*Lry*inv(M01); 
    L23_0 = M02*Lrz*inv(M02); 
    
    cc1 = -PseDot(ff1,Lrz);
    cc2 = -PseDot(ff2,L12_0); 
    cc3 = -PseDot(ff3,L23_0); 
    
    CC1 = [CC1 cc1];
    CC2 = [CC2 cc2];
    CC3 = [CC3 cc3];

    
    %----------------- POWER OF FORCES -------------------
    
    ww1 = -PseDot(ff1,w01_0);
    ww2 = -PseDot(ff2,w12_0);
    ww3 = -PseDot(ff3,w23_0);
    ww4 = PseDot(fext_0,w03_0);
    ww_tot = ww1+ww2+ww3+ww4;
    
    www1(i) = cc1*qp(1); 
    www2(i) = cc2*qp(2); 
    www3(i) = cc3*qp(3); 
    www_tot2(i) = www1(i)+www2(i)+www3(i)+ww4; 
    
    WW1 = [WW1 ww1];
    WW2 = [WW2 ww2];
    WW3 = [WW3 ww3];
    WW4 = [WW4 ww4];
    WW_tot = [WW_tot ww_tot];


end

E_tot = EK_tot + EP_tot;    % energia totale

P_tot = theorethicalDiff(E_tot,dT);     % total theoretical diff of power





%% ------------------------------------------------------------------------
%  ------------------------ INVERSE KINEMATICS ----------------------------
%  ------------------------------------------------------------------------


% Transizione Velocità da cartesiano a giunti angolari

Nmax = 1000;     % numero massimo iterazioni Newton
toll = 1e-10;    % tolleranza Newton

Q_inv = [];
Qp_inv = [];
Qpp_inv = [];

% faccio la prima ricerca fuori in modo da partire con il punto corretto
[q_inv,iter] = newtonRaphson(Si',Qini_Inv',L,toll,Nmax);
disp(iter)
Q_inv = [Q_inv q_inv];
Qp_inv = [0;0;0];
Qpp_inv = [0;0;0];

[x,xp,xpp,tt] = cycloidValues(T,n,Si(1),dS(1));
[y,yp,ypp,tt] = cycloidValues(T,n,Si(2),dS(2));
[z,zp,zpp,tt] = cycloidValues(T,n,Si(3),dS(3));


for i = 2:n


    % ---------------------------------------------------------------------
    % ----------------------- INVERSE KINEMATICS --------------------------
    % ---------------------------------------------------------------------


    s_inv = [x(i-1);y(i-1);z(i-1)];
    
    [q_inv,iter] = newtonRaphson(s_inv,Q_inv(:,i-1),L,toll,Nmax);
    Q_inv = [Q_inv q_inv];


    j = Jac_AAA(q_inv,L);
    sp_inv = [xp(i);yp(i);zp(i)];
    jinv = (j^-1);
    qp_inv = jinv*sp_inv;
    Qp_inv = [Qp_inv qp_inv];

    
    jp = JacP_AAA(q_inv,qp_inv,L);
    spp_inv = [xpp(i);ypp(i);zpp(i)];
    qpp_inv = jinv*(spp_inv-jp*qp_inv);
    Qpp_inv = [Qpp_inv qpp_inv];
    
    
end



%% plot configurations

% Dati da cinematica diretta:
Plot_Trajectory_AAA(Qi,Qf,L,S(1,:),S(2,:),S(3,:),n,"Giunti");

% Dati da cinematica inversa:
Plot_Trajectory_AAA(Q_inv(:,1),Q_inv(:,end),L,x,y,z,n,"Lineare");


%% plot graph of data x,y,z position speed and acceleration

Plot_Graphs_Dir_Kinematics_AAA(S,Sp,Spp,tt,dT)


%% plot graph of data a,b,c position speed and acceleration

Plot_Graphs_Inv_Kinematics_AAA(Q_inv,Qp_inv,Qpp_inv,tt,dT)



%% Plot Coppie

% --------- torques ------------
h=figure
set(h,'name','torques')
subplot(3,1,1)
plot(tt,CC1,'b')
legend("Fq 1")
grid on
title("Torques")

subplot(3,1,2)
plot(tt,CC2,'g')
legend("Fq 2")
grid on

subplot(3,1,3)
plot(tt,CC3,'r')
legend("Fq 3")
grid on


%% Plot Energia

% --------- energy ------------

h=figure
set(h,'name','energy') 

subplot(3,1,1)
plot(tt,EP_tot,'g')
legend("potential energy")
grid on
title("Energy")

subplot(3,1,2)
plot(tt,EK_tot,'b')
legend("kinetic energy")
grid on

subplot(3,1,3)
plot(tt,E_tot,'r')
legend("total energy")
grid on


%% Plot Potenze reali e teoriche

% --------- power ------------

h=figure
set(h,'name','power') 
hold on
grid on
plot(tt,WW_tot,'b--')
plot(tt,www_tot2,'g--')

plot(tt(1:length(P_tot)),P_tot,'r')
legend("Real power", "Real power2", "Theoric power")
title("power")


%% Plot tutte le potenze

% --------- power ------------

h=figure
set(h,'name','all power') 

hold on
grid on

plot(tt,WW1)
plot(tt,WW2)
plot(tt,WW3)
plot(tt,WW4)
plot(tt,WW_tot,'b')

plot(tt,www1,'--')
plot(tt,www2,'--')
plot(tt,www2,'--')

legend("ww1","ww2","ww3","ww4","ww_tot","ww1#","ww2#","ww3#")
title("all powers")
