function n_plot = Plot_AAA(Q,L,dim)
% Plotta il robot nella configurazione fornita in 2D o 3D

% IMPORTANTE: ricordarsi l'uso di hold on e hold off per richiamare la funzione

    a = Q(1);     b = Q(2);     c = Q(3);
    l1 = L(1);    l2 = L(2);    l3 = L(3);
    
    x0 = 0;    y0 = 0;    z0 = 0;   
    x1 = 0;    y1 = 0;    z1 = l1;
    
%     % equazioni fatte a mano (da verificare):
%     x2 = l2*cos(b)*cos(a);      x3 = x2 + l3*cos(b)*cos(a+c);
%     y2 = l2*cos(b)*sin(a);      y3 = y2 + l3*cos(b)*sin(a+c);
%     z2 = l1 - l2*sin(b);        z3 = z2 - l3*sin(b)*cos(c);
% problema relativo al cos(b) in x3 e y3 (caso in cui b=+-pi/2 e c=+-pi/2) (scompare l3)

  
    % Equazioni ricavate con le matrici di rotazione:
    x2 = l2*cos(a)*cos(b);      x3 = x2 - l3*sin(a)*sin(c) + l3*cos(a)*cos(b)*cos(c);
    y2 = l2*cos(b)*sin(a);      y3 = y2 + l3*cos(a)*sin(c) + l3*cos(b)*cos(c)*sin(a);
    z2 = l1 - l2*sin(b);        z3 = z2 - l3*cos(c)*sin(b);
    
    X = [x0 x1 x2 x3];
    Y = [y0 y1 y2 y3];
    Z = [z0 z1 z2 z3];
    

    if dim == "xy"

        % Plot robot nello spazio 2D:
        plot(X(1:2), Y(1:2), 'LineWidth',2,'color','r');
        plot(X(2:3), Y(2:3), 'LineWidth',2,'color','b');
        plot(X(3:4), Y(3:4), 'LineWidth',2,'color','g');
        
    
    elseif dim == "xz" 

        % Plot robot nello spazio 2D:
        plot(X(1:2), Z(1:2), 'LineWidth',2,'color','r');
        plot(X(2:3), Z(2:3), 'LineWidth',2,'color','b');
        plot(X(3:4), Z(3:4), 'LineWidth',2,'color','g');


    elseif dim == "yz"

        % Plot robot nello spazio 2D:
        plot(Y(1:2), Z(1:2), 'LineWidth',2,'color','r');
        plot(Y(2:3), Z(2:3), 'LineWidth',2,'color','b');
        plot(Y(3:4), Z(3:4), 'LineWidth',2,'color','g');

        
    elseif dim == "xyz"
        
        % Plot robot nello spazio 3D:
        n_plot(1) = plot3(X(1:2), Y(1:2), Z(1:2), 'LineWidth',2,'color','r');
        n_plot(2) = plot3(X(2:3), Y(2:3), Z(2:3), 'LineWidth',2,'color','b');
        n_plot(3) = plot3(X(3:4), Y(3:4), Z(3:4), 'LineWidth',2,'color','g');
        
    end


end

