function [x_ws,y_ws,z_ws] = WS3D_AAA(L)
% Calcolo dei Punti del Workspace 3D
    
    n = 100;
    a = linspace(0,2*pi,n);         % da 0 a 360 (0, 2*pi)
    b = linspace(-pi/2,pi/2,n);     % da -90 a 90 (-pi/2, pi/2)
    c = linspace(0,2*pi,3);        % da 0 a 360 (0, 2*pi)
    
    l1 = L(1);
    l2 = L(2);
    l3 = L(3);
    
    x_max = [];
    y_max = [];
    z_max = [];
    
    x_min = [];
    y_min = [];
    z_min = [];
    
    
    for i = 1:length(a)
        for j = 1:length(b)
                
                x_max = [x_max (l2*cos(b(j))*cos(a(i)) + l3*cos(b(j))*cos(a(i)+c(1)))];
                y_max = [y_max (l2*cos(b(j))*sin(a(i)) + l3*cos(b(j))*sin(a(i)+c(1)))];
                z_max = [z_max (l1 - l2*sin(b(j)) - l3*cos(c(1))*sin(b(j)))];
                
                x_min = [x_min (l2*cos(b(j))*cos(a(i)) + l3*cos(b(j))*cos(a(i)+c(2)))];
                y_min = [y_min (l2*cos(b(j))*sin(a(i)) + l3*cos(b(j))*sin(a(i)+c(2)))];
                z_min = [z_min (l1 - l2*sin(b(j)) - l3*cos(c(2))*sin(b(j)))];
                
        end
    end
    
    x_ws = [x_max x_min];
    y_ws = [y_max y_min];
    z_ws = [z_max z_min];


end

