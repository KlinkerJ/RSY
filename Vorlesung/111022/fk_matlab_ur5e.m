function pos = fk_matlab_ur5e(thetaArr)
    load_DH_matrices;
    load_constants_UR5E;
    [theta1, theta2, theta3, theta4, theta5, theta6] = thetaArr;
    temp = subs(DHall);
    disp(DHall);
    pos = temp(1:3,4);
end
