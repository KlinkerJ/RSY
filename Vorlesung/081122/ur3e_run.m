%% Main

clear all;

% connect to ur3e
bootUp

% load position and robot params
positionen;
load_constants_UR3E;
load_DH_matrices;


decision = input("Drücke k, falls Du die Kerzenposition anfahren möchtest ", "s");
if decision == "k"
    BewWinkel = Kerze;

elseif decision == 'kv'
        BewWinkel = KlKerzeVorne;

elseif decision == '1'
    % folgende position kann korrekt angefahren werden:
    pos = [-0.15, -0.15, 0.5]
    eul = [0, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)

else
    %POS1
    % pos = [0.128, 0.04, 0.311]
    % eul = [0.845, -1.5, -4.89]
    %TEST POS THETA6
    %BewWinkel = ikSolverUR3(pos, eul, qPre);
    %pos = [-0.085, -0.165, 0.694]
    %eul = [ 0.2, 0.2, 0.2] % has to be in RZ, RY, RX
    % folgende position kann korrekt angefahren werden:
    pos = [-0.085, -0.132, 0.509]
    eul = [0, 0, 0] % has to be in RZ, RY, RX
    % POS1 Test 2
    %pos = [0.128, 0.04, 0.711]
    %eul = [-4.89, -1.5, 0.845]  %RZ ist um Pi verschoben, RY und RX um Pi/4
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)

end

% move the ur
moveIt