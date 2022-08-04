function [S,M01,M12,M23] = Rotation_Matrixes_AAA(Q,L)
% Calculates the reciprocal position of the joints with resspect with 
% the previous link, and at the end returns the last column of M03 which contains
% the position of the gripper with respecto of the absolute origin

    a = Q(1);
    b = Q(2);
    c = Q(3);
    
    l1 = L(1);
    l2 = L(2);
    l3 = L(3);
    

    % Matrice del link 1 rispetto a link 0:
    
    M01 = [cos(a),-sin(a), 0, 0;
           sin(a), cos(a), 0, 0;
            0,       0,    1, 0;    % se si vuolesse spostare il primo giunto modifica l1+h
            0,       0,    0, 1];
    

    % Matrice del link 2 rispetto a link 1:
    
    M12 = [cos(b),   0,  sin(b),  l2*cos(b);
            0,       1,    0,         0;
           -sin(b),  0,  cos(b),  -l2*sin(b);
            0,       0,    0,         1];
    
        
    % Matrice del link 3 rispetto a link 2:

    M23 = [cos(c),-sin(c), 0, l3*cos(c);
           sin(c), cos(c), 0, l3*sin(c);
            0,       0,    1, 0;
            0,       0,    0, 1];
    
    
    % Matrice completa link 0 a 3:

    M03 = M01*M12*M23;
    

    % Vettore contenente posizione in cartesiano X, Y, Z:
    S = M03(:,4);

    
end

