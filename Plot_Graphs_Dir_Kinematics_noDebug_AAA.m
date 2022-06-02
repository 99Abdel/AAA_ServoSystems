function Plot_Graphs_Dir_Kinematics_noDebug_AAA(S,Sp,Spp,tt)
% Plots graphs with data position of gripper x,y,z linear speed and acceleration.


    figure
    plot(tt,S(1,:),tt,Sp(1,:),tt,Spp(1,:))
    legend("x","xp","xpp")
    title("Cartesian Data X")
    grid on

    figure
    plot(tt,S(2,:),tt,Sp(2,:),tt,Spp(2,:))
    legend("y","yp","ypp")
    title("Cartesian Data Y")
    grid on

    figure
    plot(tt,S(3,:),tt,Sp(3,:),tt,Spp(3,:))
    legend("z","zp","zpp")
    title("Cartesian Data Z")
    grid on


end

