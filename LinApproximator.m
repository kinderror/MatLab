function [P,sgP] = LinApproximator(y,r,funcs)
% y - вектор длины 1xN с значениями экспериментальных данных
% N - количество экспериментальных точек.
% r - матрица размера KxN со значениями векторов-аргументов
% K - размерность векторов-аргументов.
% funcs - массив размера Mx1 содержащий матлаб function-handles
% P -  вектор размера 1xM со значениям оптимальных параметров 
% sgP - вектор оценочных значений ошибок параметров P

% вычислим константы из принимаемых значений
N = size(y, 1);
M  = size(funcs, 1); 

% найдем оптимальные параметры
phi = zeros(N, M);
for ii = 1:N
    for jj = 1:M
        phi(ii, jj) = funcs{jj}(r(:, ii));
    end
end
G = phi' * phi;
z = phi' * y;
P = G \ z;

w = y - phi * P; % вектор отклонений
sum = 0;
for ii = 1:N
    sum = sum + w(ii)^2;
end

% считаем ошибку параметров P
Err = sum / N;
C = G^(-1);
sgP = zeros(1, M);
for ii = 1:M
    sgP(ii) = Err * C(ii, ii);
end
end