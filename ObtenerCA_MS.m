function CA = ObtenerCA_MS(mar, ant, graficar)
% Función para calcular ÚNICAMENTE Centros Articulares (CA) 
% para miembro superior según modelo ISB
%
% Entradas:
%   mar - estructura con marcadores (campos: C7, T8, IJ, AX, R_AC, L_AC, etc.)
%   ant - estructura con datos antropométricos
%   graficar - booleano para graficar centros articulares (opcional)
%
% Salidas:
%   CA - estructura con centros articulares calculados

if nargin < 3
    graficar = false;
end

%% ========================================================================
%% CENTRO GLENOHUMERAL (GH) - Ecuaciones (7) y (8)
%% ========================================================================
% Eje X auxiliar: de L_AC a R_AC
GH_x_aux = normalize((mar.R_AC - mar.L_AC), 2, 'norm');

% Versor auxiliar: de L_AC a C7
GH_aux = normalize((mar.C7 - mar.L_AC), 2, 'norm');

% Eje Y auxiliar: perpendicular a GH_aux y GH_x_aux
GH_y_aux = normalize(cross(GH_aux, GH_x_aux, 2), 2, 'norm');

% Calcular o usar distancia entre acromiones
if isempty(ant.DistanciaAcromiones.Valor) || ant.DistanciaAcromiones.Calculado
    % Calcular de marcadores (para cada frame)
    dist_acromiones = sqrt(sum((mar.R_AC - mar.L_AC).^2, 2));
    fprintf('Distancia entre acromiones calculada: %.3f ± %.3f m\n', ...
            mean(dist_acromiones), std(dist_acromiones));
else
    dist_acromiones = ant.DistanciaAcromiones.Valor;
end

% GH está a 17% de la distancia entre acromiones (ecuación 8)
CA.GH_R = mar.R_AC - 0.17 * dist_acromiones .* GH_y_aux;
CA.GH_L = mar.L_AC - 0.17 * dist_acromiones .* GH_y_aux;

%% ========================================================================
%% CODO - Centro articular (Ecuación 9)
%% ========================================================================
% Punto medio entre epicóndilos lateral y medial
CA.Codo_R = (mar.R_EL + mar.R_EM) / 2;  % EJC derecho
CA.Codo_L = (mar.L_EL + mar.L_EM) / 2;  % EJC izquierdo

%% ========================================================================
%% MUÑECA - Centro articular (Ecuación 17)
%% ========================================================================
CA.Muneca_R = (mar.R_US + mar.R_RS) / 2;
CA.Muneca_L = (mar.L_US + mar.L_RS) / 2;

%% ========================================================================
%% GRAFICAR SOLO CENTROS ARTICULARES
%% ========================================================================
if graficar
    graficar_CA_MS(CA);
end

fprintf('Centros articulares calculados.\n');

end