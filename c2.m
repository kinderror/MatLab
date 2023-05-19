function c2(a,b,c)
    arguments
        a = [1 1 1]; 
        b = [-1 1 -1];
        c = [-1 -1 1];
    end

    n = 2;
    grid_points = [];
    % создаем 3D сетку размера n
    index = 1;
    for i = -1:1
        for j = -1:1
            for k = -1:1
                grid_points(end+1,:) = a * i + j*b+k*c;
                if (i ~= 0) || (j ~= 0) || (k ~= 0)
                    index = index + 1;
                else
                    cell_idx = index; 
                end
            end
        end 
    end

    % воспользуемся диаграммами Вороного
    [v, ce] = voronoin(grid_points);

    vertices = v(ce{cell_idx},:) - repmat([0,0,0],size(v(ce{cell_idx},:),1),1);
    
    % создаем триаунгулированную сетку по точкам
    tri = delaunay(vertices(:,1), vertices(:,2), vertices(:,3));

    hold on;
    scatter3(vertices(:,1), vertices(:,2), vertices(:,3), 'b')
    scatter3(grid_points(:,1), grid_points(:,2), grid_points(:,3), 'r')
    
    % рисуем триангулированную сетку
    j = boundary(grid_points,1);
    trisurf(j,grid_points(:,1), grid_points(:,2), grid_points(:,3),'FaceColor','red','FaceAlpha',0.1)

    j = boundary(vertices,1);
    trisurf(j,vertices(:,1), vertices(:,2), vertices(:,3),'FaceColor','blue','FaceAlpha',0.1)
    
    % сжимаем векторы
    a = a * 0.5 / norm(a);
    b = b * 0.5 / norm(b);
    c = c * 0.5 / norm(c);

    plot3([0,a(1)],[0,a(2)],[0,a(3)],'-r','LineWidth',2);
    plot3([0,b(1)],[0,b(2)],[0,b(3)],'-g','LineWidth',2);
    plot3([0,c(1)],[0,c(2)],[0,c(3)],'-b','LineWidth',2);

    xlabel('X')
    ylabel('Y')
    zlabel('Z')
    axis equal

end
