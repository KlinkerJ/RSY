%% Hier sind grundlegende Positionen hinterlegt, die
%% zu Testzwecken angefahren werden können
% die Positionen sind in der Winkelschreibweise angegeben:
% dabei steht jede Zahl der 1x6 Matrix für einen Gelenkwinkel des UR3.
% Die ersten 3 Winkel beziehen sich auf die Hauptachsen,
% die hinteren 3 auf die Ausrichtung des TCP bzw.
% der Ausrichtung des Greifers


% Variablen für die einfache Schreibweise von pi/2 etc.
pih= pi/2;
piv = pi/4;
pia = pi/8;

pos = [0 0 0]; % Startwert zur Definition der Variable; nicht anfahren!
eul = [0 0 -pi]; % 1: rot Z-achse, 2: rot Y-achse, 3: rot X-achse
qPre = [0;-pih;0;0;pih;pih]; % = Kerze; qPre für ersten moveIt-Befehl
Gripper = 1; % Startwert zur Defintion der Variable; 1: zu, 0: offen


%% Position Kerze
% Kerze ist notwendig für fehlerfreies BootUp; Rest kann nach Belieben
% ein-/auskommentiert werden
Kerze = [0;-pih;0;0;pih;pih];

%% Rechter Winkel mit dem Greifer nach unten ausgerichtet
% RechGU = [0;-pih;pih;0;pih;pih];

%% Rechter Winkel mit dem Greifer nach oben ausgerichtet
% RechGO = [0;-pih;pih;pi;-pih;pih];

%% kleine Kerze vorne (hierbei wird er erste Abschnitt waagerecht gekippt)
KlKerzeVorne = [0;0;-pih;0;pih;pih];

%% kleine Kerze hinten (hierbei wird er erste Abschnitt waagerecht gekippt)
% KlKerzeHinten = [0;-pi;pih;0;pih;pih];

%% Vor den tisch greifen nach oben
% VorTischOben = [-piv;0;0;-pih;pih;pih];

%% Vor den tisch greifen nach unten
% VorTischUnten = [-piv;-pia;0;-pih;-pih;pih];