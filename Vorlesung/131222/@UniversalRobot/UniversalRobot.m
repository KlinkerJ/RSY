classdef UniversalRobot < handle
    properties
        name
        alphaArr
        d
        a
        theta
        DHall
        Socket_conn
        Robot_IP
        Port_NR
        acc = 0.3;
        vel = 0.5;
        radius = 0.001;
    end 
    methods
        function obj = UniversalRobot(name, alphaArr, d, a, theta, Robot_IP, Port_NR)
            % set variables
            obj.name = name;
            obj.alphaArr = alphaArr;
            obj.d = d;
            obj.a = a;
            obj.theta = theta;
            obj.DHall = load_DH_matrices(obj);
            obj.Robot_IP = Robot_IP;
            obj.Port_NR = Port_NR;
            
            % create connection to Robot
            obj.Socket_conn = tcpip(obj.Robot_IP, obj.Port_NR);
            fclose(obj.Socket_conn); % ggf. bestehende Verbindung schließen
            pause(2);
            fprintf(1, 'Verbindungsaufbau mit UR3...\n');
            try
                fopen(obj.Socket_conn);
            catch
                error('Verbindungsaufbau fehlgeschlagen.');
            end
            fprintf(1, 'Verbindung mit UR3 hergestellt.\n');            
        end

        function show_name(obj)
            disp(obj.name);
        end

        function obj = moveJ(obj, pos_new, eul_new)
            my_theta = inverse_kinematics(obj, pos_new, eul_new);
            obj.theta = my_theta;
            send_command_to_robot(obj, 'moveJ');
        end

        function obj = moveL(obj, pos_new, eul_new)
            my_theta = inverse_kinematics(obj, pos_new, eul_new);
            obj.theta = my_theta;
            send_command_to_robot(obj, 'moveL');
        end

        function send_command_to_robot(obj, move)   % move must be 'moveJ' or 'moveL'
            cmd_string = [move, '([' num2str(obj.theta(1)) ', ' num2str(obj.theta(2)) ', ' num2str(obj.theta(3)) ', ' num2str(obj.theta(4))...
                ', ' num2str(obj.theta(5)) ', ' num2str(obj.theta(6)) '], ' num2str(obj.acc) ', ' num2str(obj.vel) ', ' num2str(0)...
                ', ' num2str(obj.radius) ')'];
            fprintf(obj.Socket_conn, cmd_string);

            % wait for the robot to reach target
            data = ones(1,48);
            Stillstandswerte = zeros(1,48);
            checkvalue = data;
            while ~isequal(Stillstandswerte,checkvalue)
                IPP = tcpclient(obj.Robot_IP,obj.Port_NR);
                data = read(IPP,500,"int8");
                checkvalue = data(61:108);
            end
        end

        % functions mit eigenem file müssen scheinbar nicht gelistet werden
    end
end