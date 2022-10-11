%We need 3 vectors for ikSolverUR3()
%The input pos is a 3x1 vector with x-, y-, z-coordinate for the desired position of the end-effector.
%The input eul is a 3x1 vector with the desired orientation of the end-effector in euler angles (Z,Y,X).
%The input q is the previous configuration (joint angles) of the robot (6x1 vector).

a = [1,1,1]; % cartesion positions for endeffector in mm
b = [pi, pi, pi]; % orientation (euler) for endeffector in rad 
c = [pi, pi, pi, pi, pi, pi]; % joint angles in rad

ik_matlab_beispiel(a,b,c)