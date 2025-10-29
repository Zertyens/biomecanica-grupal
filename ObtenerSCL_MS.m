function SCL = ObtenerSCL_MS(mar, CA)
% Función para calcular Sistemas Coordenados Locales (SCL) 
% para miembro superior según modelo ISB
%
% Entradas:
%   mar - estructura con marcadores
%   CA - estructura con centros articulares calculados
%
% Salidas:
%   SCL - estructura con sistemas coordenados locales (versores X, Y, Z)

%% ========================================================================
%% PELVIS (Sección 1.2.1)
%% ========================================================================
% Eje Z: línea que conecta ASIS (apuntando a la derecha) - Ecuación (1)
SCL.Pelvis.Z = normalize((mar.R_ASIS - mar.L_ASIS), 2, 'norm');

% Eje Y: perpendicular al plano ASIS-SACRO (apuntando arriba) - Ecuación (2)
SCL.Pelvis.Y = normalize(cross((mar.SACRUM - mar.L_ASIS), ...
                                (mar.R_ASIS - mar.L_ASIS), 2), 2, 'norm');

% Eje X: perpendicular a Y y Z (apuntando adelante) - Ecuación (3)
SCL.Pelvis.X = normalize(cross(SCL.Pelvis.Y, SCL.Pelvis.Z, 2), 2, 'norm');

%% ========================================================================
%% TÓRAX (Sección 1.2.2)
%% ========================================================================
% Punto medio superior: (IJ + C7)/2
pm_superior = (mar.IJ + mar.C7) / 2;

% Punto medio inferior: (PX + T8)/2 o (AX + T8)/2
if isfield(mar, 'PX')
    pm_inferior = (mar.PX + mar.T8) / 2;
elseif isfield(mar, 'AX')
    pm_inferior = (mar.AX + mar.T8) / 2;
else
    error('Se necesita marcador PX o AX para el tórax');
end

% Eje Y: conecta punto medio inferior con superior (apuntando arriba) - Ecuación (4)
SCL.Torax.Y = normalize((pm_superior - pm_inferior), 2, 'norm');

% Eje Z: perpendicular al plano IJ-C7-pm_inferior (apuntando derecha) - Ecuación (5)
SCL.Torax.Z = normalize(cross((mar.C7 - mar.IJ), ...
                               (pm_inferior - mar.IJ), 2), 2, 'norm');

% Eje X: perpendicular a Y y Z (apuntando adelante) - Ecuación (6)
SCL.Torax.X = normalize(cross(SCL.Torax.Y, SCL.Torax.Z, 2), 2, 'norm');

%% ========================================================================
%% ANTEBRAZO DERECHO (Sección 1.2.4) - Se calcula primero porque Húmero lo necesita
%% ========================================================================
% Eje Y: de US a codo (apuntando proximal) - Ecuación (13)
SCL.Antebrazo_R.Y = normalize((CA.Codo_R - mar.R_US), 2, 'norm');

% Eje X: perpendicular al plano US-RS-Codo (adelante) - Ecuación (14)
SCL.Antebrazo_R.X = normalize(cross(SCL.Antebrazo_R.Y, ...
                                     (mar.R_RS - mar.R_US), 2), 2, 'norm');

% Eje Z: perpendicular a X y Y (derecha) - Ecuación (16)
SCL.Antebrazo_R.Z = normalize(cross(SCL.Antebrazo_R.X, ...
                                     SCL.Antebrazo_R.Y, 2), 2, 'norm');

%% ========================================================================
%% ANTEBRAZO IZQUIERDO (Sección 1.2.4)
%% ========================================================================
% Eje Y: de US a codo (apuntando proximal) - Ecuación (13)
SCL.Antebrazo_L.Y = normalize((CA.Codo_L - mar.L_US), 2, 'norm');

% Eje X: perpendicular al plano US-RS-Codo (adelante) - Ecuación (15)
% Orden invertido para lado izquierdo
SCL.Antebrazo_L.X = normalize(cross((mar.L_RS - mar.L_US), ...
                                     SCL.Antebrazo_L.Y, 2), 2, 'norm');

% Eje Z: perpendicular a X y Y (izquierda para este lado) - Ecuación (16)
SCL.Antebrazo_L.Z = normalize(cross(SCL.Antebrazo_L.X, ...
                                     SCL.Antebrazo_L.Y, 2), 2, 'norm');

