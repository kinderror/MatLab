function Dx = b3(TR)
    arguments
        TR = delaunayTriangulation(rand(12,2));
    end
    % стороны и вершины триангулированной сетки
    Edges = TR.edges;
    Points = TR.Points;
    n = size(Points, 1);
    
    % матрица производной по x
    Dx = sparse(n, n);

    for k = 1:length(Edges)
        i = Edges(k, 1);
        j = Edges(k, 2);

        delta_x = Points(j, 1) - Points(i, 1);

        if delta_x ~= 0
            Dx(i, i) = Dx(i, i) - 1 / delta_x;
            Dx(i, j) = Dx(i, j) + 1 / delta_x;
            Dx(j, i) = Dx(j, i) + 1 / delta_x;
            Dx(j, j) = Dx(j, j) - 1 / delta_x;
        end
    end
end
