[X, Y] = meshgrid(-1:0.01:1);
Z = 3*X.*Y.^2 - X.^3; % Поверхность Эннепера
subplot(1, 2, 1)
h = surf(X, Y, Z);
shading flat
axis equal
axis tight
box on

subplot(1,2,2)
spy(isnan(Z))       % Отображаем, где значения Z равны NaN (пока пусто)
axis equal
axis tight
axis off

zmin=min(Z(:)); zmax=max(Z(:));   % Определяем минимальное и максимальное значения функции
n=100; tol=(zmax-zmin)/200;         % Задаём количество шагов и толщину слоя

for z0=linspace(zmin,zmax,n)
    ind=abs(Z-z0)<tol;              % Находим точки, близкие к уровню z0
    Z2=Z; Z2(ind)=NaN;              % Вырезаем уровень, заменяя значения на NaN
    set(h,'ZData',Z2)               % Обновляем данные поверхности для отображения выреза
    subplot(1,2,2)
    spy(isnan(Z2))                  % Показываем карту точек, где вырез сделан
    axis equal
    axis tight
    axis off
    drawnow                         % Обновляем окно графики на каждом шаге цикла
end