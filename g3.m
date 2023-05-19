function M = g3(TR)
[F,P] = freeBoundary(TR);
n = size(P);
n = n(1);
M = zeros(n);
for k = 1 : n
    for l = k + 1 : n
        M(k, l) = 1/define_distance(P(k, :), P(l, :));
        M(l, k) = M(k, l);
    end
end

function s = define_distance(v1, v2)
s = sqrt(sum((v1 - v2).^2));
 