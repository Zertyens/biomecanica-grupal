function Angulos = ObtenerAngulos_MS(SCL)
% Calcula excursiones angulares de articulaciones del miembro superior según ISB
%
% Entradas:
%   SCL - estructura con sistemas coordenados locales
%
% Salidas:
%   Angulos - estructura con ángulos articulares (en grados)

%% ========================================================================
%% HOMBRO - Sección 1.3.1 (Ecuaciones 24-28)
%% ========================================================================

% DERECHO
% e1_hombro = Y_T (fijo al tórax)
% Versor auxiliar I_hombro (ecuación 24)
I_hombro_R = normalize(cross(SCL.Humero_R.v, SCL.Torax.v, 2), 2, 'norm');

% α_h: Plano de elevación (ecuación 25)
Angulos.Hombro_R.alfa = rad2deg(unwrap(acos(dot(I_hombro_R, SCL.Torax.u, 2)) .* ...
                        sign(dot(I_hombro_R, -SCL.Torax.w, 2))));

% γ_h: Rotación interna(+)/externa(-) (ecuación 27)
Angulos.Hombro_R.gamma = rad2deg(unwrap(acos(dot(SCL.Humero_R.u, I_hombro_R, 2)) .* ...
                         sign(dot(I_hombro_R, SCL.Humero_R.w, 2))));
                     
% β_h: Elevación (ecuación 28)
Angulos.Hombro_R.beta = rad2deg(unwrap(acos(dot(SCL.Humero_R.v, SCL.Torax.v, 2))));

% IZQUIERDO
I_hombro_L = normalize(cross(SCL.Humero_L.v, SCL.Torax.v, 2), 2, 'norm');

% α_h: Plano de elevación (ecuación 26)
Angulos.Hombro_L.alfa = rad2deg(unwrap(acos(dot(I_hombro_L, -SCL.Torax.u, 2)) .* ...
                        sign(dot(I_hombro_L, -SCL.Torax.w, 2))));

% γ_h: Rotación
Angulos.Hombro_L.gamma = rad2deg(unwrap(acos(dot(SCL.Humero_L.u, I_hombro_L, 2)) .* ...
                         sign(dot(I_hombro_L, SCL.Humero_L.w, 2))));

% β_h: Elevación
Angulos.Hombro_L.beta = rad2deg(unwrap(acos(dot(SCL.Humero_L.v, SCL.Torax.v, 2))));
%% ========================================================================
%% CODO - Sección 1.3.2 (Ecuaciones 29-34)
%% ========================================================================

% DERECHO
% Versor auxiliar I_c (ecuación 29)
I_c_R = normalize(cross(SCL.Humero_R.w, SCL.Antebrazo_R.v, 2), 2, 'norm');

% α_c: Flexión(+)/hiperextensión(-) (ecuación 30)
Angulos.Codo_R.alfa = rad2deg(unwrap(-acos(dot(-I_c_R, SCL.Humero_R.u, 2)) .* ...
                      sign(dot(I_c_R, SCL.Humero_R.v, 2))));

% γ_c: Pronación(+)/supinación(-) (ecuación 31)
Angulos.Codo_R.gamma = rad2deg(unwrap(-acos(dot(-I_c_R, SCL.Antebrazo_R.u, 2)) .* ...
                       sign(dot(SCL.Antebrazo_R.u, SCL.Humero_R.w, 2))));

% β_c: Abducción(-)/aducción(+) (ecuación 33)
Angulos.Codo_R.beta = rad2deg(unwrap(asin(dot(SCL.Humero_R.w, SCL.Antebrazo_R.v, 2))));

% IZQUIERDO
I_c_L = normalize(cross(SCL.Humero_L.w, SCL.Antebrazo_L.v, 2), 2, 'norm');

% α_c: Flexión/extensión (ecuación 30)
Angulos.Codo_L.alfa = rad2deg(unwrap(-acos(dot(-I_c_L, SCL.Humero_L.u, 2)) .* ...
                      sign(dot(I_c_L, SCL.Humero_L.v, 2))));

% γ_c: Pronación/supinación (ecuación 32)
Angulos.Codo_L.gamma = rad2deg(unwrap(acos(dot(-I_c_L, SCL.Antebrazo_L.u, 2)) .* ...
                       sign(dot(SCL.Antebrazo_L.u, SCL.Humero_L.w, 2))));

% β_c: Abducción/aducción (ecuación 34)
Angulos.Codo_L.beta = rad2deg(unwrap(-asin(dot(SCL.Humero_L.w, SCL.Antebrazo_L.v, 2))));

%% ========================================================================
%% MUÑECA - Sección 1.3.3 (Ecuaciones 35-39)
%% ========================================================================

% DERECHO
% Versor auxiliar I_m
I_m_R = normalize(cross(SCL.Antebrazo_R.w, SCL.Mano_R.v, 2), 2, 'norm');

% α_m: Flexión(+)/extensión(-) (ecuación 35)
Angulos.Muneca_R.alfa = rad2deg(unwrap(-acos(dot(-I_m_R, SCL.Antebrazo_R.u, 2)) .* ...
                        sign(dot(I_m_R, SCL.Antebrazo_R.v, 2))));

% γ_m: Pronación(+)/supinación(-) (ecuación 36)
Angulos.Muneca_R.gamma = rad2deg(unwrap(-acos(dot(-I_m_R, SCL.Mano_R.u, 2)) .* ...
                         sign(dot(SCL.Mano_R.u, SCL.Antebrazo_R.w, 2))));

% β_m: Desviación radial/cubital = abduccion(-)/aduccion(+) (ecuación 38)
Angulos.Muneca_R.beta = rad2deg(unwrap(asin(dot(SCL.Antebrazo_R.w, SCL.Mano_R.v, 2))));

% IZQUIERDO
I_m_L = normalize(cross(SCL.Antebrazo_L.w, SCL.Mano_L.v, 2), 2, 'norm');

% α_m: Flexión/extensión (ecuación 35)
Angulos.Muneca_L.alfa = rad2deg(unwrap(-acos(dot(-I_m_L, SCL.Antebrazo_L.u, 2)) .* ...
                        sign(dot(I_m_L, SCL.Antebrazo_L.v, 2))));

% γ_m: Pronación/supinación (ecuación 37)
Angulos.Muneca_L.gamma = rad2deg(unwrap(acos(dot(-I_m_L, SCL.Mano_L.u, 2)) .* ...
                         sign(dot(SCL.Mano_L.u, SCL.Antebrazo_L.w, 2))));

% β_m: Desviación radial/cubital (ecuación 39)
Angulos.Muneca_L.beta = rad2deg(unwrap(-asin(dot(SCL.Antebrazo_L.w, SCL.Mano_L.v, 2))));

end