function [x,xp,xpp]=look_ahead(t,T,S,lambda1,lambda3)
% Legge di moto Look ahead (acc. e dec. costante)
% Partendo da una velocità iniziale definita si calcola il transitorio di
% accelerazione e decelerazione per arrivare a una velocità finale data
%
% t tempo per cui calcolare la legge
% T tempo di azionamento
% S vettore traiettoria
% l1 lambda1 (durata 1^ intervallo/T  0<l1<1)
% l3 lambda3 (durata 3^ intervallo/T  0<l3<1)


    Amax_robot = 10;      % dovremmo dargli un valore di targa

    % devo suddividere il tempo in due parti doverse per capire se è
    % possibile raggiungere la velocità massima

    V_tot = Vi+Vf;
    percentuale_Acc = Vi/Vtot;
    percentuale_Dec = Vf/Vtot;

    % calcolo l'accelerazione e decelerazione massima nei rispettivi tratti
    Amax_tratto = (percentuale_Acc*n)/(percentuale_Acc*T)^2;
    Dmax_tratto = (percentuale_Dec*n)/(percentuale_Dec*T)^2;

    
    if Amax_tratto > Amax_robot

        % il robot non raggiungerà la velocità max
        A_tratto = Amax_robot;

    else

        A_tratto = Amax_tratto;

    end


    if Dmax_tratto > Amax_robot

        % il robot non raggiungerà la velocità max
        D_tratto = -Amax_robot;

    else

        D_tratto = -Dmax_tratto;

    end

    
    % dobbiamo decidere se dargli sempre la Amax e quindi usare un tratto
    % di velocità max elevato o se usare la Amax richiesta dal tratto e far
    % curve più dolci


    Vmax_acc = Vi+A_tratto*percentuale_Acc*T;
    Vmax_dec = Vmax_acc+D_tratto*percentuale_Dec*T;


    

    % Tretratti
    V = dS/T*2/(2-lambda1-lambda3);
    A = dS/T^2*2/(lambda1*(2-lambda1-lambda3));
    D = dS/T^2*2/(lambda3*(2-lambda1-lambda3));
    
    T1=T*lambda1;
    T2=T*(1-lambda1-lambda3);
    Ta=T1+T2;
    
    
    if t < T_acc
    
       x=1/2*A*t^2+S0;
       xp=A*t;
       xpp=A;
    

      else
       

       if t < T_V_cost
    
          x=1/2*A*T1^2+V*(t-T1)+S0;
          xp=V;
          xpp=0;
    
       else   % t decelerazione
    
          x=1/2*A*T1^2+V*T2+V*(t-Ta)-1/2*D*(t-Ta)^2+S0;
          xp=V-D*(t-Ta);
          xpp=-D;
    
       end
    
    end


end
           