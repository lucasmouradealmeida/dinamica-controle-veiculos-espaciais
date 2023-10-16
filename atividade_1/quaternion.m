function [D_CM] = quaternion(si, sb, mi, mb)

    % Normalizar os vetores
    si = si / norm(si);
    sb = sb / norm(sb);
    mi = mi / norm(mi);
    mb = mb / norm(mb);

    % Calcular o vetor de referência no sistema inercial
    N_i = [1; 0; 0];

    % Calcular o vetor de referência no sistema do corpo
    N_b = si;

    % Calcular o vetor de referência após a rotação
    B_i = sb;

    % Calcular o erro entre o vetor de referência estimado e o verdadeiro
    erro_quaternion = norm(B_i - N_i);

    disp('Resultado do algoritmo de Quaternions:');
    disp('Erro entre B_i estimado e N_i verdadeiro:');
    disp(erro_quaternion);

    % Calcular o vetor de referência no sistema inercial
    N_i = [1; 0; 0];

    % Calcular o quaternion que rotaciona si para sb
    v = cross(si, sb);
    q_scalar = 1 + dot(si, sb);
    q_vector = v / norm(v) * sqrt(q_scalar);

    % Normalizar o quaternion
    q_vector = q_vector / norm(q_vector);
    q_scalar = q_scalar / norm(q_scalar);

    % Converter o quaternion para a matriz de rotação DCM
    D_CM = [
        1 - 2 * (q_vector(2)^2 + q_vector(3)^2), 2 * (q_vector(1) * q_vector(2) - q_scalar * q_vector(3)), 2 * (q_vector(1) * q_vector(3) + q_scalar * q_vector(2));
        2 * (q_vector(1) * q_vector(2) + q_scalar * q_vector(3)), 1 - 2 * (q_vector(1)^2 + q_vector(3)^2), 2 * (q_vector(2) * q_vector(3) - q_scalar * q_vector(1));
        2 * (q_vector(1) * q_vector(3) - q_scalar * q_vector(2)), 2 * (q_vector(2) * q_vector(3) + q_scalar * q_vector(1)), 1 - 2 * (q_vector(1)^2 + q_vector(2)^2)
    ];

    % Converter o vetor do magnetômetro do corpo para inercial usando a matriz de rotação DCM
    mi_estimado = D_CM * mb;

    % Calcular o erro entre o vetor do magnetômetro estimado e o verdadeiro
    erro_quaternion = norm(mi_estimado - mi);

    disp('Resultado do algoritmo de Quaternions:');
    disp('Matriz de rotação D_CM:');
    disp(D_CM);
    disp('Erro entre mi estimado e mi verdadeiro:');
    disp(erro_quaternion);

end
