function area = e3(TR)
    % TR - объемная триангулированная сетка
    % Находим индексы всех вершин
    triangles = TR.ConnectivityList;

    % Вычислим площади каждого треугольника
    vec1 = TR.Points(triangles(:, 2), :) - TR.Points(triangles(:, 1), :);
    vec2 = TR.Points(triangles(:, 3), :) - TR.Points(triangles(:, 1), :);
    cross_prod = cross(vec1, vec2, 2);
    triangle_areas = 0.5 * sqrt(sum(cross_prod .^ 2, 2));

    % Создаем матрицу площадей
    n = size(TR.Points, 1);
    area = zeros(n, 1);

    for k = 1:size(triangles, 1)
        % К каждой вершине треугольника добавляем его площадь и делим на 3
        for j = 1:3
            area(triangles(k, j)) = area(triangles(k, j)) + triangle_areas(k) / 3;
        end
    end
end
