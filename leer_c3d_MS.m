function [marcadores, informacionCine, Eventos, fileName] = Leer_c3d_MS()
% Función para leer archivo c3d específico para MIEMBRO SUPERIOR
% Carga y organiza SOLO datos de marcadores y eventos
% según el modelo biomecánico de miembro superior basado en ISB
%
% Salidas:
% marcadores - estructura con datos de posición de marcadores
% informacionCine - información de frecuencia y unidades cinemáticas
% Eventos - instantes temporales de eventos del movimiento
% fileName - nombre del archivo cargado

[fileName, filePath] = uigetfile('*.c3d');
[h,~,~] = btkReadAcquisition([filePath fileName]);
btkSetPointsUnit(h, 'marker', 'm')
[premarcadores, informacionCine] = btkGetMarkers(h);

% Limpiar nombres de marcadores
campos = fieldnames(premarcadores);
marcadores_limpios = struct();

for i = 1:length(campos)
    nombre_original = campos{i};
    
    % Saltar marcadores Unlabeled
    if contains(nombre_original, 'Unlabeled', 'IgnoreCase', true)
        continue;
    end
    
    % Remover prefijo "MarkerSet_"
    nombre_limpio = strrep(nombre_original, 'MarkerSet__', '');
    
    % Asignar datos al nuevo campo
    marcadores_limpios.(nombre_limpio) = premarcadores.(nombre_original);
end

marcadores.Valores = marcadores_limpios;
marcadores.Unidades = informacionCine.units.ALLMARKERS;
marcadores.Frecuencia = informacionCine.frequency;

Eventos = btkGetEvents(h);

end