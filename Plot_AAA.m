function Plot_AAA(Q,L,colore)
% Plotta il robot nello spazio rappresentandolo nella configurazione
% passata
    
    a = Q(1);   b = Q(2);   c = Q(3);
    l1 = L(1);  l2 = L(2);    l3 = L(3);
    
    x0 = 0;    y0 = 0;    z0 = 0;   
    x1 = 0;    y1 = 0;    z1 = l1;
    
    % equazioni fatte a mano (errate):
    %  x2 = l2*cos(b)*cos(a);    y2 = l2*cos(b)*sin(a);    z2 = l1 - l2*sin(b);
    %  x3 = x2 + l3*cos(b)*cos(a+c);   y3 = y2 + l3*cos(b)*sin(a+c);   z3 = z2 - l3*sin(b)*cos(c);
  
    % Equazioni ricavate con le matrici di rotazione:
    x2 = l2*cos(a)*cos(b);      x3 = x2 - l3*sin(a)*sin(c) + l3*cos(a)*cos(b)*cos(c);
    y2 = l2*cos(b)*sin(a);      y3 = y2 + l3*cos(a)*sin(c) + l3*cos(b)*cos(c)*sin(a);
    z2 = l1 - l2*sin(b);        z3 = z2 - l3*cos(c)*sin(b);
    
    X = [x0 x1 x2 x3];
    Y = [y0 y1 y2 y3];
    Z = [z0 z1 z2 z3];
    
    % Plot robot nello spazio:
    plot3(X(1:2), Y(1:2), Z(1:2), 'LineWidth',2,'color',colore);
    plot3(X(2:3), Y(2:3), Z(2:3), 'LineWidth',2,'color','b');
    plot3(X(3:4), Y(3:4), Z(3:4), 'LineWidth',2,'color','g');

end