%% Hier sind grundlegende Positionen hinterlegt, die
%% zu Testzwecken angefahren werden können
% die Positionen sind in der Winkelschreibweise angegeben:
% dabei steht jede Zahl der 1x6 Matrix für einen Gelenkwinkel des UR3.
% Die ersten 3 Winkel beziehen sich auf die Hauptachsen,
% die hinteren 3 auf die Ausrichtung des TCP bzw.
% der Ausrichtung des Greifers


%% Position Kerze
% Kerze ist notwendig für fehlerfreies BootUp; Rest kann nach Belieben
% ein-/auskommentiert werden
Kerze = [0;-pih;0;0;pih;pih];

%% Rechter Winkel mit dem Greifer nach unten ausgerichtet
% RechGU = [0;-pih;pih;0;pih;pih];

%% Rechter Winkel mit dem Greifer nach oben ausgerichtet
% RechGO = [0;-pih;pih;pi;-pih;pih];

%% kleine Kerze vorne (hierbei wird er erste Abschnitt waagerecht gekippt)
% KlKerzeVorne = [0;0;-pih;0;pih;pih];

%% kleine Kerze hinten (hierbei wird er erste Abschnitt waagerecht gekippt)
% KlKerzeHinten = [0;-pi;pih;0;pih;pih];

%% Vor den tisch greifen nach oben
% VorTischOben = [-piv;0;0;-pih;pih;pih];

%% Vor den tisch greifen nach unten
% VorTischUnten = [-piv;-pia;0;-pih;-pih;pih];