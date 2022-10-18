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
        syms acosValue
        assume(acosValue, 'real')
        assumeAlso(acosValue <= 1)
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
    
    % ------------------------------ Theta 3 ------------------------------ 
    t5 = [1 3];
    theta6Index = 1:4;
    t6 = 1;
    theta3_ = zeros(8,1);
    P14_ = zeros(8,3);
    T14_ = zeros(4,4,8);
    idx = 1;
    for t1 = 1:length(theta1)
        for sign = [1 -1]
            [P14, T14] = calculateTheta3(T06, alphaArr, a, d, theta1(t1), theta5(t5(t1)), theta6(t5(t1)))
            [theta3, P14, T14] = calculateTheta3(T06, alphaArr, a, d, theta1(t1), theta5(t5(t1)), theta6(t5(t1)));
            theta3(idx) = sign * theta3;
            P14_(idx,:) = P14';
            T14_(:,:,idx) = T14;
            idx = idx + 1;
            
            [theta3, P14, T14] = calculateTheta3(T06, alphaArr, a, d, theta1(t1), theta5(t5(t1)+1), theta6(t5(t1)+1));
            theta3(idx) = sign * theta3;
            P14_(idx,:) = P14';
            T14_(:,:,idx) = T14;
            idx = idx + 1;
        end     
        t6 = t6 + 1;
    end
    
    %Reagrange so lists match.
    rearangeIdx = [1 3 2 4 5 7 6 8];
    theta3_Copy = theta3_;
    P14_Copy = P14_;
    T14_Copy = T14_;
    for i = 1:length(rearangeIdx)
        theta3_Copy(i) = theta3_(rearangeIdx(i));
        P14_Copy(i,:) = P14_(rearangeIdx(i),:);
        T14_Copy(:,:,i) = T14_(:,:,rearangeIdx(i));
    end
    theta3_ = theta3_Copy;
    P14_ = P14_Copy;
    T14_ = T14_Copy;


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

function [theta3, P14, T14] = calculateTheta3(T06, alpha_, a, d, theta1, theta5, theta6)
    [P14, T14] = calculateP14(T06, alpha_, a, d, theta1, theta5, theta6);
    
    P14_xz_length = norm([P14(1) P14(3)]);
    
    %Before calculating theta3 we have to check conditions mentioned in the
    %paper. The conditions are
    conditions = [abs(a(2)-a(3));
                  abs(a(2)+a(3))];
    
    % if P14_xz_length > conditions(1) && P14_xz_length < conditions(2)
    %    theta3 = acos((P14_xz_length^2 - a(2)^2 -a(3)^2)/(2*a(2)*a(3)));
    % else %If this happens all the time, maybe just set theta3 to zero.
    %    theta3=0;
    %     error('Theta3 can not be determined. Conditions are not uphold. P14_xz_length is exceding the condidtions.')
    % end
    theta3 = acos((P14_xz_length^2 - a(2)^2 -a(3)^2)/(2*a(2)*a(3)));
end

function [P14, T14] = calculateP14(T06, alpha_, a, d, theta1, theta5, theta6)
    
    T01 = DH2tform(0, 0, d(1), theta1);
    T10 = inv(T01);
    
    T45 = DH2tform(alpha_(4), a(4), d(5), theta5);
    T54 = inv(T45);
    
    
    T56 = DH2tform(alpha_(5), a(5), d(6), theta6);
    T65 = inv(T56);
    
    
    T14 = T10*T06*T65*T54;
    P14 = T14(1:3,4);
end

function Transform = DH2tform(alpha_, a, d, theta)
    syms Transform [4 4] 
    
    alpha_mi = alpha_; 
    a_mi = a; 
    d_i = d; 
    theta_i = theta; 
    
    % Row 1 
    Transform(1,1) = cos(theta_i);
    Transform(1, 2) = -sin(theta_i); 
    Transform(1, 3) = 0; 
    Transform(1, 4) = a_mi; 
    
    % Row 2
    Transform(2, 1) = sin(theta_i)*cos(alpha_mi); 
    Transform(2, 2) = cos(theta_i) *cos(alpha_mi); 
    Transform(2, 3) = -sin(alpha_mi); 
    Transform(2, 4) = -sin(alpha_mi)*d_i; 
    
    % Row 3 
    Transform(3, 1) = sin(theta_i)*sin(alpha_mi); 
    Transform(3, 2) = cos(theta_i)*sin(alpha_mi); 
    Transform(3, 3) = cos(alpha_mi); 
    Transform(3, 4) = cos(alpha_mi) *d_i; 
end