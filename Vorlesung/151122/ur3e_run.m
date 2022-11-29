%% Main

clear all;

% connect to ur3e
bootUp

% load position and robot params
positionen;
load_DH_matrices;
load_constants_UR3E;


decision = input("Drücke k, kv, 1 oder d ", "s");
if decision == "k"
    BewWinkel = Kerze;

elseif decision == 'kv'
        BewWinkel = KlKerzeVorne;

elseif decision == 'h'
    BewWinkel = HomeUnten;

elseif decision == '1'
    % folgende position kann korrekt angefahren werden:
    pos = [-0.15, -0.15, 0.5]
    eul = [0, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
elseif decision == '2'
    % folgende position kann korrekt angefahren werden:
    pos = [-0.25, -0.25, 0.5]
    eul = [0, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
elseif decision == '3'
    pos = [-0.15, -0.15, 0.4]
    eul = [0.2, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
elseif decision == '4'
    % folgende position kann korrekt angefahren werden:
    pos = [-0.15, -0.15, 0.3]
    eul = [0, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
elseif decision == '5'
    % folgende position kann korrekt angefahren werden:
    pos = [0.15, 0.15, 0.3]
    eul = [0, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
elseif decision == '6'
    % folgende position kann korrekt angefahren werden:
    pos = [0.15, -0.15, 0.3]
    eul = [0, pi, pi/6] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
elseif decision == '7'
    % folgende position kann korrekt angefahren werden:
    pos = [0.118, -0.304, 0.304];
    posNeg = [-0.118, 0.304, 0.404];
    eul = [pi, pi, 0.0]; % has to be in RZ, RY, RX,
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    BewWinkelAlt = toolbox2(posNeg, eul, qPre);
    disp(BewWinkelAlt)
    %disp(BewWinkel)
elseif decision == '8'
    % folgende position kann korrekt angefahren werden:
    pos = [-0.168, 0.304, 0.304]
    eul = [0.0, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = toolbox2(pos, eul, qPre);
    disp(BewWinkel)
elseif decision == 'l'
    % folgende position kann korrekt angefahren werden:
    pos = [0.085, 0.0132, 0.070]
    eul = [0.1, 0.1, 0.1] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    disp(BewWinkel)
elseif decision == 'd'
    BewWinkel = Kerze;
    moveIt
    load_constants_UR3E; %has to be loaded between each position drive
    pos = [-0.15, -0.15, 0.5]
    eul = [0, pi, 0] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    moveIt
elseif decision == 't' 
    pos = [-0.2404, -0.15838, 0.37692]
    eul = [-0.092, -2.116, 2.316] % has to be in RZ, RY, RX
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    fk_matlab_ur(BewWinkel, DHall)
    %moveIt
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