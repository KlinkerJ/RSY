function q = ikSolver(pos, eul, qprevios) % (copied from ik_matlab_beispiel but adapted to UR5e)
    
    % Formula numbers according to: 
    % [1] Kinematics of a UR5, Rasmus Skovgaard Andersen, Aalborg University (s. IK_kommentiert.pdf)
    
    load_constants_UR5E; % load robot parameter into workspace
    load_DH_matrices; % load robot DH into workspace


    % Finding end effector related to base.
    T06 = eye(4);                   % creating 4x4 identity matrix 
    T06(1:3,1:3) = eul2rotm(eul);   % write rotations in the upper left corner of the matrix
    T06(1:3,4) = pos;               % write position on the right side of the matrix
    P06 = T06(1:3,4);               % origin of frame 6

    % ------------------------------ Theta 1 ------------------------------ 
    % Theta1 = 2 solutions, isn't depended on other angles.
    
    P05 = T06 * [0;0;-d(6);1];              % origin of frame 5 (formula 5 [1])
    phi1 = atan2(P05(2),P05(1));            % (formula 7 [1])

    if P05(1) ~= 0 || P05(2) ~= 0           % unequality because square root would fail if both are zero (zero under square root)
        phi2P = acos(d4/sqrt(P05(1)^2+P05(2)^2))    % (formula 8 [1])
        phi2N = -phi2P                              % (formula 8 [1])
        theta1P = phi1 + phi2P + pi/2;          % (formula 9 [1])
        theta1N = phi1 + phi2N + pi/2;          % (formula 9 [1])
    else
        theta1P = phi1 + pi/2;
        theta1N = phi1 + pi/2;
    end        
    theta1 = [theta1P;theta1N]  
     
    % ------------------------------ Theta 5 ------------------------------ 

end 