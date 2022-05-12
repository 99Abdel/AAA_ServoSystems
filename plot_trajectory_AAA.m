function plot_trajectory_AAA(Qi,Qf,L,X,Y,Z,n,N_figure,titolo,T)
% aggiungere un nono elemento di tempo per avere il plot animato di durata
% T

    Argomenti = 9;
    N_figure = N_figure +1;

    PlotSurface_AAA(L,N_figure)
    hold on
    Plot_AAA(Qi,L,'r',N_figure)
    
    if nargin > Argomenti
        dt = T/n;
        
        for i = 1:n
            plot3(X(i),Y(i),Z(i),'->b')
            pause(dt)
        end
        
    else
         plot3(X,Y,Z,'->b')
    end
    
    Plot_AAA(Qf,L,'r',N_figure)
    title(titolo)
    
end

