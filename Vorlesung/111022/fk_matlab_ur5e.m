function pos = fk_matlab_ur5e(thetaArr)
    
    load_DH_matrices;
    load_constants_UR5E;

    %(theta1, theta2, theta3, theta4, theta5, theta6) = thetaArr;
    theta1 = thetaArr(1);
    theta2 = thetaArr(2);
    theta3 = thetaArr(3);
    theta4 = thetaArr(4);
    theta5 = thetaArr(5);
    theta6 = thetaArr(6);
    
    
    temp = subs(DHall);
    disp(DHall);
    pos = temp(1:3,4);
    pos = double(pos);
end
