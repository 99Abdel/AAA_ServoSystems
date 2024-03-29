function WS3D_AAA(L,Qmax,Qmin)
% Calcolo dei Punti del Workspace 3D
    
    n = 200;

    a = linspace(0,2*pi,n);          % da 0 a 360 (0, 2*pi)
    b = linspace(-pi/2,pi/2,n);      % da -90 a 90 (-pi/2,pi/2)
    c = linspace(0,2*pi,3);          % da 0 a 360 (0, 2*pi)
    
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
                
                % coordinate sfera max
                x_max = [x_max (l2*cos(b(j))*cos(a(i)) + l3*cos(b(j))*cos(a(i)+c(1)))];
                y_max = [y_max (l2*cos(b(j))*sin(a(i)) + l3*cos(b(j))*sin(a(i)+c(1)))];
                z_max = [z_max (l1 - l2*sin(b(j)) - l3*cos(c(1))*sin(b(j)))];
                
                % coordinate sfera minima
                x_min = [x_min (l2*cos(b(j))*cos(a(i)) + l3*cos(b(j))*cos(a(i)+c(2)))];
                y_min = [y_min (l2*cos(b(j))*sin(a(i)) + l3*cos(b(j))*sin(a(i)+c(2)))];
                z_min = [z_min (l1 - l2*sin(b(j)) - l3*cos(c(2))*sin(b(j)))];
                
        end
    end
    
    
    x_ws = [x_max x_min];
    y_ws = [y_max y_min];
    z_ws = [z_max z_min];

    figure
    hold on
    grid on
    plot3(x_ws,y_ws,z_ws,'.','color',[0.5 0.9 0.6],'MarkerSize',0.7);
    
    Plot_AAA(Qmax,L,"xyz");    % plot robot in max position
    Plot_AAA(Qmin,L,"xyz");    % plot robot in min position
    
    title("Robot's Working Space (3D Rapresentation)")
    axis equal
    view(27,26)
    xlabel('x [m]')
    ylabel('y [m]')
    zlabel('z [m]')
    hold off


end

