function [Q] = Inverse_Kinematics_AAA(S,L,n)

    x = S(1);    l1 = L(1);
    y = S(2);    l2 = L(2);
    z = S(3);    l3 = L(3);
    
    
    switch (n)
        
        case 1
            c = acos((x^2+y^2+(z-l1)^2-l3^2-l2^2)/(2*l2*l3));
            b = asin((l1-z)/(l2+l3*cos(c)));
            a = acos((x*(l2*cos(b)+l3*cos(b)*cos(c))+y*l3*sin(c))/((l3*sin(c))^2 + (l2*cos(b)+l3*cos(b)*cos(c))^2));
        
        case 2
            
            c = -acos((x^2+y^2+(z-l1)^2-l3^2-l2^2)/(2*l2*l3));
            b = asin((l1-z)/(l2+l3*cos(c)));
            a = acos((x*(l2*cos(b)+l3*cos(b)*cos(c))+y*l3*sin(c))/((l3*sin(c))^2 + (l2*cos(b)+l3*cos(b)*cos(c))^2));
         
        case 3
            
            c = acos((x^2+y^2+(z-l1)^2-l3^2-l2^2)/(2*l2*l3));
            b = asin((l1-z)/(l2+l3*cos(c)));
            b = choose_beta(b);
            a = -acos((x*(l2*cos(b)+l3*cos(b)*cos(c))+y*l3*sin(c))/((l3*sin(c))^2 + (l2*cos(b)+l3*cos(b)*cos(c))^2));

        case 4
            
            c = -acos((x^2+y^2+(z-l1)^2-l3^2-l2^2)/(2*l2*l3));
            b = asin((l1-z)/(l2+l3*cos(c)));
            b = choose_beta(b);
            a = -acos((x*(l2*cos(b)+l3*cos(b)*cos(c))+y*l3*sin(c))/((l3*sin(c))^2 + (l2*cos(b)+l3*cos(b)*cos(c))^2));
 
    end
    
    
    Q = [a,b,c];
    
    if(~isreal(Q))
        Q = [NaN,NaN,NaN];
        disp("Configurazione non raggiungibile")
    end


end

