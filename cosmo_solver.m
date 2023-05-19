function [W,Ws,sg] = cosmo_solver(XYZ,Q,P,S,e_in)

% XYZ - матрица mx3 с координатами m точечных зарядов
% Q - вектор mx1 значений зарядов
% P - матрица nx3 с координатами n вершин триангулированной сетки поверхности
% S - вектор nx1 значений площадей поверхностных элементов
% e_in - значение диэлектрической проницаемости среды полностью заполняющую полость

% W - значение полной энергии электростатического взаимодействия системы зарядов друг с другом и с индуцированными поверхностными зарядами
% Ws - энергия взаимодействия зарядов только с поверхностными индуцированными зарядами.
% sg - вектор nx1 значений поверхностной плотности зарядов в заданных вершинах сетки триангуляции.

RDist = rev_dist(P, XYZ);
% (k, l) element of matrix is distation between charge k and surface el. l
QRDist = rev_dist(XYZ, XYZ);
% (k, l) element of matrix is distation between charges k and l
SRDist = rev_dist(P, P);
% (k, l) element of matrix is distation between surface elements k and l
A = (SRDist).*(S');
b = - 1 / e_in * (RDist') * Q;
sg = A\b;
q = sg.*S;
Ws = 1/2 * Q' * RDist * (sg.*S);
Wq = Q' * QRDist * Q / 2;
W = Ws + Wq;


function M = rev_dist(A, B)
n = size(A);
n = n(1);
m = size(B);
m = m(1);
M = zeros(m, n);
for k = 1 : m
    for l = 1 : n
        if k ~= l || define_distance(B(k, :), A(l, :)) ~= 0
            M(k, l) = 1/define_distance(B(k, :), A(l, :));
        end
    end
end

% function M = rev_distations(A)
% n = size(A);
% n = n(1);
% M = zeros(n, n);
% for k = 1 : n
%     for l = k + 1 : n
%         M(k, l) = 1/define_distance(A(k, :), A(l, :));
%         M(l, k) = M(k, l);
%     end
% end

function s = define_distance(v1, v2)
s = sqrt(sum((v1 - v2).^2));