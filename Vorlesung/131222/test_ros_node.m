%rosshutdown
%pause(2)
%srosinit
clear all;
name = "A";
Robot_IP = '192.168.1.2';
Port_NR = 30003;

node = ros.Node('/RobotANode');

pub_status = ros.Publisher(node, '/RobotANode/status', 'std_msgs/String');

%sub_position = ros.Subscriber(node, '/CameraANode/circlePosition', 'std_msgs/String');
sub_position = ros.Subscriber(node, '/CameraANode/circlePosition', 'geometry_msgs/Vector3');
sub_status = ros.Subscriber(node, '/CameraANode/status', 'std_msgs/String');
sub_release = ros.Subscriber(node, '/Release', 'std_msgs/String');

status_msg = rosmessage('std_msgs/String');
position_msg = rosmessage('std_msgs/String');
release_msg = rosmessage('std_msgs/String');
%position_msg = rosmessage('geometry_msgs/Vector3');

% Class wird initialisiert, dann:
[alphaArr, d, a, theta] = load_constants_UR3E(); % alpha is a predefined MatLab funtion therefore we named the parameter alpha alphaArr
myRobot = UniversalRobot(name, alphaArr, d, a, theta, Robot_IP, Port_NR);

% drive to Kerze
myRobot.theta = [0; -pi / 2; 0; 0; pi / 2; pi / 2];
myRobot.show_name();
myRobot.send_command_to_robot('movej');
status_msg.Data = 'kerze';
send(pub_status, status_msg);

% drive to init
pos_new = [-0.15, -0.15, 0.30];
eul_new = [0, pi, 0];
myRobot.moveJ(pos_new, eul_new);

% publish init status
status_msg.Data = 'init';
send(pub_status, status_msg);

% wait for camera to detect circles
a = 0

while a == 0

    try
        camera_status_message = receive(sub_status);
        camera_position_message = receive(sub_position, 10);
        disp(camera_position_message)

        %we should check if the position message is correct size array
        if strcmp(camera_status_message.Data, 'detected')
            a = 1
        end

    end

end

disp('detected')

% drive to home
pos_new = [0.0, -0.4, 0.2];
eul_new = [0, pi, 0];
myRobot.moveJ(pos_new, eul_new);
pos_new = [0.1, -0.40, 0.1];
eul_new = [0, pi, -pi / 4];
myRobot.moveJ(pos_new, eul_new);

% publish home status
status_msg.Data = 'home';
send(pub_status, status_msg);

% hier zu vect3 position fahren!!
pos_new = [camera_position_message.X, camera_position_message.Y, camera_position_message.Z];
disp(pos_new);
%eul_new = [0, pi, -pi/4];
myRobot.moveJ(pos_new, eul_new);

% wait to grip
r = input("Please confirm grip")

% drive to circle points and grip manually
status_msg.Data = 'gripped';
send(pub_status, status_msg);

% wait for release message
b = 0

while b == 0

    try
        release_message = receive(sub_release, 30);
        disp(release_message)

        if strcmp(release_message.Data, 'true')
            b = 1
        end

    end

end

% publish status (and position) while driving
status_msg.Data = 'driving';
send(pub_status, status_msg);

% set finished
status_msg.Data = 'finished';
send(pub_status, status_msg);

pause(1)
