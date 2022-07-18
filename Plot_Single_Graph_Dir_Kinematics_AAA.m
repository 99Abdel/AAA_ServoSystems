function Plot_Single_Graph_Dir_Kinematics_AAA(S,Sp,Spp,tt,dT)
% Plots graphs with data position of gripper x,y,z linear speed and acceleration.

    % calcolo dei valori teorici di velocità e accelerazione 
    [Spt,Sppt] = theorethicalDiff(S,dT);
    m = length(Spt(1,:));
    mp = length(Sppt(1,:));

    figure
    plot(tt,S,tt,Sp,tt,Spp,tt(1:m),Spt(1,1:m),"--",tt(1:mp),Sppt(1,1:mp),"--",[tt(1) tt(end)], [0 0],'k')
    legend("s","sp","spp","sp#","spp#","Location","best")
    title("Cartesian Data S")
    grid on


end

