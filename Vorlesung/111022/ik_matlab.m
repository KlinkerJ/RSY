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
    syms theta5 [4 1] % create symbolic 4x1 matrix 
    idx = 1;
    for i = 1:length(theta1)
        %syms acosValue
        %assume(acosValue, 'real')
        %assumeAlso(acosValue <= 1)
        acosValue = (P06(1)*sin(theta1(i)) - P06(2)*cos(theta1(i)) - d(4))/d(6); % (formula 12 [1])
        %if acosValue > 1            % acos will not fail, so check if result is imaginary
        %    acosValue = NaN;        % set value to Nan -> all following quations with this value will return also NaN
        %end
        for sign = [1 -1]           
            theta5(idx) = sign * acos(acosValue);                               % (formula 12 [1])
            idx = idx + 1;
        end
    end

    % ------------------------------ Theta 6 ------------------------------ 
    T60 = inv(T06);     % (formula 13 [1]) 
    Y60 = T60(1:3,2);   % (formula 13 [1])
    X60 = T60(1:3,1);    

    syms theta6 [4 1] % create symbolic 4x1 matrix
    theta6(1) = calculateTheta6(X60, Y60, theta1(1), theta5(1)); % (formula 16 [1])
    theta6(2) = calculateTheta6(X60, Y60, theta1(1), theta5(2)); % (formula 16 [1])
    theta6(3) = calculateTheta6(X60, Y60, theta1(2), theta5(3)); % (formula 16 [1])
    theta6(4) = calculateTheta6(X60, Y60, theta1(2), theta5(4)); % (formula 16 [1])


end     

function theta6_ = calculateTheta6(X60_, Y60_, theta1_, theta5_) % (formula 15-16 [1])
    theta6_ = 0;
    if sin(theta5_) ~= 0
        leftNumerator = -X60_(2)*sin(theta1_) + Y60_(2)*cos(theta1_);           % (formula 15 [1])
        rightNumerator = X60_(1)*sin(theta1_) - Y60_(1)*cos(theta1_);           % (formula 15 [1])
        denominator = sin(theta5_);                                             % (formula 16 [1])
        theta6_ = atan2(leftNumerator/denominator, rightNumerator/denominator); % (formula 16 [1])
    end
end