function graficar_CA_MS(CA)
% Función para graficar únicamente los centros articulares
% de miembro superior
%
% Entrada:
%   CA - estructura con centros articulares

figure('Name', 'Centros Articulares - Miembro Superior', 'NumberTitle', 'off');
hold on;
grid on;
axis equal;
title('Centros Articulares del Miembro Superior');
xlabel('X [m]'); 
ylabel('Y [m]'); 
zlabel('Z [m]');
view(3);

% Plotear algunos frames para ver trayectorias
num_frames = size(CA.GH_R, 1);
frames_plot = 1:max(1, floor(num_frames/50)):num_frames;  % Máximo 50 puntos

% GH (Glenohumeral)
plot3(CA.GH_R(frames_plot, 1), CA.GH_R(frames_plot, 2), CA.GH_R(frames_plot, 3), ...
      'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'GH Derecho');
plot3(CA.GH_L(frames_plot, 1), CA.GH_L(frames_plot, 2), CA.GH_L(frames_plot, 3), ...
      'r^', 'MarkerSize', 8, 'MarkerFaceColor', 'r', 'DisplayName', 'GH Izquierdo');

% Codos
plot3(CA.Codo_R(frames_plot, 1), CA.Codo_R(frames_plot, 2), CA.Codo_R(frames_plot, 3), ...
      'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'DisplayName', 'Codo Derecho');
plot3(CA.Codo_L(frames_plot, 1), CA.Codo_L(frames_plot, 2), CA.Codo_L(frames_plot, 3), ...
      'g^', 'MarkerSize', 8, 'MarkerFaceColor', 'g', 'DisplayName', 'Codo Izquierdo');

% Muñecas
plot3(CA.Muneca_R(frames_plot, 1), CA.Muneca_R(frames_plot, 2), CA.Muneca_R(frames_plot, 3), ...
      'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b', 'DisplayName', 'Muñeca Derecha');
plot3(CA.Muneca_L(frames_plot, 1), CA.Muneca_L(frames_plot, 2), CA.Muneca_L(frames_plot, 3), ...
      'b^', 'MarkerSize', 8, 'MarkerFaceColor', 'b', 'DisplayName', 'Muñeca Izquierda');

legend('Location', 'best');
hold off;

fprintf('Gráfico de centros articulares generado.\n');

end