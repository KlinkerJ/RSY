function q_mod = toolbox2(pos, eul, q0)

ur3e = loadrobot("universalUR3e");
gik = generalizedInverseKinematics;
gik.RigidBodyTree = ur3e;
gik.ConstraintInputs = {'position', 'orientation'};
posTgt = constraintPositionTarget('tool0');
%posTgt.TargetPosition = [0.15 0.15 0.15];
posTgt.TargetPosition = pos;
orientationCon = constraintOrientationTarget('tool0');
orientationCon.TargetOrientation = eul2quat(eul);
q0_form = homeConfiguration(ur3e);
q0_form(1).JointPosition = q0(1);
q0_form(2).JointPosition = q0(2);
q0_form(3).JointPosition = q0(3);
q0_form(4).JointPosition = q0(4);
q0_form(5).JointPosition = q0(5);
q0_form(6).JointPosition = q0(6);
[q, solutionInfo] = gik(q0_form,posTgt,orientationCon);
q_mod = [q(1).JointPosition, q(2).JointPosition, q(3).JointPosition, q(4).JointPosition, q(5).JointPosition, q(6).JointPosition];
end