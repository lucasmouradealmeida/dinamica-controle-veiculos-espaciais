function eul = quad2eul( q, varargin )
%QUAT2EUL Convert quaternion to Euler angles
%   EUL = QUAT2EUL(Q) converts a unit quaternion rotation into the corresponding 
%   Euler angles. The input, Q, is a 4-by-N matrix containing N quaternions. 
%   Each quaternion represents a 3D rotation and is of the form q = [w x y z], 
%   with a scalar number as the first value. Each element of Q must be a real number.
%   The output, EUL, is a 3-by-N array of Euler rotation angles with each 
%   row representing one Euler angle set. Rotation angles are in radians.
%
%   EUL = QUAT2EUL(Q, SEQ) converts unit quaternion into Euler angles.
%   The Euler angles are specified by the axis rotation sequence, SEQ.
%
%   The default rotation sequence is 'ZYX', where the order of rotation
%   angles is Z Axis Rotation, Y Axis Rotation, and X Axis Rotation.
%
%   The following rotation sequences, SEQ, are supported: 'ZYX', 'ZYZ', and 'ZXY'.
%
%   Example:
%      % Calculates Euler angles for a quaternion
%      % By default, the ZYX axis order will be used.
%      q = [sqrt(2)/2 0 sqrt(2)/2 0];
%      eul = quat2eul(q)
%
%      % Calculate the Euler angles for a ZYZ rotation
%      eulZYZ = quat2eul(q, 'ZYZ')
%
%   See also eul2quat

if (size(q,1) ~= 4)
    q = q';
    transposeOutput = true;
else
    transposeOutput = false;
end

if (length(varargin) == 1)
    seq = varargin{1};
else
    seq = 'ZYX';
end

% Normalize the quaternions
norm_q = sqrt(sum(q.^2, 1));
q = q ./ norm_q;

% invert if scalar is negative
neg_idx = find(q(1,:) < 0);
q(:,neg_idx) = -q(:,neg_idx);

% extract individual quaternion elements
qw = q(1,:);
qx = q(2,:);
qy = q(3,:);
qz = q(4,:);

% The parsed sequence will be in all upper-case letters and validated
switch upper(seq)
    case 'ZYX'
        eul = [ atan2( 2*(qx.*qy+qw.*qz), qw.^2 + qx.^2 - qy.^2 - qz.^2 ); ...
            asin( -2*(qx.*qz-qw.*qy) ); ...
            atan2( 2*(qy.*qz+qw.*qx), qw.^2 - qx.^2 - qy.^2 + qz.^2 )];
        
    case 'ZYZ'
        % Need to convert to intermediate rotation matrix here to avoid singularities
        R = quat2rotm(q);
        eul = rotm2eul(R, 'ZYZ');
        
    case 'ZXY'
        % Rotação ZXY: Primeiro Z, depois X, depois Y
        eul = [atan2(2*(qx.*qy - qw.*qz), qw.^2 - qx.^2 - qy.^2 + qz.^2); ...
               asin(2*(qw.*qx + qy.*qz)); ...
               atan2(2*(qw.*qy - qx.*qz), qw.^2 + qx.^2 - qy.^2 - qz.^2)];
        
    otherwise
        error('Sequência de rotação não suportada.');
end

% Check for complex numbers
if ~isreal(eul)
    eul = real(eul);
end

if (transposeOutput)
    eul = eul';
end

end
