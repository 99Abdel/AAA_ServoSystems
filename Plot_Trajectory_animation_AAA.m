function Plot_Trajectory_animation_AAA(Q,S,L,n,T,tipo)

    dt = T/n;

    figure
    hold on
    title(["Traiettoria Robot " tipo])
    grid on
    axis equal
    pbaspect([20 20 20])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    for i = 1:n
        plot3(S(1,i),S(2,i),S(3,i),'->m')
        Plot_AAA(Q(:,i),L,"xyz")
        pause(dt)
        %delete(Q(:,i))
    end
       
    hold off
    
end

