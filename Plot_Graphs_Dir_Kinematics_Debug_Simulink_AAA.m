function Plot_Graphs_Dir_Kinematics_Debug_Simulink_AAA(Ss,Sps,Spps,tts,S,Sp,Spp,tt)
% Plots graphs with data position of gripper x,y,z linear speed and acceleration.


    figure
    plot(tts,Ss(1,:),tts,Sps(1,:),tts,Spps(1,:),tt,S(1,:),tt,Sp(1,:),tt,Spp(1,:))
    legend("xs","xps","xpps","x","xp","xpp")
    title("Cartesian Data X")
    grid on

    figure
    plot(tts,Ss(2,:),tts,Sps(2,:),tts,Spps(2,:),tt,S(2,:),tt,Sp(2,:),tt,Spp(2,:))
    legend("ys","yps","ypps","y","yp","ypp")
    title("Cartesian Data Y")
    grid on

    figure
    plot(tts,Ss(3,:),tts,Sps(3,:),tts,Spps(3,:),tt,S(3,:),tt,Sp(3,:),tt,Spp(3,:))
    legend("zs","zps","zpps","z","zp","zpp")
    title("Cartesian Data Z")
    grid on


end

