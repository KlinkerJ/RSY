ur3e = loadrobot("universalUR3e");
randConfig = ur3e.randomConfiguration;
tform = getTransform(ur3e,randConfig,'flange','base');
disp(tform)
ik = inverseKinematics("RigidBodyTree", ur3e);

weights = [0.25 0.25 0.25 1 1 1];
initialguess = ur3e.homeConfiguration;
[configSoln, solnInfo] = ik('flange', tform,weights,initialguess)
%configSoln.JointPosition