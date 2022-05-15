function Jp = JacP_AAA(Q,Qp,L)
% Jacobiano punto di un robot 3 assi

    l1 = L(1);     l2 = L(2);     l3 = L(3);
    a = Q(1);      b = Q(2);      c = Q(3);
    ap = Qp(1);    bp = Qp(2);    cp = Qp(3);
    
    Jp = zeros(3,3);


    Jp(1,1) = -l2*ap*cos(a)*cos(b)+l2*bp*sin(a)*sin(b) + l3*ap*sin(a)*sin(c)-l3*cp*cos(a)*cos(c) - l3*ap*cos(a)*cos(b)*cos(c)+l3*bp*sin(a)*sin(b)*cos(c)+l3*cp*sin(a)*cos(b)*sin(c);   
    Jp(1,2) = l2*ap*sin(a)*sin(b)-l2*bp*cos(a)*cos(b) + l3*ap*sin(a)*sin(b)*cos(c)-l3*bp*cos(a)*cos(b)*cos(c)+l3*cp*cos(a)*sin(b)*sin(c);
    Jp(1,3) = -l3*ap*cos(a)*cos(c)+l3*cp*sin(a)*sin(c) + l3*ap*sin(a)*cos(b)*sin(c)+l3*bp*cos(a)*sin(b)*sin(c)-l3*cp*cos(a)*cos(b)*cos(c); 
    
    Jp(2,1) = -l2*ap*sin(a)*cos(b)-l2*bp*cos(a)*sin(b) - l3*ap*cos(a)*sin(c)-l3*cp*sin(a)*cos(c) - l3*ap*sin(a)*cos(b)*cos(c)-l3*bp*cos(a)*sin(b)*cos(c)-l3*cp*cos(a)*cos(b)*sin(c);
    Jp(2,2) = -l2*ap*cos(a)*sin(b)-l2*bp*sin(a)*cos(b) - l3*ap*cos(a)*sin(b)*cos(c)-l3*bp*sin(a)*cos(b)*cos(c)+l3*cp*sin(a)*sin(b)*sin(c);   
    Jp(2,3) = -l3*ap*sin(a)*cos(c)-l3*cp*cos(a)*sin(c) - l3*ap*cos(a)*cos(b)*sin(c)+l3*bp*sin(a)*sin(b)*sin(c)-l3*cp*sin(a)*cos(b)*cos(c);

    Jp(3,1) = 0;   
    Jp(3,2) = l2*bp*sin(b) + l3*bp*sin(b)*cos(c)+l3*cp*cos(b)*sin(c);   
    Jp(3,3) = l3*bp*cos(b)*sin(c)+l3*cp*sin(b)*cos(c);
    

end
