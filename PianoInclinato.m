function [N01,N02,N03,N12,N23] = PianoInclinato(S,gamma)
% Crea un piano inclinato di gamma rispetto ad ogni asse, e con origine in S (x,y,z)

    xp2 = S(1,end);
    yp2 = S(2,end);
    zp2 = S(3,end);
    
    N01 = [1,            0,             0,   -xp2;
           0,   cos(gamma),   -sin(gamma),   -yp2;
           0,   sin(gamma),    cos(gamma),   -zp2;
           0,            0,             0,     1];
    
    N12 = [ cos(gamma),   0,    sin(gamma),   0;
                     0,   1,             0,   0;
           -sin(gamma),   0,    cos(gamma),   0;
                     0,   0,             0,   1];
    
    N23 = [cos(gamma),   -sin(gamma),   0,   0;
           sin(gamma),    cos(gamma),   0,   0;
                    0,             0,   1,   0;
                    0,             0,   0,   1];
    

    N03 = N01*N12*N23;

    N02 = N01*N12;


end

