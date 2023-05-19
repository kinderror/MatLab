function area = e3(TR)
    % TR is a triangulation object in 3D

    % Get the indices of the vertices in each triangle
    triangles = TR.ConnectivityList;

    % Compute the areas of each triangle
    vec1 = TR.Points(triangles(:, 2), :) - TR.Points(triangles(:, 1), :);
    vec2 = TR.Points(triangles(:, 3), :) - TR.Points(triangles(:, 1), :);
    cross_prod = cross(vec1, vec2, 2);
    triangle_areas = 0.5 * sqrt(sum(cross_prod .^ 2, 2));

    % Initialize the area array to zeros
    n = size(TR.Points, 1);
    area = zeros(n, 1);

    % Loop over each triangle
    for k = 1:size(triangles, 1)
        % For each vertex in this triangle, add the area of the triangle
        % divided by 3 to its corresponding entry in the area array
        for j = 1:3
            area(triangles(k, j)) = area(triangles(k, j)) + triangle_areas(k) / 3;
        end

    end
end
