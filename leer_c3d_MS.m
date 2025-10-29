function [marcadores, informacionCine, Eventos, fileName] = leer_c3d_MS()
% Función para leer archivo c3d específico para MIEMBRO SUPERIOR
% Carga y organiza SOLO datos de marcadores y eventos
% según el modelo biomecánico de miembro superior basado en ISB
%
% Salidas:
% marcadores - estructura con datos de posición de marcadores
% informacionCine - información de frecuencia y unidades cinemáticas
% Eventos - instantes temporales de eventos del movimiento
% fileName - nombre del archivo cargado

% Selección del archivo
[fileName, filePath] = uigetfile('*.c3d', 'Seleccionar archivo C3D de Miembro Superior');

if fileName == 0
    error('No se seleccionó ningún archivo');
end

% Lectura del archivo c3d
[h, ~, ~] = btkReadAcquisition([filePath fileName]);
btkSetPointsUnit(h, 'marker', 'm');  % Unidades en metros

% Carga de marcadores e información cinemática
[premarcadores, informacionCine] = btkGetMarkers(h);

% Limpiar nombres de marcadores (eliminar prefijos y marcadores sin etiquetar)
marcadoresLimpios = struct();
nombresOriginales = fieldnames(premarcadores);

fprintf('\nProcesando marcadores...\n');
for i = 1:length(nombresOriginales)
    nombreOriginal = nombresOriginales{i};
    
    % Saltar marcadores sin etiquetar
    if contains(nombreOriginal, 'Unlabeled', 'IgnoreCase', true)
        fprintf('  Descartando: %s\n', nombreOriginal);
        continue;
    end
    
    % Limpiar prefijo
    nombreLimpio = nombreOriginal;
    nombreLimpio = strrep(nombreLimpio, 'MarkerSet__', '');
    
    % Copiar datos con nombre limpio
    marcadoresLimpios.(nombreLimpio) = premarcadores.(nombreOriginal);
    
    if ~strcmp(nombreOriginal, nombreLimpio)
        fprintf('  %s -> %s\n', nombreOriginal, nombreLimpio);
    end
end

% Verificación de marcadores de miembro superior
marcadoresRequeridos = {'IJ', 'C7', 'PX', 'T8', 'AX', ...     % Torso (AX=PX alternativo)
                        'R_AC', 'L_AC', ...                    % Clavícula
                        'R_EL', 'R_EM', 'L_EL', 'L_EM', ...   % Húmero (epicóndilos)
                        'R_RS', 'R_US', 'L_RS', 'L_US', ...   % Antebrazo
                        'R_MCP3', 'L_MCP3', ...                % Mano (alternativa con MCP3)
                        'R_MCP2', 'R_MCP5', 'L_MCP2', 'L_MCP5', ... % Mano (MCP2 y MCP5)
                        'R_ASIS', 'L_ASIS', 'SACRUM', 'SACRO'}; % Pelvis

marcadoresPresentes = fieldnames(marcadoresLimpios);
fprintf('\nMarcadores limpios encontrados (%d):\n', length(marcadoresPresentes));
disp(marcadoresPresentes);

% Verificar marcadores críticos
marcadoresCriticos = {'IJ', 'C7', 'R_AC', 'L_AC', 'R_EL', 'L_EL'};
faltantes = {};
for i = 1:length(marcadoresCriticos)
    if ~isfield(marcadoresLimpios, marcadoresCriticos{i})
        faltantes{end+1} = marcadoresCriticos{i};
    end
end

if ~isempty(faltantes)
    warning('Marcadores críticos faltantes:');
    disp(faltantes);
end

% Organización de datos de marcadores
marcadores.Valores = marcadoresLimpios;
marcadores.Unidades = informacionCine.units.ALLMARKERS;
marcadores.Frecuencia = informacionCine.frequency;

% Carga de eventos
try
    Eventos = btkGetEvents(h);
catch
    Eventos = struct();
    warning('No se encontraron eventos en el archivo');
end

% Cerrar el archivo
btkCloseAcquisition(h);

fprintf('\n--- Resumen de carga ---\n');
fprintf('Archivo: %s\n', fileName);
fprintf('Frecuencia de muestreo: %.1f Hz\n', marcadores.Frecuencia);
fprintf('Número de frames: %d\n', size(marcadores.Valores.(marcadoresPresentes{1}), 1));
fprintf('Marcadores válidos: %d\n', length(marcadoresPresentes));

end