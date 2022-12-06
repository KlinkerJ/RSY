global Socket_conn;
global Robot_IP;
global Port_NR;

%% Grundparameter
% hier werden die Grundparameter für die Bewegung MOVEJ festgelegt
% hier werden auch die Bewegungswinkel an den Movej Befehl übergeben

q = BewWinkel;
a = 0.3;
v = 0.5;
t = 0;
r = 0.001;

% ubergabemovej = ['movej([' num2str(q(1)) ', ' num2str(q(2)) ', ' num2str(q(3)) ', ' num2str(q(4))...
%     ', ' num2str(q(5)) ', ' num2str(q(6)) '], ' num2str(a) ', ' num2str(v) ', ' num2str(t)...
%     ', ' num2str(r) ')'];

ubergabemovej = ['movel([' num2str(q(1)) ', ' num2str(q(2)) ', ' num2str(q(3)) ', ' num2str(q(4))...
', ' num2str(q(5)) ', ' num2str(q(6)) '], ' num2str(a) ', ' num2str(v) ', ' num2str(t)...
', ' num2str(r) ')'];
% hier wird der fertige MoveJ code an die Ip übergeben
fprintf(Socket_conn,ubergabemovej)

% whos data      %whos data kann beutzt werden um sich alle data in 
                %data ausgeben zu lassen


%% Funktion für das warten
% movej Befehle können von einem neuen MoveJ Befehl überchrieben werden.
% Um das zu verhindern, wird eine while Schleife geschrieben
%% Wie geht das?
% Der UR3 gibt auf der IP unter dem port 30003 durchgehend 1060
% verschiedene Werte aus, was der Roboter gerade macht.
% Interessant sind in diesem Fall die TARGET JOINT VELOCITIES;
% solange diese nicht 0 sind, will der UR3 sich noch bewegen.
% Die while Schleife greift die Daten ab und vergleicht sie mit dem 0
% array Stillstandswerte.


qPre = q;