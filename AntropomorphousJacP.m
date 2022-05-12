function Jp = AntropomorphousJacP(Q,Qp,L)
%ANTROPOMORFOJACOBIANO_P jacobiano_P di un robot ANTROPOMORFO
% --------------------------------
% ancora da fare
% ------------------------

    l1 = L(1); l2 = L(2); h = L(3);
    a = Q(1);  b = Q(2);  g = Q(3);
    ap = Qp(1);  bp = Qp(2);  gp = Qp(3);
    
    Jp=zeros(3,3);
    Jp(1,1)=1;   Jp(1,2)=1;   Jp(1,3)=1; 
    Jp(2,1)=1;   Jp(2,2)=1;   Jp(2,3)=1;
    Jp(3,1)=1;   Jp(3,2)=1;   Jp(3,3)=1;
    
end
