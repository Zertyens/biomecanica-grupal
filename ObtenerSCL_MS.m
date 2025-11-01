function SCL = ObtenerSCL_MS(mar, ant)
% Calcula Sistemas Coordenados Locales (SCL) para miembro superior según ISB
%
% Entradas:
%   mar - estructura con marcadores
%   ant - estructura con datos antropométricos
%
% Salidas:
%   SCL - estructura con centros articulares y versores de cada segmento

%% ========================================================================
%% PELVIS - Sección 1.2.1 (Ecuaciones 1-3)
%% ========================================================================
SCL.Pelvis.Origen = mar.SACRUM;

% Z_P: de L_ASIS a R_ASIS (derecha)
SCL.Pelvis.w = normalize((mar.R_ASIS - mar.L_ASIS), 2, 'norm');

% Y_P: perpendicular al plano (SACRUM, L_ASIS, R_ASIS), hacia arriba
SCL.Pelvis.v = normalize(cross((mar.SACRUM - mar.L_ASIS), ...
                               (mar.R_ASIS - mar.L_ASIS), 2), 2, 'norm');

% X_P: perpendicular a Y_P y Z_P, hacia adelante
SCL.Pelvis.u = normalize(cross(SCL.Pelvis.v, SCL.Pelvis.w, 2), 2, 'norm');

%% ========================================================================
%% TÓRAX - Sección 1.2.2 (Ecuaciones 4-6)
%% ========================================================================
SCL.Torax.Origen = mar.IJ;

% Puntos medios
pm_superior = (mar.IJ + mar.C7) / 2;
pm_inferior = (mar.AX + mar.T8) / 2;

% Y_T: de punto medio inferior a superior (arriba)
SCL.Torax.v = normalize((pm_superior - pm_inferior), 2, 'norm');

% Z_T: perpendicular al plano (IJ, C7, pm_inferior), hacia derecha
SCL.Torax.w = normalize(cross((mar.C7 - mar.IJ), ...
                              (pm_inferior - mar.IJ), 2), 2, 'norm');

% X_T: perpendicular a Y_T y Z_T, hacia adelante
SCL.Torax.u = normalize(cross(SCL.Torax.v, SCL.Torax.w, 2), 2, 'norm');

%% ========================================================================
%% CENTRO GLENOHUMERAL (GH) - Ecuaciones (7) y (8)
%% ========================================================================
% Eje X auxiliar: de L_AC a R_AC
GH_x_aux = normalize((mar.R_AC - mar.L_AC), 2, 'norm');

% Versor auxiliar: de L_AC a C7
GH_aux = normalize((mar.C7 - mar.L_AC), 2, 'norm');

% Eje Y auxiliar
GH_y_aux = normalize(cross(GH_aux, GH_x_aux, 2), 2, 'norm');

% Distancia entre acromiones
if isempty(ant.DistanciaAcromiones.Valor) || ant.DistanciaAcromiones.Calculado
    dist_acromiones = sqrt(sum((mar.R_AC - mar.L_AC).^2, 2));
else
    dist_acromiones = ant.DistanciaAcromiones.Valor;
end

% GH (ecuación 8)
SCL.GH_R = mar.R_AC - 0.17 * dist_acromiones .* GH_y_aux;
SCL.GH_L = mar.L_AC - 0.17 * dist_acromiones .* GH_y_aux;

%% ========================================================================
%% CODO - Ecuación 9
%% ========================================================================
SCL.Codo_R = (mar.R_EL + mar.R_EM) / 2;
SCL.Codo_L = (mar.L_EL + mar.L_EM) / 2;

%% ========================================================================
%% HÚMERO - Sección 1.2.3 (Ecuaciones 10-12)
%% ========================================================================
% DERECHO
SCL.Humero_R.Origen = SCL.GH_R;

% Y_H2: de Codo a GH (proximal) - Ecuación 10
SCL.Humero_R.v = normalize((SCL.GH_R - SCL.Codo_R), 2, 'norm');

% Y_A (antebrazo) necesario para calcular Z_H2
Y_A_R = normalize((SCL.Codo_R - mar.R_US), 2, 'norm');

