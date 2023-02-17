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

ubergabemovej = ['movej([' num2str(q(1)) ', ' num2str(q(2)) ', ' num2str(q(3)) ', ' num2str(q(4))...
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

data = ones(1,48);
Stillstandswerte = zeros(1,48);
checkvalue = data;
while ~isequal(Stillstandswerte,checkvalue)
    IPP = tcpclient(Robot_IP,Port_NR);
    data = read(IPP,500,"int8");
    checkvalue = data(61:108);
    %pause(0.01);
    %debug = 'Ich warte.';     % debug tool kann anzeigen ob die Schleife
                                % durchläuft
    %disp(debug)
end


%% Gripper
% Hier wird der Gripperstate als Variable überprüft

%if Gripper == 0
%    ubergabegrip = 'set_tool_digital_out(0,False)';
%    fprintf(Socket_conn,ubergabegrip)
%    pause(1)
%end

%if Gripper == 1
%    ubergabegrip = 'set_tool_digital_out(0,True)';
%    fprintf(Socket_conn,ubergabegrip)
%    pause(1)
%end

%% qPre
% Zuletzt erhält qPre die soeben angefahrene Position

qPre = q;