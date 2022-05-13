function WS2D_AAA(L,Qmax,Qmin,assi)
% Calcolo dei Punti del Workspace 3D

    if assi==1

        circ = linspace(0,2*pi,1000)';
        circ_ext = [(L(2)+L(3))*cos(circ) (L(2)+L(3))*sin(circ)];
        circ_int = [(L(2)-L(3))*cos(circ) (L(2)-L(3))*sin(circ)];
        
        area_x = [circ_int(:,1); circ_ext(:,1)];
        area_y = [circ_int(:,2); circ_ext(:,2)];
        
        figure
        plot(circ_int(:,1),circ_int(:,2),'color',[0.5 0.9 0.6],'LineWidth',2)
        hold on
        patch(area_x,area_y,[0.5 0.9 0.6],'EdgeColor','none')
        alpha 0.3       % conferisce trasparenza al disegno/oggetto
        plot(circ_ext(:,1),circ_ext(:,2),'color',[0.5 0.9 0.6],'LineWidth',2)
        
        Plot_AAA(Qmax,L)    % plot robot in max position
        Plot_AAA(Qmin,L)    % plot robot in min position
        
        grid on
        axis equal
        xlabel('x')
        ylabel('y')
        xlim([-8 8])    % limite area visualizzata, ampiezza max l2+l3 = 7
        ylim([-8 8])    % limite area visualizzata, ampiezza max l2+l3 = 7
        title("Robot's Working Area (PLANE XY / TOP VIEW)")
        hold off

      else
        
        % da sistemare pc scarico...
        circ = linspace(0,2*pi,1000)';
        circ_ext = [(L(2)+L(3))*cos(circ) (L(2)+L(3))*sin(circ)];
        circ_int = [(L(2)-L(3))*cos(circ) (L(2)-L(3))*sin(circ)];

        area_x = [circ_int(:,1); circ_ext(:,1)];
        area_z = [circ_int(:,2); circ_ext(:,2)];



        circ1 = linspace(pi/2,-pi/2,1000)';
        circ2 = linspace(-pi/2,pi/2,1000)';
        
        area = [b+0.6*cos(circ1) a+0.6*sin(circ1);
               -b-0.6*cos(circ2) a+0.6*sin(circ2);
                             b               1.6];
        
        C = [               -b              0.4;
             -b-0.3*cos(circ2) a+0.3*sin(circ2);
                            -b             1.6];
        
        D = [              b              0.4;
            b+0.3*cos(circ2) a+0.3*sin(circ2);
                           b             1.6];
        
        figure
        patch(area(:,1),area(:,2),[0.5 0.9 0.6],'EdgeColor',[0.5 0.9 0.6],'LineWidth',2)
        hold on
        alpha 0.3
        plot(C(:,1),C(:,2),'color',[0.5 0.9 0.6],'LineWidth',2);
        plot(D(:,1),D(:,2),'color',[0.5 0.9 0.6],'LineWidth',2);
        plot([0 0.2],[1 1],'k','LineWidth',2)
        plot([0 0],[0 1],'k','LineWidth',2)
        plot([0.2 0.5],[1 1.4],'k','LineWidth',2)
        plot(0.2,1,'ok','LineWidth',1.5)
        grid on
        axis equal
        xlabel('x')
        ylabel('z')
        xlim([-1 1])
        ylim([0 1.8])
        title("Robot's Working Area (PLANE XZ / SIDE VIEW)")

    end


end
