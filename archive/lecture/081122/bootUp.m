global Socket_conn; global UR3_connected;

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

bootsuccess = 'Bootsequenz abgeschlossen :)';
disp(bootsuccess)