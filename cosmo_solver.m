function [W,Ws,sg] = cosmo_solver(XYZ,Q,P,S,e_in)
% XYZ - матрица mx3 с координатами m точечных зарядов
% Q - вектор mx1 значений зарядов
% P - матрица nx3 с координатами n вершин триангулированной сетки поверхности
% S - вектор nx1 значений площадей поверхностных элементов
% e_in - значение диэлектрической проницаемости среды полностью заполняющую полость
% W - значение полной энергии электростатического взаимодействия системы зарядов друг с другом и с индуцированными поверхностными зарядами
% Ws - энергия взаимодействия зарядов только с поверхностными индуцированными зарядами.
% sg - вектор nx1 значений поверхностной плотности зарядов в заданных вершинах сетки триангуляции.

RD = r_dist(P, XYZ); % матрица расстояний от зарядов до поверхностей
QRD = r_dist(XYZ, XYZ); % матрица расстояний между зарядами
SRD = r_dist(P, P); % матрица расстояний между поверхностями

A = (SRD).*(S');
b = - 1 / e_in * (RD') * Q;
sg = A\b;
q = sg.*S;
Ws = 1/2 * Q' * RD * (sg.*S);
Wq = Q' * QRD * Q / 2;
W = Ws + Wq;

% функция, вычисляющая матрицу расстояний                  
function M = r_dist(A, B)
n = size(A, 1);
m = size(B, 1);
M = zeros(m, n);
for i = 1 : m
    for j = 1 : n
        if i ~= j || norm(B(i, :) - A(j, :)) ~= 0
            M(i, j) = 1/norm(B(i, :) - A(j, :));
        end
    end
end