% Z_H2: perpendicular a Y_H2 y Y_A, derecha - Ecuación 11
SCL.Humero_R.w = normalize(cross(SCL.Humero_R.v, Y_A_R, 2), 2, 'norm');

% X_H2: perpendicular a Y_H2 y Z_H2, adelante - Ecuación 12
SCL.Humero_R.u = normalize(cross(SCL.Humero_R.v, SCL.Humero_R.w, 2), 2, 'norm');

% IZQUIERDO
SCL.Humero_L.Origen = SCL.GH_L;

SCL.Humero_L.v = normalize((SCL.GH_L - SCL.Codo_L), 2, 'norm');

Y_A_L = normalize((SCL.Codo_L - mar.L_US), 2, 'norm');

SCL.Humero_L.w = normalize(cross(SCL.Humero_L.v, Y_A_L, 2), 2, 'norm');

SCL.Humero_L.u = normalize(cross(SCL.Humero_L.v, SCL.Humero_L.w, 2), 2, 'norm');

%% ========================================================================
%% ANTEBRAZO - Sección 1.2.4 (Ecuaciones 13-16)
%% ========================================================================
% DERECHO
SCL.Antebrazo_R.Origen = mar.R_US;

% Y_A: de US a Codo (proximal) - Ecuación 13
SCL.Antebrazo_R.v = normalize((SCL.Codo_R - mar.R_US), 2, 'norm');

% X_A: perpendicular al plano (US, RS, Codo), adelante - Ecuación 14
SCL.Antebrazo_R.u = normalize(cross(SCL.Antebrazo_R.v, ...
                                    (mar.R_RS - mar.R_US), 2), 2, 'norm');

% Z_A: perpendicular a X_A y Y_A, derecha - Ecuación 16
SCL.Antebrazo_R.w = normalize(cross(SCL.Antebrazo_R.u, ...
                                    SCL.Antebrazo_R.v, 2), 2, 'norm');

% IZQUIERDO
SCL.Antebrazo_L.Origen = mar.L_US;

SCL.Antebrazo_L.v = normalize((SCL.Codo_L - mar.L_US), 2, 'norm');

% Ecuación 15 (orden invertido para izquierdo)
SCL.Antebrazo_L.u = normalize(cross((mar.L_RS - mar.L_US), ...
                                    SCL.Antebrazo_L.v, 2), 2, 'norm');

SCL.Antebrazo_L.w = normalize(cross(SCL.Antebrazo_L.u, ...
                                    SCL.Antebrazo_L.v, 2), 2, 'norm');

%% ========================================================================
%% MUÑECA - Ecuación 17
%% ========================================================================
SCL.Muneca_R = (mar.R_US + mar.R_RS) / 2;
SCL.Muneca_L = (mar.L_US + mar.L_RS) / 2;

%% ========================================================================
%% MANO - Sección 1.2.5 (Ecuaciones 18, 21-23) - USANDO MCP3
%% ========================================================================
% DERECHA
SCL.Mano_R.Origen = SCL.Muneca_R;

% Y_M: de MCP3 a Muñeca (proximal) - Ecuación 18 modificada
SCL.Mano_R.v = normalize((SCL.Muneca_R - mar.R_MCP3), 2, 'norm');

% X_M: normal al plano (US, RS, MCP3), adelante - Ecuación 21
SCL.Mano_R.u = normalize(cross((mar.R_US - mar.R_MCP3), ...
                               (mar.R_RS - mar.R_MCP3), 2), 2, 'norm');

% Z_M: perpendicular a X_M y Y_M - Ecuación 23
SCL.Mano_R.w = cross(SCL.Mano_R.u, SCL.Mano_R.v, 2);

% IZQUIERDA
SCL.Mano_L.Origen = SCL.Muneca_L;

SCL.Mano_L.v = normalize((SCL.Muneca_L - mar.L_MCP3), 2, 'norm');

% Ecuación 22 (orden invertido para izquierdo)
SCL.Mano_L.u = normalize(cross((mar.L_RS - mar.L_MCP3), ...
                               (mar.L_US - mar.L_MCP3), 2), 2, 'norm');

SCL.Mano_L.w = cross(SCL.Mano_L.u, SCL.Mano_L.v, 2);

end