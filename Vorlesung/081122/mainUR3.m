%% Main
% Stellt die Verbindung zwischen UR3 und PC her, lädt Positionenliste,
% fährt UR3 in Ausgangsposition "Kerze", öffnet Gripper

clear all
bootUp
positionen


BewWinkel = Kerze;
% BewWinkel = ikSolverUR3(pos, eul, qPre)

Gripper = 0;

moveIt

%% Mainfunktion mit Bewegungsbefehl aus inverser Kinematik
% clear all
% bootUp
% pos = [-200 200 50];
% BewWinkel = ikSolverUR3;
% Gripper = 0;
% moveIt

%% Mainfunktion mit mehreren Bewegungsbefehlen
% clear all
% positionen
% bootUp
% BewWinkel = Kerze;
% Gripper = 0;
% moveIt
% pos = [-100 200 10];
% BewWinkel = ikSolverUR3;
% moveIt
% Gripper = 1;
% moveIt
% BewWinkel = Kerze;
% moveIt