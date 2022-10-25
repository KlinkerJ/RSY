%We need 3 vectors for ikSolverUR3() as well as for our ik_matlab
%The input pos is a 3x1 vector with x-, y-, z-coordinate for the desired position of the end-effector.
%The input eul is a 3x1 vector with the desired orientation of the end-effector in euler angles (Z,Y,X).
%The input q is the previous configuration (joint angles) of the robot (6x1 vector).

load_constants_UR5E;

a = [0.2, 0.1, 0.3]; % cartesion positions for endeffector in mm
b = [pi, pi, pi]; % orientation (euler) for endeffector in rad
c = [pi, pi, pi, pi, pi, pi]; % joint angles in rad

%ik_matlab_beispiel(a, b, c) %WARNING: This script (pulled via moodle) is using UR3 parameters, our robot is an UR5e
thetaArr = ik_matlab_ur5e(a, b, c);

ret = fk_matlab_ur5e(thetaArr);
disp(ret)