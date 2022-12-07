classdef UR3E
    properties
        name = 'Anton'
        DH_matrices
        alphaArr
        d
        a
        ik_angles
    end 

    methods

        function test_function(obj, name)
            disp(name);
        end

        function drive(obj, angles)
            disp('move to anlges:');
            disp(angles);
        end

        % functions mit eigenem file müssen scheinbar nicht gelistet werden
    end
end