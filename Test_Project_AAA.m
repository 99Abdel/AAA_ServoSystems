clear all
close all
clc


syms a b c l1 l2 l3;

M01 = [cos(a),-sin(a), 0, 0;
       sin(a), cos(a), 0, 0;
        0,       0,    1, l1;
        0,       0,    0, 1];


% matrice del link 2 rispetto a link 1

M12 = [cos(b),   0,  sin(b), l2*cos(b);
        0,       1,    0,    0;
      -sin(b),   0,  cos(b), -l2*sin(b);
        0,       0,    0,    1];


% matrice del link 3 rispetto a link 2

M23 = [cos(c),-sin(c), 0, l3*cos(c);
       sin(c), cos(c), 0, l3*sin(c);
        0,       0,    1, 0;
        0,       0,    0, 1];


M02 = M01*M12;
M03 = M02*M23;

M03(:,4)

X = M03(1,4);
Y = M03(2,4);
Z = M03(3,4);


Jac = [diff(X,'a'), diff(X,'b'), diff(X,'c');
       diff(Y,'a'), diff(Y,'b'), diff(Y,'c');
       diff(Z,'a'), diff(Z,'b'), diff(Z,'c');];

syms a(t) b(t) c(t);

Jacp = diff(Jac,'t');




%% trovare angoli per cui Jacobiano nullo


detJ = det(Jac);

for a = 0:360
    %a = a*pi/180;
    
    for b = 0:360
        %b = b*pi/180;
        
        for c = 0:360
            %c = c*pi/180;
            
            result = l3^3*cos(a)^2*cos(b)^3*cos(c)^2*sin(c) - l3^3*cos(b)*cos(c)^2*sin(a)^2*sin(c) - l3^3*cos(a)^2*cos(b)*cos(c)^2*sin(c) + l3^3*cos(b)^3*cos(c)^2*sin(a)^2*sin(c) + l2^2*l3*cos(a)^2*cos(b)^3*sin(c) + l2^2*l3*cos(b)^3*sin(a)^2*sin(c) - l2*l3^2*cos(a)^2*cos(b)*cos(c)*sin(c) - l2*l3^2*cos(b)*cos(c)*sin(a)^2*sin(c) + l3^3*cos(a)^2*cos(b)*cos(c)^2*sin(b)^2*sin(c) + l3^3*cos(b)*cos(c)^2*sin(a)^2*sin(b)^2*sin(c) + 2*l2*l3^2*cos(a)^2*cos(b)^3*cos(c)*sin(c) + l2^2*l3*cos(a)^2*cos(b)*sin(b)^2*sin(c) + 2*l2*l3^2*cos(b)^3*cos(c)*sin(a)^2*sin(c) + l2^2*l3*cos(b)*sin(a)^2*sin(b)^2*sin(c) + 2*l2*l3^2*cos(a)^2*cos(b)*cos(c)*sin(b)^2*sin(c) + 2*l2*l3^2*cos(b)*cos(c)*sin(a)^2*sin(b)^2*sin(c);

            if -1 < result %&& result <1
                if result <1
                
                    display 'Configurazione singolarità:'
                    display(a)
                    display(b)
                    display(c)

                end
            end
        end
    end
end


