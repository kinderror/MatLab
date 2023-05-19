function L = laplacian1D(Nx, Lx)
    arguments
        Nx = 20;
        Lx = 1;
    end
    % Nx - число разбиений
    % Lx - размер рабочей области

    dx = Lx/Nx; % шаг сетки

    % Создаем матрицу оператора Лапласа
    L = sparse(Nx, Nx);

    for i = 1:Nx
        L(i,i) = -2/dx^2;
        if i > 1
            L(i,i-1) = 1/dx^2;
        end
        if i < Nx
            L(i,i+1) = 1/dx^2;
        end
    end
end