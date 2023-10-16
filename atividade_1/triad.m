function [D_CM] = triad(si, sb, mi, mb)
    % Vetores de referência
    N = cross(si, sb);
    N = N / norm(N);
    B = sb;
    B = B / norm(B);

    % Calcular a terceira base usando o produto vetorial
    A = cross(B, N);

    % Matriz de rotação de body para inercial
    D_CM = [N, B, A];

    % Converter o vetor do magnetômetro do corpo para inercial
    mi_estimado = D_CM * mb;

    % Calcular o erro entre o vetor do magnetômetro estimado e o verdadeiro
    erro_triad = norm(mi_estimado - mi);

    disp('Resultado do algoritmo da Triad:');
    disp('Matriz de rotação D_CM:');
    disp(D_CM);
    disp('Erro entre mi estimado e mi verdadeiro:');
    disp(erro_triad);


end
