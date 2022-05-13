function [si,vi,ai]=settetratti_generica(ti,T,s0,Ds,v0,vf,acc,d,T1,T2,T3,T4,T5,T6,T7,sc,vc,A,D)

%Modello base per il calcolo discreto e continuo della legge di moto a
%sette tratti generica con accelerazione lineare a tratti

%function [si,vi,ai]=settetratti_generica(ti,T,s0,Ds,v0,vf,acc,d,T1,T2,T3,T4,T5,T6,T7)
%ti istante a cui calcolare i valori di si,vi,ai
%T tempo di azionamento totale
%s0 posizione iniziale
%Ds ampiezza totale dello spostamento
%v0 velocità iniziale
%vf velocità finale
%acc accelerazione iniziale
%d decelerazione finale
%T1 durata del primo tratto
%T2 durata del secondo tratto
%T3 durata del terzo tratto
%T4 durata del terzo tratto
%T5 durata del quinto tratto
%T6 durata del sesto tratto
%T7 durata del settimo tratto
%Tc vettore contenente la durata dei tratti
%sc vettore contenete gli spostamenti 
%vc vettore contenete le velocità
%sc vettore contenente i valori degli spostamenti in punti noti
%vc vettore contenente i valori delle velocità in punti noti
%A valore massimo dell'accelerazione
%D valore massimo dell'accelerazione negativa
%si spostamento 
%vi velocità 
%ai accelerazione


if ti<T1
        ai=acc*(1-ti/T1)+A*ti/T1;
        vi=v0+acc*(ti-ti^2/(2*T1))+A*ti^2/(2*T1);
        si=s0+v0*ti+acc*(ti^2/2-ti^3/(6*T1))+A*ti^3/(6*T1);
        
    
    else 
        if ti<=(T1+T2)
            tt=ti-T1;
            ai=A;
            vi=A*tt+vc(1);
            si=A*tt^2/2+sc(1)+vc(1)*tt;
            
            
        else
            if ti<(T1+T2+T3)
                tt=ti-T1-T2;
                ai=A*(1-tt/T3);
                vi=A*(tt-tt^2/(2*T3))+vc(2);
                si=A*(tt^2/2-tt^3/(6*T3))+sc(2)+vc(2)*tt;
                
                
            else
               if ti<=(T1+T2+T3+T4)
                  tt=ti-T1-T2-T3;
                  ai=0;
                  vi=vc(3);
                  si=sc(3)+vc(3)*tt;
                    
                    
               else
                    if ti<(T1+T2+T3+T4+T5)
                       tt=ti-T1-T2-T3-T4;
                       ai=D*tt/T5;
                       vi=D*tt^2/(2*T5)+vc(4);
                       si=D*tt^3/(6*T5)+sc(4)+vc(4)*tt;
                        
                        
                    else
                         if ti<=(T1+T2+T3+T4+T5+T6)
                             tt=ti-T1-T2-T3-T4-T5;
                             ai=D;
                             vi=D*tt+vc(5);
                             si=D*tt^2/2+sc(5)+vc(5)*tt;
                             
                             
                         else
                             tt=ti-T1-T2-T3-T4-T5-T6;
                             ai=D*(1-tt/T7)+d*tt/T7;
                             vi=D*(tt-tt^2/(2*T7))+d*tt^2/(2*T7)+vc(6);
                             si=D*(tt^2/2-tt^3/(6*T7))+d*tt^3/(6*T7)+sc(6)+vc(6)*tt;
                           
                             
                         end
                    end
               end
            end
        end
end

