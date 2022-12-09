% file muss außerhalb des Ordners @UR3E sein
clear all;
name = "Anton";
Robot_IP = '192.168.1.2';
Port_NR = 30003;
[alphaArr, d, a, theta] = load_constants_UR3E();    % alpha is a predefined MatLab funtion therefore we named the parameter alpha alphaArr
myRobot = UniversalRobot(name, alphaArr, d, a, theta, Robot_IP, Port_NR);

% test function
myRobot.show_name();

pos_new = [-0.085, -0.165, 0.694];
eul_new = [ 0.2, 0.2, 0.2];

tic()
myRobot.moveJ(pos_new, eul_new);
toc()

