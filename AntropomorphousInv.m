function Q = AntropomorphousInv(S,L,sol)
%Antropomorfo cinematica inv. robot SCARA

    Q=zeros(3,1);

    x = S(1);  y = S(2);  z = S(3);
    l1 = L(1);  l2=L(2);  h = L(3); 

    z1 = z - h;

    if (sol == 1)
        
        a = atan2(y,x);
        rho = x*cos(a) + y*sin(a);
        g = acos((x^2+y^2+z1^2-l1^2-l2^2)/(2*l1*l2));
        
    elseif (sol == 2)
        
        a = atan2(y,x) + pi;
        rho = x*cos(a) + y*sin(a);
        g = acos((x^2+y^2+z1^2-l1^2-l2^2)/(2*l1*l2));
    
    elseif (sol == 3)
        
        a = atan2(y,x);
        rho = x*cos(a) + y*sin(a);
        g = -acos((x^2+y^2+z1^2-l1^2-l2^2)/(2*l1*l2));
    
    else
        
        a = atan2(y,x) + pi;
        rho = x*cos(a) + y*sin(a);
        g = -acos((x^2+y^2+z1^2-l1^2-l2^2)/(2*l1*l2));
        
    end    
    
    b = pi/2 - atan2(z1,rho) - atan2(l2*sin(g),l1+l2*cos(g));
    
    Q = [a; b; g];
    
end
