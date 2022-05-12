function [x_ws,y_ws,z_ws] = WS3D(L)
% Calcolo dei Punti del Workspace 3D

alfa_ws = linspace(0,2*pi,100);         % da 0 a 360 (0, 2*pi)
beta_ws = linspace(-pi/2,pi/2,100);     % da -90 a 90 (-pi/2, pi/2)
gamma_ws = linspace(-pi,pi,100);        % da -180 a 180 (-pi, pi)

l1 = L(1);
l2 = L(2);
l3 = L(3);

x_max = [];
y_max = [];
z_max = [];

x_min = [];
y_min = [];
z_min = [];

x_cil = [];
y_cil = [];
z_cil = [];


for i = 1:length(alfa_ws)
    for j = 1:length(beta_ws)
        if beta_ws(j) == pi/2 || beta_ws(j) == -pi/2
            for k = 1:length(gamma_ws)
                x_cil = [x_cil (l2+gamma_ws(k)*cos(beta_ws(j)))*cos(alfa_ws(i))];
                y_cil = [y_cil (l2+gamma_ws(k)*cos(beta_ws(j)))*sin(alfa_ws(i))];
                z_cil = [z_cil l1-gamma_ws(k)*sin(beta_ws(j))];
            end
        else
            x_max = [x_max (l2+0.6*cos(beta_ws(j)))*cos(alfa_ws(i))];
            y_max = [y_max (l2+0.6*cos(beta_ws(j)))*sin(alfa_ws(i))];
            z_max = [z_max l1-0.6*sin(beta_ws(j))];

            x_min = [x_min (l2+0.3*cos(beta_ws(j)))*cos(alfa_ws(i))];
            y_min = [y_min (l2+0.3*cos(beta_ws(j)))*sin(alfa_ws(i))];
            z_min = [z_min l1-0.3*sin(beta_ws(j))];
        end
    end
end

x_ws = [x_max x_cil x_min];
y_ws = [y_max y_cil y_min];
z_ws = [z_max z_cil z_min];
end

