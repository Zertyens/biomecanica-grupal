function Graficar_Angulos_MS(Angulos)
% Grafica los ángulos articulares del miembro superior
%
% Entradas:
%   Angulos - estructura con ángulos articulares

figure('Position', [100, 100, 600, 400]);

%% FILA 1: HOMBRO
% Subplot 1: Plano de elevación
subplot(3,3,1);
plot(linspace(0, 100, length(Angulos.Hombro_R.alfa)), Angulos.Hombro_R.alfa, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Hombro_L.alfa)), Angulos.Hombro_L.alfa, 'r', 'LineWidth', 2);
hold off;
title('Hombro - Plano Elevación', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Ángulo [°]');
grid on;
xlim([0 100]);

% Subplot 2: Elevación
subplot(3,3,2);
plot(linspace(0, 100, length(Angulos.Hombro_R.beta)), Angulos.Hombro_R.beta, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Hombro_L.beta)), Angulos.Hombro_L.beta, 'r', 'LineWidth', 2);
hold off;
title('Hombro - Elevación', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Ángulo [°]');
grid on;
xlim([0 100]);

% Subplot 3: Rotación
subplot(3,3,3);
plot(linspace(0, 100, length(Angulos.Hombro_R.gamma)), Angulos.Hombro_R.gamma, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Hombro_L.gamma)), Angulos.Hombro_L.gamma, 'r', 'LineWidth', 2);
hold off;
title('Hombro - Rotación', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Int(+)/Ext(-) [°]');
grid on;
xlim([0 100]);

%% FILA 2: CODO
% Subplot 4: Flexión/Extensión
subplot(3,3,4);
plot(linspace(0, 100, length(Angulos.Codo_R.alfa)), Angulos.Codo_R.alfa, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Codo_L.alfa)), Angulos.Codo_L.alfa, 'r', 'LineWidth', 2);
hold off;
title('Codo - Flex/Ext', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Flex(+)/Ext(-) [°]');
grid on;
xlim([0 100]);

% Subplot 5: Abducción/Aducción
subplot(3,3,5);
plot(linspace(0, 100, length(Angulos.Codo_R.beta)), Angulos.Codo_R.beta, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Codo_L.beta)), Angulos.Codo_L.beta, 'r', 'LineWidth', 2);
hold off;
title('Codo - Abd/Add', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Abd(+)/Add(-) [°]');
grid on;
xlim([0 100]);

% Subplot 6: Pronación/Supinación
subplot(3,3,6);
plot(linspace(0, 100, length(Angulos.Codo_R.gamma)), Angulos.Codo_R.gamma, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Codo_L.gamma)), Angulos.Codo_L.gamma, 'r', 'LineWidth', 2);
hold off;
title('Codo - Pron/Sup', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Pron(+)/Sup(-) [°]');
grid on;
xlim([0 100]);

%% FILA 3: MUÑECA
% Subplot 7: Flexión/Extensión
subplot(3,3,7);
plot(linspace(0, 100, length(Angulos.Muneca_R.alfa)), Angulos.Muneca_R.alfa, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Muneca_L.alfa)), Angulos.Muneca_L.alfa, 'r', 'LineWidth', 2);
hold off;
title('Muñeca - Flex/Ext', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Flex(+)/Ext(-) [°]');
grid on;
xlim([0 100]);

% Subplot 8: Desviación Radial/Cubital
subplot(3,3,8);
plot(linspace(0, 100, length(Angulos.Muneca_R.beta)), Angulos.Muneca_R.beta, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Muneca_L.beta)), Angulos.Muneca_L.beta, 'r', 'LineWidth', 2);
hold off;
title('Muñeca - Des. Radial/Cubital', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Radial(-)/Cubital(+) [°]');
grid on;
xlim([0 100]);

% Subplot 9: Pronación/Supinación
subplot(3,3,9);
plot(linspace(0, 100, length(Angulos.Muneca_R.gamma)), Angulos.Muneca_R.gamma, 'g', 'LineWidth', 2);
hold on;
plot(linspace(0, 100, length(Angulos.Muneca_L.gamma)), Angulos.Muneca_L.gamma, 'r', 'LineWidth', 2);
hold off;
title('Muñeca - Pron/Sup', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('% Movimiento');
ylabel('Pron(+)/Sup(-) [°]');
grid on;
xlim([0 100]);

sgtitle('Ángulos Articulares - Miembro Superior', 'FontSize', 14, 'FontWeight', 'bold');

end