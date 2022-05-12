%% Begin
clear all
close all

%% Dati

L = [100, 100, 100];
Si = [100, 100, 100];
Sf = [15, 15, 70];
N_figure = 1;

%% Inverse Configuration

Qi1 = AntropomorphousInv(Si,L,1);
Qi2 = AntropomorphousInv(Si,L,2);
Qi3 = AntropomorphousInv(Si,L,3);
Qi4 = AntropomorphousInv(Si,L,4);

Si1 = AntropomorphousDir(Qi1,L);
Si2 = AntropomorphousDir(Qi2,L);
Si3 = AntropomorphousDir(Qi3,L);
Si4 = AntropomorphousDir(Qi4,L);

Qf1 = AntropomorphousInv(Sf,L,1);
Qf2 = AntropomorphousInv(Sf,L,2);
Qf3 = AntropomorphousInv(Sf,L,3);
Qf4 = AntropomorphousInv(Sf,L,4);

Sf1 = AntropomorphousDir(Qf1,L);
Sf2 = AntropomorphousDir(Qf2,L);
Sf3 = AntropomorphousDir(Qf3,L);
Sf4 = AntropomorphousDir(Qf4,L);



%% Plot configurations
figure
hold on
PlotAntropomorphous(Qi1,L,"r")
PlotAntropomorphous(Qi2,L,"b")
PlotAntropomorphous(Qi3,L,"y")
PlotAntropomorphous(Qi4,L,"g")
hold off


figure
hold on
PlotAntropomorphous(Qf1,L,"r")
PlotAntropomorphous(Qf2,L,"b")
PlotAntropomorphous(Qf3,L,"y")
PlotAntropomorphous(Qf4,L,"g")
hold off


