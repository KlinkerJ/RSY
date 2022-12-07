% file muss außerhalb des Ordners @UR3E sein

robot = UR3E;

% test function
robot.test_function(robot.name)

% load DH parameter
robot.DH_matrices = robot.load_DH_matrices;
disp(robot.DH_matrices)

% load constants
[robot.alphaArr, robot.d, robot.a] = robot.load_constants_UR3E;
disp(robot.alphaArr)
disp(robot.d)
disp(robot.a)

% load constand positions
positions = robot.load_positions;
disp(positions)

% calc ik angles
pos = [0.25, 0.25, 0.15];
eul = [0, pi, 0]; 
qPre = [0; -pi/2 ;0; 0; pi/2; pi/2];
robot.ik_angles = robot.inverse_kinematics(pos,eul,qPre,robot.alphaArr,robot.a, robot.d);
disp(robot.ik_angles)

robot.drive(robot.ik_angles)

disp(robot)


% weitere functions notwendig:
% bootUp
% moveIt
% fk zum debuggen?!

% & anschließend das ganze in einen ROS Node einpacken

% theoretisch auch Oberklasse UR3 mit Unterklassen UR3E möglich

