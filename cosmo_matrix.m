function M = cosmo_matrix(P,S)
% P - матрица nx3 с координатами вершин триангулированной сетки. n - число вершин
% S - вектор nx1 со значениями площадей поверхностных элементов.
% M - матрица nxn определяющая потенциал в вершинах сетки по значениям зарядов в них.
n = size(P);
n = n(1);
M = zeros(n, n);
for k = 1:n
    for l = 1:n
        if k == l 
            M(k, l) = 2*sqrt(pi*S(l));
        else
            M(k, l) = S(l)/dist(P(k, :), P(l, :));
        end
    end
end


function r = dist(v1, v2)
r = sqrt(sum((v1 - v2).^2));
