%rosshutdown
%pause(2)
%srosinit

clear all;
name = "A";
Robot_IP = '192.168.1.2';
Port_NR = 30003;

% create node for robot A and connect to ros master
node = ros.Node('/RobotANode', '192.168.1.18');

% init Publisher for robot status
pub_status = ros.Publisher(node, '/RobotANode/status', 'std_msgs/String');

% init Subscriber for Camera information
sub_position = ros.Subscriber(node, '/CameraANode/circlePosition', 'geometry_msgs/Vector3');
sub_status = ros.Subscriber(node, '/CameraANode/status', 'std_msgs/String');

% init Subscriber for common release with robot B
sub_release = ros.Subscriber(node, '/Release', 'std_msgs/String');

% define types for messages
status_msg = rosmessage('std_msgs/String');
% position_msg = rosmessage('std_msgs/String'); not needed

% load UR3E constants and initialise UR class object
[alphaArr, d, a, theta] = load_constants_UR3E(); % alpha is a predefined MatLab funtion therefore we named the parameter alpha alphaArr
myRobot = UniversalRobot(name, alphaArr, d, a, theta, Robot_IP, Port_NR);
myRobot.show_name();

% drive to Kerze by sending values for all 6 axis
myRobot.theta = [0; -pi / 2; 0; 0; pi / 2; pi / 2];
myRobot.send_command_to_robot('movej');

% publish robot staus
status_msg.Data = 'kerze';
send(pub_status, status_msg);

% drive to init and publish init status
pos_new = [-0.15, -0.15, 0.30];
eul_new = [0, pi, 0];
myRobot.moveJ(pos_new, eul_new);
status_msg.Data = 'init';
send(pub_status, status_msg);

% wait for camera to detect circle position
a = 0
while a == 0

    try
        % recieve status from camera node
        camera_status_message = receive(sub_status);

        % recieve 'geometry_msgs/Vector3' from camera node
        camera_position_message = receive(sub_position, 10); 
        disp(camera_position_message)

        % leave loop it status == 'detected'
        if strcmp(camera_status_message.Data, 'detected')
            a = 1
        end

    end

end

disp('detected')

% drive to home
pos_new = [0.0, -0.4, 0.2];
eul_new = [0, pi, -pi / 4]; % Drehung
myRobot.moveJ(pos_new, eul_new);

% publish home status
status_msg.Data = 'home';
send(pub_status, status_msg);

% drive to vector3 position, but vertically above
pos_new = [camera_position_message.X, camera_position_message.Y, camera_position_message.Z + 0.1];
myRobot.moveJ(pos_new, eul_new);
% drive down to vector3 position
% first change speed
myRobot.set_velocity(0.2)
myRobot.set_acceleration(0.2)
pos_new = [camera_position_message.X, camera_position_message.Y, camera_position_message.Z];
myRobot.moveL(pos_new, eul_new);


% wait to grip
r = input("Please confirm grip")

% drive to circle points and grip manually

% wait for release message
b = 0
disp("Waiting for Release")

while b == 0
    % publishing 'gripped' as long as no release is received
    status_msg.Data = 'gripped';
    send(pub_status, status_msg);
    try
        release_message = receive(sub_release, 30);
        disp(release_message)

        if strcmp(release_message.Data, 'true')
            b = 1
        end

    end

end

% publish status (and position) while driving
% the position we should drive to is missing here
status_msg.Data = 'driving';
send(pub_status, status_msg);

% drive up from vector3 position
pause(0.3) % time delay for synchronized lifting with Robot B
pos_new = [camera_position_message.X, camera_position_message.Y, camera_position_message.Z + 0.105];
myRobot.moveL(pos_new, eul_new);

% set finished
status_msg.Data = 'finished';
send(pub_status, status_msg);

pause(1)
