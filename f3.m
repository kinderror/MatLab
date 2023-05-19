function normals = f3(TR)
n = size(TR.Points, 1);
normals = zeros(n, 3); % матрица нормалей
adjacency_matrix = sparse(n, n); % матрица смежности
neighbours_amount = zeros(n); % матрица количества соседей
% идентифицируем соседей
for k = 1 : n
    for m = 1 : n
        if isConnected(TR, k, m)
            adjacency_matrix(k, m) = 1;
            neighbours_amount(k) = neighbours_amount(k) + 1;
        end
    end
end
for k = 1 : n
    neighbors = zeros(neighbours_amount(k)); % матрица соседей
    current = 1;
    for m = 1 : n
        if adjacency_matrix(k, m) == 1
            neighbors(current) = m;
            current = current + 1;
        end
    end
    triangle_numbers = 0;
    for i = 1 : neighbours_amount(k)
        for j = i + 1 : neighbours_amount(k)
            if adjacency_matrix(i, j) == 1
                triangle_numbers = triangle_numbers + 1;
                normals(k, :) = normals(k, :) + calculate_triangle_normal(TR.Points(k, :), TR.Points(i, :), TR.Points(j, :));
            end
        end
    end
    normals(k, :) = normals(k, :)./triangle_numbers;
end
end

% функция вычисления нормали
function N = calculate_triangle_normal(v1, v2, v3)
V = cat(1, v1, v2, v3);
b = [1; 1; 1];
x = V\b;
N = (x/sqrt(sum(x.^2)))';
end


    
