%We need 3 vectors for ikSolverUR3() as well as for our ik_matlab
%The input pos is a 3x1 vector with x-, y-, z-coordinate for the desired position of the end-effector.
%The input eul is a 3x1 vector with the desired orientation of the end-effector in euler angles (Z,Y,X).
%The input q is the previous configuration (joint angles) of the robot (6x1 vector).

load_constants_UR5E;
load_DH_matrices;

pos = [0.1, 0.1, 0.15]; % cartesion positions for endeffector in mm
eul = [pi/2, pi, pi/8]; % orientation (euler) for endeffector in rad
theta_prev = [pi, pi, pi, pi, pi, pi]; % joint angles in rad

%thetaArr = ik_matlab_beispiel(pos, eul, theta_prev) %WARNING: This script (pulled via moodle) is using UR3 parameters, our robot is an UR5e
try
    thetaArr = ik_matlab_ur(pos, eul, theta_prev, alphaArr, a, d)

    [pos2, eul2] = fk_matlab_ur(thetaArr, DHall);
    %disp(ret)
    disp(pos2);
    disp(eul2);
catch
    warning("Can't calculate inverse kinematik, input pose is not valid");
end