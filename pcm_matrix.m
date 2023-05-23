function M = pcm_matrix(P,N,S) 
% P - матрица nx3 с координатами вершин триангулированной сетки. n - число вершин
% N - матрица nx3 с координатами нормалей в вершинах
% S - вектор nx1 со значениями площадей поверхностных элементов.

a = size(P, 1);
RD = zeros(a, a);
for k = 1 : a
    for m = k + 1 : a 
        RD(k, m) = 1/norm(P(k, :)-P(m, :));
        RD(m, k) = RD(k, m); % из-за симметрии
    end
end

b = length(S(:, 1));
M = zeros(n, n);
for k = 1 : b
    for m = 1 : b
        M(k, m) = sum((P(k, :) - P(m, :)) .* N(k, :)) * S(m, 1) * (RD(k, m)^3);
    end
end

for k = 1 : b
    M(k, k) = 2 * pi - sum(M(:, k).*S)/S(k);
end