%% ========================================================================
%% HÚMERO DERECHO (Sección 1.2.3)
%% ========================================================================
% Eje Y: de codo a GH (apuntando proximal) - Ecuación (10)
SCL.Humero_R.Y = normalize((CA.GH_R - CA.Codo_R), 2, 'norm');

% Eje Z: perpendicular al plano formado por Y_H2 y Y_A (derecha) - Ecuación (11)
SCL.Humero_R.Z = normalize(cross(SCL.Humero_R.Y, ...
                                  SCL.Antebrazo_R.Y, 2), 2, 'norm');

% Eje X: perpendicular a Y y Z (adelante) - Ecuación (12)
SCL.Humero_R.X = normalize(cross(SCL.Humero_R.Y, ...
                                  SCL.Humero_R.Z, 2), 2, 'norm');

%% ========================================================================
%% HÚMERO IZQUIERDO (Sección 1.2.3)
%% ========================================================================
% Eje Y: de codo a GH (apuntando proximal) - Ecuación (10)
SCL.Humero_L.Y = normalize((CA.GH_L - CA.Codo_L), 2, 'norm');

% Eje Z: perpendicular al plano formado por Y_H2 y Y_A - Ecuación (11)
SCL.Humero_L.Z = normalize(cross(SCL.Humero_L.Y, ...
                                  SCL.Antebrazo_L.Y, 2), 2, 'norm');

% Eje X: perpendicular a Y y Z (adelante) - Ecuación (12)
SCL.Humero_L.X = normalize(cross(SCL.Humero_L.Y, ...
                                  SCL.Humero_L.Z, 2), 2, 'norm');

%% ========================================================================
%% MANO DERECHA (Sección 1.2.5)
%% ========================================================================
% Verificar si se usa MCP3 o MCP2+MCP5
if isfield(mar, 'R_MCP3')
    pm_metacarpos_R = mar.R_MCP3;
else
    pm_metacarpos_R = (mar.R_MCP2 + mar.R_MCP5) / 2;
end

% Eje Y: de punto medio metacarpos a muñeca (proximal) - Ecuación (18)
SCL.Mano_R.Y = normalize((CA.Muneca_R - pm_metacarpos_R), 2, 'norm');

% Eje X: perpendicular al plano MCP-Muñeca (adelante)
if isfield(mar, 'R_MCP3')
    % Ecuación (21) - usando MCP3
    SCL.Mano_R.X = normalize(cross((mar.R_US - mar.R_MCP3), ...
                                    (mar.R_RS - mar.R_MCP3), 2), 2, 'norm');
else
    % Ecuación (19) - usando MCP2 y MCP5
    SCL.Mano_R.X = normalize(cross((mar.R_MCP2 - CA.Muneca_R), ...
                                    (mar.R_MCP5 - CA.Muneca_R), 2), 2, 'norm');
end

% Eje Z: perpendicular a X y Y - Ecuación (23)
SCL.Mano_R.Z = cross(SCL.Mano_R.X, SCL.Mano_R.Y, 2);

%% ========================================================================
%% MANO IZQUIERDA (Sección 1.2.5)
%% ========================================================================
% Verificar si se usa MCP3 o MCP2+MCP5
if isfield(mar, 'L_MCP3')
    pm_metacarpos_L = mar.L_MCP3;
else
    pm_metacarpos_L = (mar.L_MCP2 + mar.L_MCP5) / 2;
end

% Eje Y: de punto medio metacarpos a muñeca (proximal) - Ecuación (18)
SCL.Mano_L.Y = normalize((CA.Muneca_L - pm_metacarpos_L), 2, 'norm');

% Eje X: perpendicular al plano MCP-Muñeca (adelante)
if isfield(mar, 'L_MCP3')
    % Ecuación (22) - usando MCP3 (orden invertido para izquierda)
    SCL.Mano_L.X = normalize(cross((mar.L_RS - mar.L_MCP3), ...
                                    (mar.L_US - mar.L_MCP3), 2), 2, 'norm');
else
    % Ecuación (20) - usando MCP2 y MCP5 (orden invertido para izquierda)
    SCL.Mano_L.X = normalize(cross((mar.L_MCP5 - CA.Muneca_L), ...
                                    (mar.L_MCP2 - CA.Muneca_L), 2), 2, 'norm');
end

% Eje Z: perpendicular a X y Y - Ecuación (23)
SCL.Mano_L.Z = cross(SCL.Mano_L.X, SCL.Mano_L.Y, 2);

fprintf('Sistemas coordenados locales calculados.\n');

end