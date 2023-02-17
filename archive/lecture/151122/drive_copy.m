function drive_copy(pos, eul, qPre, alphaArr, a, d)
    global BewWinkel
    BewWinkel = ik_matlab_ur(pos, eul, qPre, alphaArr, a, d);
    moveIt_copy
end