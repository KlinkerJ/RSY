%% Main
% Stellt die Verbindung zwischen UR3 und PC her, lädt Positionenliste,
% fährt UR3 in Ausgangsposition "Kerze", öffnet Gripper

clear all
bootUp
positionen

load_constants_UR3E;
load_DH_matrices;

decision = input("Drücke k, falls Du die Kerzenposition anfahren möchtest", "s");
if decision == "k"
    BewWinkel = Kerze;
    Gripper = 0;
    moveIt
else
    %POS1
    % pos = [0.128, 0.04, 0.311]
    % eul = [0.845, -1.5, -4.89]
    %TEST POS THETA6
    %BewWinkel = ikSolverUR3(pos, eul, qPre);
    pos = [-0.085, -0.165, 0.694]
    eul = [ 0.2, 0.2, 0.2] % has to be in RZ, RY, RX
    % POS1 Test 2
    %pos = [0.128, 0.04, 0.711]
    %eul = [-4.89, -1.5, 0.845]  %RZ ist um Pi verschoben, RY und RX um Pi/4
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
    %disp(thetaArr)
    Gripper = 0;
    moveIt
end

% x 128mm, y 39mm, z -87mm
% rx 1,672 ry -0749 rz 1.646

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