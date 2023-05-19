function M = cosmo_matrix(P,S)
% P - матрица nx3 с координатами вершин триангулированной сетки. n - число вершин
% S - вектор nx1 со значениями площадей поверхностных элементов.
% M - матрица nxn определяющая потенциал в вершинах сетки по значениям зарядов в них.
n = size(P, 1);
M = zeros(n, n);
for i = 1:n
    for j = 1:n
        if i == j 
            M(i, j) = 2*sqrt(pi*S(i));
        else
            M(i, j) = S(j)/calculate_distance(P(i, :), P(j, :));
        end
    end
end
end

% функция вычисления расстояния
function L = calculate_distance(v1, v2)
L = sqrt(sum((v1 - v2).^2));
end
