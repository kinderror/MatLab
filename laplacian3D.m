function [L] = laplacian3D(Nx, Ny, Nz, Lx, Ly, Lz)
% Nx, Ny, Nz - число разбиений по каждому из направлений
% Lx, Ly, Lz - размеры рабочей области вдоль каждого из направлений

hx = Lx/(Nx+1);
hy = Ly/(Ny+1);
hz = Lz/(Nz+1);

N = Nx*Ny*Nz;

% Создаем матрицу оператора Лапласа
L = sparse(N, N);

for i = 1:Nx
    for j = 1:Ny
        for k = 1:Nz
            n = (k-1)*Nx*Ny + (j-1)*Nx + i;
            L(n, n) = -2/hx^2 - 2/hy^2 - 2/hz^2;

            if i > 1
                n1 = (k-1)*Nx*Ny + (j-1)*Nx + i-1;
                L(n, n1) = 1/hx^2;
            end

            if i < Nx
                n2 = (k-1)*Nx*Ny + (j-1)*Nx + i+1;
                L(n, n2) = 1/hx^2;
            end

            if j > 1
                n3 = (k-1)*Nx*Ny + (j-2)*Nx + i;
                L(n, n3) = 1/hy^2;
            end

            if j < Ny
                n4 = (k-1)*Nx*Ny + j*Nx + i;
                L(n, n4) = 1/hy^2;
            end

            if k > 1
                n5 = (k-2)*Nx*Ny + (j-1)*Nx + i;
                L(n, n5) = 1/hz^2;
            end

            if k < Nz
                n6 = k*Nx*Ny + (j-1)*Nx + i;
                L(n, n6) = 1/hz^2;
            end
        end
    end
end

end