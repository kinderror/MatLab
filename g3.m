function M = g3(TR)
[F,P] = freeBoundary(TR);
n = size(P, 1);
M = zeros(n); % матрица обратных расстояний
for k = 1 : n
    for m = k + 1 : n
        M(k, m) = 1/calculate_distance(P(k, :), P(m, :));
        M(m, k) = M(k, m); % из-за симметрии
    end
end

% функция вычисления расстояния
function s = calculate_distance(v1, v2)
s = sqrt(sum((v1 - v2).^2));
 
