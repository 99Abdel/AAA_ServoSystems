function [Jcap] = pseudoInertia(J,m)

    Ixy = -J(1,2); 
    Ixz = -J(1,3); 
    Iyz = -J(2,3);

    Ix_x = (-J(1,1)+J(2,2)+J(3,3))/2;
    Iy_y = (J(1,1)-J(2,2)+J(3,3))/2;
    Iz_z = (+J(1,1)+J(2,2)-J(3,3))/2;
    
    Jcap = [Ix_x Ixy Ixz 0;
            Ixy  Iy_y Iyz 0;
            Ixz  Iyz  Iz_z 0;
            0    0     0   m];

end

