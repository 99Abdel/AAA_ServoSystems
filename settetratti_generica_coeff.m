function [sc,vc,A,D]=settetratti_generica_coeff(T,s0,Ds,v0,vf,acc,d,T1,T2,T3,T4,T5,T6,T7)

%Legge di moto a sette tratti generica: calcolo dei valori di spostamento e
%velocità nei punti in cui sono costanti
%function [sc,vc,A,D]=settetratti_generica_coeff(T,s0,Ds,v0,vf,acc,d,T1,T2,T3,T4,T5,T6,T7)
%T tempo di azionamento totale
%s0 posizione iniziale
%Ds ampiezza totale dello spostamento
%v0 velocità iniziale
%vf velocità finale
%acc accelerazione iniziale
%d decelerazione finale
%T1 durata del primo tratto
%T2 durata del secondo tratto
%T3 durata del terzo tratto
%T4 durata del settimo tratto
%T5 durata del quinto tratto
%T6 durata del sesto tratto
%T7 durata del settimo tratto
%sc vettore contenente i valori degli spostamenti in punti noti
%vc vettore contenente i valori delle velocità in punti noti
%A valore massimo dell'accelerazione
%D valore massimo dell'accelerazione negativa

sf=s0+Ds;

b1=T1^2/6+T1/2*(T2+T3+T4+T5+T6+T7);
b2=T2^2/2+T2*(T3+T4+T5+T6+T7);
b3=T3^2/3+T3/2*(T4+T5+T6+T7);
b5=T5^2/6+T5/2*(T6+T7);
b6=T6^2/2+T6*T7;
b7=T7^2/3;

m11=T1/2+T2+T3/2;
m12=T5/2+T6+T7/2;
m21=b1+b2+b3;
m22=b5+b6+b7;

n1=vf-v0-acc*T1/2-d*T7/2;
n2=Ds-v0*T-acc*(T1^2/3+T1/2*(T2+T3+T4+T5+T6+T7))-d*T7^2/6;

M=[m11 m12; m21 m22];

N=[n1 ; n2];

Z = inv(M)*N;          %si deve fare il prodotto tra la matrice N e l'iverso della matrice M  
A=Z(1,1);
D=Z(2,1);

vc(1)=v0+acc*T1/2+A*T1/2;                   
sc(1)=s0+v0*T1+acc*T1^2/3+A*T1^2/6;
vc(2)=vc(1)+A*T2;
sc(2)=sc(1)+A*T2^2/2+vc(1)*T2;
vc(3)=vc(2)+A*T3/2;
sc(3)=sc(2)+A*T3^2/3+vc(2)*T3;
vc(4)=vc(3);
sc(4)=sc(3)+vc(3)*T4;
vc(5)=vc(4)+D*T5/2;
sc(5)=sc(4)+D*T5^2/6+vc(4)*T5;
vc(6)=vc(5)+D*T6;
sc(6)=sc(5)+D*T6^2/2+vc(5)*T6;
vc(7)=vc(6)+D*T7/2+d*T7/2;
sc(7)=sc(6)+D*T7^2/3+d*T7^2/6+vc(6)*T7;
