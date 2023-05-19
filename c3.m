function Dy = c3(TR)
    arguments
        TR = delaunayTriangulation(rand(12,2));
    end
    % стороны и вершины триангулированной сетки
    Edges = TR.edges;
    Points = TR.Points;
    n = size(Points, 1);
    
    % матрица производной по y
    Dy = sparse(n, n);

    for k = 1:length(Edges)
        i = Edges(k, 1);
        j = Edges(k, 2);

        delta_y = Points(j, 2) - Points(i, 2);

        if delta_y ~= 0
            Dy(i, i) = Dy(i, i) - 1 / delta_y;
            Dy(i, j) = Dy(i, j) + 1 / delta_y;
            Dy(j, i) = Dy(j, i) + 1 / delta_y;
            Dy(j, j) = Dy(j, j) - 1 / delta_y;
        end
    end
end
