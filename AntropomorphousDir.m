function S = AntropomorphousDir(Q,L)
%SCARADIRETTO cinematica dir. robot SCARA

    a = Q(1);  b = Q(2);  g = Q(3);
    
    l1 = L(1);  l2 = L(2); h = L(3);
    
    rho = l1*sin(b) + l2*sin(b+g);
    
    S=zeros(3,1);
    S(1) = rho*cos(a);
    S(2) = rho*sin(a);
    S(3) = h + l1*cos(b) + l2*cos(b+g);

end

