function StructFiltrado = FiltrarStruct(StructOriginal, fm, frec_corte, Orden)
% Filtra todos los campos numéricos (N x 1 o N x 3) de una estructura
% usando un filtro Butterworth y filtfilt.

    StructFiltrado = struct(); % Inicializa la estructura de salida
    campos = fieldnames(StructOriginal);

    % --- Crear el filtro ---
    fe = fm / 2; % Frecuencia de Nyquist
    wn = frec_corte / fe; % Frecuencia normalizada
    [B, A] = butter(Orden, wn, 'low'); % Coeficientes del filtro pasa-bajos

    % --- Iterar sobre los campos de la estructura ---
    for i = 1:length(campos)
        campo = campos{i};
        dato_actual = StructOriginal.(campo);

        % --- Verificar si el campo es apto para filtrar ---
        if isnumeric(dato_actual) && ~isempty(dato_actual) && ismatrix(dato_actual) && size(dato_actual, 1) > 1 
            
            [n_filas, n_columnas] = size(dato_actual);
            
            % Requisito de filtfilt: longitud > 3 * orden del filtro
            if n_filas <= 3 * (max(length(B), length(A)) - 1)
                 warning('No hay suficientes puntos (%d) para filtrar el campo "%s". Se devolverá sin filtrar.', n_filas, campo);
                 StructFiltrado.(campo) = dato_actual; % Devolver original
                 continue;
            end

            % --- Filtrar cada columna ---
            dato_filtrado = zeros(n_filas, n_columnas);
            for col = 1:n_columnas
                columna_actual = dato_actual(:, col);
                
                % Reemplazar NaNs/Infs (filtfilt falla con ellos)
                columna_actual(~isfinite(columna_actual)) = 0; 
                
                % Aplicar filtro
                dato_filtrado(:, col) = filtfilt(B, A, columna_actual);
            end
            
            StructFiltrado.(campo) = dato_filtrado; % Guardar resultado filtrado
            
        else
            % Si no es numérico, está vacío, no es matriz, o es escalar/vector fila, copiarlo tal cual
            StructFiltrado.(campo) = dato_actual;
        end
    end
end