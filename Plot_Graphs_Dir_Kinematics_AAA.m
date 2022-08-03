function Plot_Graphs_Dir_Kinematics_AAA(S,Sp,Spp,tt,dT)
% Plots graphs with data position of gripper x,y,z linear speed and acceleration.

    % calcolo dei valori teorici di velocità e accelerazione 
    [Spt(1,:),Sppt(1,:)] = theorethicalDiff(S(1,:),dT);
    [Spt(2,:),Sppt(2,:)] = theorethicalDiff(S(2,:),dT);
    [Spt(3,:),Sppt(3,:)] = theorethicalDiff(S(3,:),dT);

    m = length(Spt(1,:));
    mp = length(Sppt(1,:));

    figure
    plot(tt,S(1,:),tt,Sp(1,:),tt,Spp(1,:),tt(1:m),Spt(1,1:m),"--",tt(1:mp),Sppt(1,1:mp),"--")
    legend("x","xp","xpp","xp#","xpp#")
    title("Cartesian Data X")
    ylabel('m - m/s - m/s^2')
    xlabel('time [s]')
    grid on

    figure
    plot(tt,S(2,:),tt,Sp(2,:),tt,Spp(2,:),tt(1:m),Spt(2,1:m),"--",tt(1:mp),Sppt(2,1:mp),"--")
    legend("y","yp","ypp","yp#","ypp#")
    title("Cartesian Data Y")
    ylabel('m - m/s - m/s^2')
    xlabel('time [s]')
    grid on

    figure
    plot(tt,S(3,:),tt,Sp(3,:),tt,Spp(3,:),tt(1:m),Spt(3,1:m),"--",tt(1:mp),Sppt(3,1:mp),"--")
    legend("z","zp","zpp","zp#","zpp#")
    title("Cartesian Data Z")
    ylabel('m - m/s - m/s^2')
    xlabel('time [s]')
    grid on


end

