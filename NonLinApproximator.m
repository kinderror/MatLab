function [P,sgP] = NonLinApproximator(y,r,fun,P_0)
% y - вектор длины 1xN с значениями экспериментальных данных
% N- количество экспериментальных точек
% r - матрица размера KxN со значениями векторов-аргументов
% K - размерность векторов-аргументов
% fun - матлаб function-handle
% P -  вектор размера 1xM со значениям оптимальных параметров
% sgP - вектор оценочных значений ошибок параметров P

% вычислим константы из принимаемых значений
N = size(y, 2);
M = size(P_0, 2);
K = size(r, 1);

% введем параметры итерации
d = 1e-6;
n = 1000;

% итерации
for ii = 1:n
    f = zeros(N,1);
    J = zeros(N,K);

    % вычисляем Якобиан
    for jj = 1:N
        f(jj) = fun(r(:,jj),P_0);
        for k = 1:M        
            zero = zeros(1,M);
            if P_0(k) ~= 0        
                zero(k) = d * abs(P_0(k));
                A = P_0 + zero; 
                B = P_0 - zero;
                J(jj,k) = 0.5 * (fun(r(:,jj),A)-fun(r(:,jj),B))/zero(k);
            else 
                zero(k) = d;
                A = P_0 + zero;
                J(jj,k)=(fun(r(:,jj),A)-f(jj))/d;
            end
        end
    end
    
    % вычислим отклонение
    res = y' - f; 
    delta = (((J' * J) \ J') * res);
    
    if sum(isnan(delta)) == 0 
        P_0 = P_0 + delta';  
        if max(abs(delta'./P_0)) < d
            break;
        end    
    else
        break;
    end
end

% Мы добились необходимой точности
P = P_0;

% Значения ошибок параметров
sgP = norm(y' - f)^2 * diag(inv(J' * J))';
end