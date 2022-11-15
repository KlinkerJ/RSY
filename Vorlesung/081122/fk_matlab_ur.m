function [pos, eul] = fk_matlab_ur(thetaArr, DHall)
    theta1 = thetaArr(1);
    theta2 = thetaArr(2);
    theta3 = thetaArr(3);
    theta4 = thetaArr(4);
    theta5 = thetaArr(5);
    theta6 = thetaArr(6);
    
    pos_matrix = subs(DHall);
    pos = pos_matrix(1:3,4);
    pos = double(pos);
    eul = pos_matrix(1:3,1:3);
    eul = diag(double(eul));

end
