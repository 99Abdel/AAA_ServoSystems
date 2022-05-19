function [S] = Direct_Kinematics_AAA(Q,L)

    a = Q(1);
    b = Q(2);
    c = Q(3);

    l1 = L(1);
    l2 = L(2);
    l3 = L(3);
    
%     % per plottare le aree sono state usate queste equazioni quindi funzionano
%     x = l2*cos(b)*cos(a) + l3*cos(b)*cos(a+c);
%     y = l2*cos(b)*sin(a) + l3*cos(b)*sin(a+c);
%     z = l1 - l2*sin(b) - l3*cos(c)*sin(b);
    
    
    % calcolati con le matrici di rotazione
    x = l2*cos(a)*cos(b) - l3*sin(a)*sin(c) + l3*cos(a)*cos(b)*cos(c);
    y = l2*sin(a)*cos(b) + l3*cos(a)*sin(c) + l3*sin(a)*cos(b)*cos(c);
    z = l1 - l2*sin(b) - l3*sin(b)*cos(c);
    
    S = [x;y;z];

end

