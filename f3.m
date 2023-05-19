function normals = f3(TR)
n = size(TR.Points);
n = n(1);
normals = zeros(n, 3);
adjacency_matrix = sparse(n, n);
neighbours_amount = zeros(n);
for k = 1 : n
    for l = 1 : n
        if isConnected(TR, k, l)
            adjacency_matrix(k, l) = 1;
            neighbours_amount(k) = neighbours_amount(k) + 1;
        end
    end
end
for k = 1 : n
    neighbors = zeros(neighbours_amount(k));
    current_numb = 1;
    for l = 1 : n
        if adjacency_matrix(k, l) == 1
            neighbors(current_numb) = l;
            current_numb = current_numb + 1;
        end
    end
    triangle_numbers = 0;
    for n1 = 1 : neighbours_amount(k)
        for n2 = n1 + 1 : neighbours_amount(k)
            if adjacency_matrix(n1, n2) == 1
                triangle_numbers = triangle_numbers + 1;
                normals(k, :) = normals(k, :) + calculate_triangle_normal(TR.Points(k, :), TR.Points(n1, :), TR.Points(n2, :));
            end
        end
    end
    normals(k, :) = normals(k, :)./triangle_numbers;
end

function N = calculate_triangle_normal(v1, v2, v3)
V = cat(1, v1, v2, v3);
b = [1; 1; 1];
x = V\b;
N = (x/sqrt(sum(x.^2)))';



    
