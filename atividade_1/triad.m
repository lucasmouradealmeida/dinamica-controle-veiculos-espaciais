function [R] = triad(si, sb, mi, mb)
    %Primeiro vetor
    t1b = sb;
    t1i = si;
    % Vetor perpendicular aos vetores de observação
    t2b = cross(sb, mb)/ norm(cross(sb, mb));
    t2i = cross(si, mi)/ norm(cross(si, mi));
    % Terceiro vetor completa a base ortonormal
    t3b = cross(t1b, t2b)/ norm(cross(t1b, t2b));
    t3i = cross(t1i, t2i)/ norm(cross(t1i, t2i));

    Ab = [t1b t2b t3b];
    Ai = [t1i t2i t3i];

    % Matriz de Atitude
    R = Ab*(Ai)';

    disp('Resultado do algoritmo da Triad:');
    disp('Matriz de rotação R:');
    disp(R);

    % https://en.wikiversity.org/wiki/PlanetPhysics/Euler_312_Sequence
    % https://en.wikiversity.org/wiki/PlanetPhysics/Direction_Cosine_Matrix_to_Euler_312_Angles
    % Ângulos de Euler (312)
    psi = atan2(-R(1,3), R(3,3))
    theta = asin(-R(2,3))
    phi = atan2(-R(2,1), R(2,2))

    

    % disp('Erro estimado:');
    % disp(erro_triad);

end
