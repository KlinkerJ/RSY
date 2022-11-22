global Socket_conn; global UR3_connected;


%% startup
% Stellt LAN-Verbindung zwischen UR3 und Desktop-PC her

if(UR3_connected == false) return; end
% Eintragen der IP des Roboters. Port 30003 steht für
% dauerhaftes empfangen und senden
Robot_IP = '192.168.1.2';
Port_NR = 30003;
Socket_conn = tcpip(Robot_IP,Port_NR);
fclose(Socket_conn); % ggf. bestehende Verbindung schließen
pause(2);
fprintf(1, 'Verbindungsaufbau mit UR3...\n');
try
    fopen(Socket_conn);
catch
    error('Verbindungsaufbau fehlgeschlagen.');
    pause(2);
    return;
end
fprintf(1, 'Verbindung mit UR3 hergestellt.\n');
pause(2);

%% bootup
% Legt verschiedene Variablen an

% Variablen für die einfache Schreibweise von pi/2 etc.
pih= pi/2;
piv = pi/4;
pia = pi/8;

pos = [0 0 0]; % Startwert zur Definition der Variable; nicht anfahren!
eul = [0 0 -pi]; % 1: rot Z-achse, 2: rot Y-achse, 3: rot X-achse
qPre = [0;-pih;0;0;pih;pih]; % = Kerze; qPre für ersten moveIt-Befehl
Gripper = 1; % Startwert zur Defintion der Variable; 1: zu, 0: offen

bootsuccess = 'Bootsequenz abgeschlossen :)';
disp(bootsuccess)