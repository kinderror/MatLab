% создаем триангулированную сетку и рисуем
rng default;
P = rand(12,2);
T = delaunayTriangulation(P);
triplot(T)
 
hold on
k = convexHull(T);
xHull = T.Points(k,1);
yHull = T.Points(k,2);

plot(xHull,yHull,'r','LineWidth',2); 
hold off

bounder = [xHull, yHull];
bounder
[sz,numCols] = size(bounder);

% находим внешнюю границу и выводим 
Min = min(bounder(:,1));
k = 0;
for i = 1:sz 
    if bounder(i,1) == Min
        k = i;
    end
end
for j = k:sz 
    out_bounder(j-k+1,:) = bounder(j,:); 
end
for j = 1:k-1 
    out_bounder(sz-k+j,:) = bounder(j,:) ;
end

out_bounder

