function [S,Sp,Spp,TT] = LookAhead_AAA(n,N,L,ss,Vt,Vn,A,D)
% look ahead è una generalizzazione della 3 tratti, prendere il percorso e
% rappresentarlo a tratti per ogni tratto mettere velocità maxima da
% raggiungere stesso ragionamento alla fine, andamaneto velotaà in funzione
% della distanza da trasformare in velocità in funzione del tempo
% generalizzare la tre tratti in modo da partire da velocità v1 e finire a
% velocità v2  non per forza uguali a zero.

% n numero archi
% N numero punti in ciascun arco

    Vn_f1 = zeros(1,n+1); % vettore velocità nodi da assumere
    
    V_ast = zeros(1,n); % vettore velocità tratti v costanti.

    ta = zeros(1,n); % tempo per accelerazione
    tb = zeros(1,n); % tempo per velocità costante
    tc = zeros(1,n); % tempo per decelerazione

    sa = zeros(1,n); % spazio percorso in accelerazione
    sb = zeros(1,n); % spazio percorso a velocità costante.
    sc = zeros(1,n); % spazio percorso in decelerazione

    % sono vettori perchè si era pensato di sfruttarli meglio in futuro per
    % maggiori complessità
    s_tot = zeros(1,n); % delta spazio percorso
    t_tot = zeros(1,n); % tempo totale impiegato per percorre tutti gli archi

    l = zeros(1,n); % spazio totale da percorrere nell'arco
    t = zeros(1,n); % tempo totale impiegato per percorre un arco


    % Look Ahead fasi Set Velocità nodi
    % Fase 1
    vel = min(Vn(1),Vt(1)); % scegliere il minimo della velocità tra nodo iniziale e tratto adiacente a v cost
    Vn_f1(1) = min(vel);

    for i = 2:n

        vel = [Vn(i),Vt(i-1),Vt(i)];
        Vn_f1(i) = min(vel); % scegliere il minimo della velocità tra nodo e tratti adiacenti a v cost

    end

    vel = min(Vn(n+1),Vt(n));
    Vn_f1(n+1) = min(vel); % scegliere il minimo della velocità tra nodo finale e tratto adiacente a v cost


    % Fase 2
    for i = 1:n

        Vnf = sqrt(Vn_f1(i)^2 + 2*A*L(i)); % percorro la traiettoria alla max accelerazione con v iniziale computata alla fase 1 immaginando di poter accelerare di colpo, trovo v finale
        vel = [Vn_f1(i+1),Vnf];
        Vn_f1(i+1) = min(vel); % minimo velocita tra quella nella fase 1 Vn_f1(i+1) e quella computata adesso Vnf

    end

    % Fase 3
    for i = n:-1:1

        Vni = sqrt(Vn_f1(i+1)^2 + 2*D*L(i)); % percorro la traiettoria alla max decelerazione con v finale computata alla fase 1 immaginando di poter deccelerare di colpo, trovo v iniziale
        vel = [Vn_f1(i),Vni];
        Vn_f1(i) = min(vel); % minimo velocita tra quella nella fase 1 Vn_f1(i+1) e quella computata adesso Vni

    end


    % Look Ahead fase Calcolo Tempi
    for i = 1:n

        ta(i) = (Vt(i)-Vn_f1(i))/A; % tempo accelerazione
        tc(i) = (Vt(i)-Vn_f1(i+1))/D; % tempo decelerazione 

        sa(i) = (Vt(i)+Vn_f1(i))*ta(i)/2; % spazio percorso accelerazione
        sc(i) = (Vn_f1(i+1)+Vt(i))*tc(i)/2; % spazio percorso decelerazione
        sb(i) = L(i) - sa(i) - sc(i); % spazio rimanente da percorre a velocità costante

        tb(i) = sb(i)/Vt(i); % tempo velocita costante

        if(tb(i) < 0) % se il tempo velocità costante è negativo allora il tratto a velocità costane non esiste

            V_ast(i) = sqrt((Vn_f1(i)^2*D + Vn_f1(i+1)^2*A + 2*A*D*L(i))/(A+D)); % velocità max raggiunginbile di picco

            ta(i) = (V_ast(i)-Vn_f1(i))/A;
            tb(i) = 0;
            tc(i) = (V_ast(i)-Vn_f1(i+1))/D;

            sa(i) = (V_ast(i)+Vn_f1(i))*ta(i)/2;
            sb(i) = 0;
            sc(i) = (V_ast(i)+Vn_f1(i+1))*tc(i)/2;

        end
        
        % per Sviluppi futuri in caso di maggiori complessità
        l(i) = sa(i) + sb(i) + sc(i); % spazio totale percorso che deve essere uguale alla lunghezza arco
        t(i) = ta(i) + tb(i) + tc(i); % tempo totale impioegato

        if i == 1 % se primo ciclo i dati sono esattametne quelli appena calcolati
           s_tot(i) = l(i); 
           t_tot(i) = t(i);
        else % se cicli susccesivi si sommano i contributi di ciascun ciclo man mano
            s_tot(i) = s_tot(i-1) + l(i);
            t_tot(i) = t_tot(i-1) + t(i);
        end

    end
    

    shift = ss(1); % traslazione distanza da origine (è importante il Ds)

    S = []; % vettore spazio percorso complessivo
    Sp = []; % vettore velocità assunta compessiva 
    Spp = []; % vettore accelerrazione assunta compessiva  

    TT = []; % vettore dei tempi 
  

    for i = 1:n % numero archi

        % vettori di spostamento velocità  e acc totali nei 2 archi in funzione del tempo
        [s,sp,spp,tt] = treTrattiValues_AAA(shift,Vn_f1(i),Vt(i),Vn_f1(i+1),A,D,ta(i),tb(i),tc(i),N);
        
        shift = s(end); % traslazione dello spazio per il prossimo ciclo

        % salvataggio dati
        S = [S s]; 
        Sp = [Sp sp];
        Spp = [Spp spp];

        if i == 1 % al primo ciclo il tempo è quello computato
            TT = [TT tt];
        else % nei cicli successivi si calcola il tempo di percorrenza e si aggiunge lo shift temporale del ciclo precendente
            TT = [TT TT(end)+tt];
        end

    end
    

    
% (esempio per plottare la velocità in funzione dello spazio)   

% va bene solo se S e L partono entrambi da 0 e sono crescenti...
%     LL(1)=0;
%     LL(2)=L(1);
%     VV(1)=Vt(1);
%     VV(2)=Vt(1);
%     for i=2:n
%         LL(2*i-1)=LL(2*i-2);
%         LL(2*i)=LL(2*i-1)+L(i);
%         VV(2*i-1)=Vt(i);
%         VV(2*i)=Vt(i);
%     end
% 
%     figure
%     plot(LL,VV,S,Sp)
%     legend("Velocità Tratto","Velocità Reale","Location","best")
%     title("Velocita in funzione dello spazio")
%     xlabel("spazio")
%     ylabel("velocità")
%     grid on


end

