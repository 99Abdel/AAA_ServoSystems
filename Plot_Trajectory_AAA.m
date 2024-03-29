function Plot_Trajectory_AAA(Qi,Qf,L,X,Y,Z,n,tipo,T)
% aggiungere un nono elemento di tempo per avere il plot animato di durata T

    Argomenti = 8;
    
    figure
    hold on
    Plot_AAA(Qi,L,"xyz");
    
    if nargin > Argomenti
        dt = T/n;
        
        for i = 1:n
            plot3(X(i),Y(i),Z(i),'->m');
            pause(dt)
        end
         
    else
         plot3(X,Y,Z,'->m');
    end
    
    Plot_AAA(Qf,L,"xyz");
    title(["Traiettoria Robot " tipo])
    
    grid on
    axis equal
    pbaspect([20 20 20])
    xlabel('x [m]')
    ylabel('y [m]')
    zlabel('z [m]')
    hold off
    
end

