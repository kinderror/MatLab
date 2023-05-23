S = 0:0.20:399;
S = sort([-sqrt(S), sqrt(S)]); 
x = fresnelc(S);
y = fresnels(S);
figure; 
hold on; 
grid on; 
plot(x, y)