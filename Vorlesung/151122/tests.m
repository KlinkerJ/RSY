%We need 3 vectors for ikSolverUR3() as well as for our ik_matlab
%The input pos is a 3x1 vector with x-, y-, z-coordinate for the desired position of the end-effector.
%The input eul is a 3x1 vector with the desired orientation of the end-effector in euler angles (Z,Y,X).
%The input q is the previous configuration (joint angles) of the robot (6x1 vector).

load_DH_matrices;
load_constants_UR3E;

pos = [0.2, 0.2, 0.15]; % cartesion positions for endeffector in m
eul = [pi/2, pi/2, pi/2]; % orientation (euler) for endeffector in rad
theta_prev = [pi, pi, pi, pi, pi, pi]; % joint angles in rad
%thetaArr = ik_matlab_beispiel(pos, eul, theta_prev) %WARNING: This script (pulled via moodle) is using UR3 parameters, our robot is an UR3e
thetaArr = ik_matlab_ur(pos, eul, theta_prev, alphaArr, a, d);
[pos2, eul2] = fk_matlab_ur(thetaArr, DHall);
%disp(ret)
disp(pos2);
disp(eul2);

thetaArr = ikSolverUR3(pos, eul, theta_prev);
[pos2, eul2] = fk_matlab_ur(thetaArr, DHall);
%disp(ret)
disp(pos2);
disp(eul2);

pos = [0.2, 0.2, 0.15]; % cartesion positions for endeffector in m
eul = [-0.1, 1.5, -0.15]; % orientation (euler) for endeffector in rad
theta_prev = [pi, pi, pi, pi, pi, pi]; % joint angles in rad
%thetaArr = ik_matlab_beispiel(pos, eul, theta_prev) %WARNING: This script (pulled via moodle) is using UR3 parameters, our robot is an UR3e
thetaArr = ik_matlab_ur(pos, eul, theta_prev, alphaArr, a, d);
global solutions
disp(solutions)
for i = 1:length(solutions)
    [pos2, eul2] = fk_matlab_ur(solutions(i,:), DHall);
    disp(eul2)
end

%[pos2, eul2] = fk_matlab_ur(thetaArr, DHall);
%disp(ret)
%disp(pos2);
%disp(eul2);

%thetaArr = ikSolverUR3(pos, eul, theta_prev);
%disp(solutions);
%[pos2, eul2] = fk_matlab_ur(thetaArr, DHall);
%disp(ret)
%disp(pos2);
%disp(eul2);

r = eul2rotm([1, 1.6, 0])
b = angle2dcm(1, 1.6, 0)
rotm2eul(r)
