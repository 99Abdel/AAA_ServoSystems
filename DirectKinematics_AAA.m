function [S] = DirectKinematics_AAA(Q,L)

    a = Q(1);
    b = Q(2);
    c = Q(3);

    l1 = L(1);
    l2 = L(2);
    l3 = L(3);
    
    x = l2*cos(b)*cos(a) + l3*cos(b)*cos(a+c);
    y = l2*cos(b)*sin(a) + l3*cos(b)*sin(a+c);
    z = l1 - l2*sin(b) - l3*cos(c)*sin(b);
    
    %calcolati con le matrici di rotazione
    %x = l2*cos(a)*cos(b) - l3*sin(a)*sin(c) + l3*cos(a)*cos(b)*cos(c);
    %y = l2*cos(b)*sin(a) + l3*cos(a)*sin(c) + l3*cos(b)*cos(c)*sin(a);
    %z = l1 - l2*sin(b) - l3*cos(c)*sin(b);
    
    S = [x;y;z];

end

