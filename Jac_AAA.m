function J = Jac_AAA(Q,L)
% Jacobiano di un robot 3 assi

    l1 = L(1);    l2 = L(2);    l3 = L(3);
    a = Q(1);     b = Q(2);     c = Q(3);
    
    J = zeros(3,3);


    J(1,1) = -l2*sin(a)*cos(b) - l3*cos(a)*sin(c) - l3*sin(a)*cos(b)*cos(c);   
    J(1,2) = -l2*cos(a)*sin(b) - l3*cos(a)*sin(b)*cos(c);
    J(1,3) = -l3*sin(a)*cos(c) - l3*cos(a)*cos(b)*sin(c); 
    
    J(2,1) = l2*cos(a)*cos(b) - l3*sin(a)*sin(c) + l3*cos(a)*cos(b)*cos(c);
    J(2,2) = -l2*sin(a)*sin(b) - l3*sin(a)*sin(b)*cos(c);   
    J(2,3) = l3*cos(a)*cos(c) - l3*sin(a)*cos(b)*sin(c);
    
    J(3,1) = 0;   
    J(3,2) = -l2*cos(b) - l3*cos(b)*cos(c);   
    J(3,3) = l3*sin(b)*sin(c);
    

end
