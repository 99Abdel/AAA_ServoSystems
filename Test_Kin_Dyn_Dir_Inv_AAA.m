%% definition initial data

clear all
close all
clc

l1 = 10;   % link 1
l2 = 5;    % link 2
l3 = 2;    % link 3

L = [l1; l2; l3];    % matrice link


%-------- Direct cinematic configuration ----------

Qi = [0, -pi/2, 0]';
Qf = [0, 0, pi/2]';


%-------- Inverse cinematic configuration ----------

Qini_Inv = [0.1 -pi/8 -0.5*pi];
Si = [-2 -4 12];
Sf = [-3 -5 8];


T = 5;
n = 500;
dT = T/n;
dQ = Qf-Qi;
dS = Sf-Si;


%-------- Direct cinematic angular Speed Matrixes ----------

Lry= [0, 0, 1, 0;
      0, 0, 0, 0;
     -1, 0, 0, 0;
      0, 0, 0, 0];

Lrz=[0,-1, 0, 0;
     1, 0, 0, 0;
     0, 0, 0, 0;
     0, 0, 0, 0];



%% Transizione Velocità da giunti angolari a cartesiano

S = [];
Sp = [];
Spp = [];


for i = 1:n
    
    
    % ---------------------------------------------------------------------
    % ----------------------- DIRECT KINEMATICS ---------------------------
    
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


end



%% Transizione Velocità da cartesiano a giunti angolari

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
    
    
    s_inv = [x(i-1);y(i-1);z(i-1)];
    
    [q_inv,iter] = newtonRaphson(s_inv,Q_inv(:,i-1),L,toll,Nmax);
    Q_inv = [Q_inv q_inv];
    

    disp(i)
    if iter >= Nmax
        disp("errore")
    end


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

