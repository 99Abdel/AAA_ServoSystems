function Plot_Graphs_Inv_Kinematics_AAA(Q,Qp,Qpp,tt,dT)
% Plots graphs with data position of gripper x,y,z angular speed and acceleration.
    
    % calcolo dei valori teorici di velocità e accelerazione 
    [Qpt(1,:),Qppt(1,:)] = theorethicalDiff(Q(1,:),dT);
    [Qpt(2,:),Qppt(2,:)] = theorethicalDiff(Q(2,:),dT);
    [Qpt(3,:),Qppt(3,:)] = theorethicalDiff(Q(3,:),dT);

    m = length(Qpt(1,:));
    mp = length(Qppt(1,:));

    figure
    plot(tt,Q(1,:),tt,Qp(1,:),tt,Qpp(1,:),tt(1:m),Qpt(1,1:m),"--",tt(1:mp),Qppt(1,1:mp),"--")
    legend("a","ap","app","ap#","app#")
    title("Joint Data Alpha")
    grid on

    figure
    plot(tt,Q(2,:),tt,Qp(2,:),tt,Qpp(2,:),tt(1:m),Qpt(2,1:m),"--",tt(1:mp),Qppt(2,1:mp),"--")
    legend("b","bp","bpp","bp#","bpp#")
    title("Joint Data Beta")
    grid on

    figure
    plot(tt,Q(3,:),tt,Qp(3,:),tt,Qpp(3,:),tt(1:m),Qpt(3,1:m),"--",tt(1:mp),Qppt(3,1:mp),"--")
    legend("c","cp","cpp","cp#","cpp#")
    title("Joint Data Gamma")
    grid on


end

