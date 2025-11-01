function graficar_vectores(origenes, vectores, config)
    %Grafica múltiples vectores 3D desde orígenes con configuración personalizada
    % Parámetros:
        % origenes  - Matriz Nx3 con coordenadas [x y z] del punto de origen en cada frame
        % vectores  - Struct con campos 'u', 'v', 'w', cada uno Nx3 con componentes del vector
        % config    - Struct con campos:
        %   .ColorU         - Color del vector u (ej. 'r' o [1 0 0])
        %   .ColorV         - Color del vector v (ej. 'g' o [0 1 0])
        %   .ColorW         - Color del vector w (ej. 'b' o [0 0 1])
        %   .EtiquetaO      - Etiqueta para leyenda del origen
        %   .EtiquetaU      - Etiqueta para leyenda del vector u
        %   .EtiquetaV      - Etiqueta para leyenda del vector v
        %   .EtiquetaW      - Etiqueta para leyenda del vector w
        %   .Titulo         - Título del gráfico
        %   .Frecuencia     - Cada cuántos frames graficar (ej. 10)
        %   .MostrarOrigen  - true/false para mostrar los puntos de origen

    % Valores por defecto
    if ~isfield(config, 'ColorU'), config.ColorU = 'r'; end
    if ~isfield(config, 'ColorV'), config.ColorV = 'g'; end
    if ~isfield(config, 'ColorW'), config.ColorW = 'b'; end
    if ~isfield(config, 'EtiquetaU'), config.EtiquetaU = 'u'; end
    if ~isfield(config, 'EtiquetaV'), config.EtiquetaV = 'v'; end
    if ~isfield(config, 'EtiquetaW'), config.EtiquetaW = 'w'; end
    if ~isfield(config, 'Titulo'), config.Titulo = 'Gráfica Vectores'; end
    if ~isfield(config, 'Frecuencia'), config.Frecuencia = 10; end
    if ~isfield(config, 'MostrarOrigen'), config.MostrarOrigen = true; end
        
    % Inicializar figura
%     figure;
%     hold on;
    grid on;
    axis equal;
    view(3);
    title(config.Titulo);
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');

    % Número de frames
    nframes = size(origenes, 1);

    % Graficar cada "Frecuencia" frames
    for i = 1:config.Frecuencia:nframes
        origen = origenes(i, :);

        if config.MostrarOrigen
            plot3(origen(1), origen(2), origen(3), 'ko', 'MarkerSize', 4);
        end

        % Vector u
        quiver3(origen(1), origen(2), origen(3), ...
                vectores.u(i,1), vectores.u(i,2), vectores.u(i,3), ...
                'Color', config.ColorU, 'LineWidth', 2, 'MaxHeadSize', 0.3);

        % Vector v
        quiver3(origen(1), origen(2), origen(3), ...
                vectores.v(i,1), vectores.v(i,2), vectores.v(i,3), ...
                'Color', config.ColorV, 'LineWidth', 2, 'MaxHeadSize', 0.3);

        % Vector w
        quiver3(origen(1), origen(2), origen(3), ...
                vectores.w(i,1), vectores.w(i,2), vectores.w(i,3), ...
                'Color', config.ColorW, 'LineWidth', 2, 'MaxHeadSize', 0.3);
    end

    % Construir leyenda personalizada
    leyenda = {};

    if config.MostrarOrigen
        leyenda{end+1} = config.EtiquetaO;
    end
    leyenda{end+1} = config.EtiquetaU;
    leyenda{end+1} = config.EtiquetaV;
    leyenda{end+1} = config.EtiquetaW;

    % Mostrar leyenda única
    legend(leyenda, 'Location', 'best');

    end