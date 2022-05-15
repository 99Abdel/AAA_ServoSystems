function [Q,iter] = newtonRaphson(S,Q0,L,toll,Nmax)
    
    Q = Q0;
    S0 = Direct_Kinematics_AAA(Q,L);
    J = Jac_AAA(Q,L);
    delta = abs(S-S0);

    iter = 0;

    while (norm(delta) > toll) & (iter < Nmax)
        
        S0 = Direct_Kinematics_AAA(Q,L);
        J = Jac_AAA(Q,L);
        delta = abs(S-S0);
        Q = Q+J\(S-S0);
        Q(1) = mod(Q(1)+pi,2*pi)-pi;
        Q(2) = mod(Q(2)+pi,2*pi)-pi;
        Q(3) = mod(Q(3)+pi,2*pi)-pi;
    
        iter = iter+1;

    end

end