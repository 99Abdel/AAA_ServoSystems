function WS2D_AAA(L,Qmax,Qmin,assi)
% Calcolo dei Punti del Workspace 2D

    circ = linspace(0,2*pi,1000)';

    if assi == "xy"
        % coordinate circonferenza esterna e interna
        circ_ext = [(L(2)+L(3))*cos(circ) (L(2)+L(3))*sin(circ)];
        circ_int = [(L(2)-L(3))*cos(circ) (L(2)-L(3))*sin(circ)];

      elseif assi == "xz" || assi == "yz"
        % coordinate circonferenza esterna e interna
        circ_ext = [(L(2)+L(3))*cos(circ) L(1)+(L(2)+L(3))*sin(circ)];
        circ_int = [(L(2)-L(3))*cos(circ) L(1)+(L(2)-L(3))*sin(circ)];

    end

        % area tra circonferenza esterna e interna (da sfumare poi nel plot)
        area_x = [circ_int(:,1); circ_ext(:,1)];
        area_y = [circ_int(:,2); circ_ext(:,2)];
        
        figure
        hold on
        plot(circ_int(:,1),circ_int(:,2),'color',[0.5 0.9 0.6],'LineWidth',2)
        patch(area_x,area_y,[0.5 0.9 0.6],'EdgeColor','none')
        alpha 0.3       % conferisce trasparenza al disegno/oggetto
        plot(circ_ext(:,1),circ_ext(:,2),'color',[0.5 0.9 0.6],'LineWidth',2)
        
        Plot_AAA(Qmax,L,assi)    % plot robot in max position
        Plot_AAA(Qmin,L,assi)    % plot robot in min position
        
        grid on
        axis equal
        xlabel(strcat(assi(1)," [m]"))
        ylabel(strcat(assi(2),' [m]'))
        title("Robot's Working Area (PLANE " + assi + ")")
        hold off


end
