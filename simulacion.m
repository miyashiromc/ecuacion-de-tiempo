% -------------------------------------------------------------------------
% COMPARATIVA DE PRECISIÓN: CÍRCULO VS TIERRA REAL
% Autor: Ing. Miyako Morales (Para Ab. Jose Morales)
% -------------------------------------------------------------------------

clear; clc; close all;

% 1. PARÁMETROS EXACTOS
a = 1.0;                % 1 Unidad Astronómica (Distancia media)
e_tierra = 0.0167086;   % Excentricidad precisa de la Tierra
theta = linspace(0, 2*pi, 3600); % Ángulo de 0 a 360 grados (resolución alta)

% 2. CÁLCULO DE RADIOS (Desde el Foco/Sol)
% Círculo Perfecto: Radio constante
r_circulo = a * ones(size(theta));

% Elipse Kepleriana (Tierra): r = a(1-e^2) / (1 + e*cos(theta))
% Usamos la fórmula polar exacta desde el foco
r_tierra = (a * (1 - e_tierra^2)) ./ (1 + e_tierra * cos(theta));

% Coordenadas Cartesianas
x_c = r_circulo .* cos(theta);
y_c = r_circulo .* sin(theta);

x_t = r_tierra .* cos(theta);
y_t = r_tierra .* sin(theta);

% 3. VISUALIZACIÓN
figure('Color', 'w', 'Position', [100, 100, 1200, 500]);

% --- GRAFICA 1: LA ILUSIÓN ÓPTICA (ESCALA REAL 1:1) ---
subplot(1, 2, 1);
hold on; axis equal; grid on;
plot(0, 0, 'y.', 'MarkerSize', 30); % Sol
plot(x_c, y_c, 'b--', 'LineWidth', 1); % Círculo
plot(x_t, y_t, 'r-', 'LineWidth', 1.5); % Tierra

title('Comparación a Escala Real (1:1)');
legend('Sol', 'Círculo Perfecto', 'Órbita Tierra', 'Location', 'SouthOutside');
xlabel('UA'); ylabel('UA');
text(0, -0.2, 'Nota: La diferencia es casi invisible al ojo', 'HorizontalAlignment', 'center');

% --- GRAFICA 2: LA VERDAD MATEMÁTICA (ZOOM AL ERROR) ---
subplot(1, 2, 2);
% Calculamos la diferencia radial
diferencia = r_tierra - r_circulo;

plot(rad2deg(theta), diferencia, 'k-', 'LineWidth', 2);
grid on;
xlim([0 360]);

title('La Deformación Real (Diferencia Radial)');
xlabel('Ángulo Orbital (Grados)');
ylabel('Diferencia respecto al Círculo (UA)');

% Marcas de Perihelio y Afelio
text(180, min(diferencia), '\leftarrow Perihelio (Más cerca)', 'VerticalAlignment', 'bottom');
text(0, max(diferencia), '\leftarrow Afelio (Más lejos)', 'VerticalAlignment', 'top');

% Formato
ax = gca;
ax.YAxis.Exponent = 0; % Evitar notación científica confusa si es posible