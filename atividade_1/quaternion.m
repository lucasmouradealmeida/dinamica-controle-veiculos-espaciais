function [result] = quaternion(R)
    diag = trace(R);
    q0 = sqrt(1 + diag) / 2;
    q1 = (R(3,2) - R(2,3)) / (4 * q0);
    q2 = (R(1,3) - R(3,1)) / (4 * q0);
    q3 = (R(2,1) - R(1,2)) / (4 * q0);

    magnitude = sqrt(q0^2 + q1^2 + q2^2 + q3^2)
    q0 /= magnitude
    q1 /= magnitude
    q2 /= magnitude
    q3 /= magnitude

    %quat2eul
end
