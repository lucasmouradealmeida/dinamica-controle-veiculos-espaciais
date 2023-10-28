function [V, D] = q_method(si, sb, mi, mb)
    vm = 1;
    ws = 1;
    B = ws*(sb*(si)') + vm*(mb*(mi)');
    Z = [B(2,3)-B(3,2); B(3,1)-B(1,3); B(1,2)-B(2,1)];
    sigma = trace(B);
    S = B + B';
    K = [S-sigma*eye(3) Z; Z' sigma]
    [V, D] = eig(K)

    q1 = V(1,4);
    q2 = V(2,4);
    q3 = V(3,4);
    q4 = V(4,4);

    result = quad2eul([q1, q2, q3, q4], 'ZXY')
end
