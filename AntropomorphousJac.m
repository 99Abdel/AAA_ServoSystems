function J = AntropomorphousJac(Q,L)
%ANTROPOMORFOJACOBIANO jacobiano di un robot ANTROPOMORFO
% --------------------------------
% ancora da fare
% ------------------------

    l1 = L(1); l2 = L(2); h = L(3);
    a = Q(1);  b = Q(2);  g = Q(3);
    
    J=zeros(3,3);
    J(1,1)=1;   J(1,2)=1;   J(1,3)=1; 
    J(2,1)=1;   J(2,2)=1;   J(2,3)=1;
    J(3,1)=1;   J(3,2)=1;   J(3,3)=1;
    
end
