function [Antropometria] = CargarAntropometriaMS()
% Función que crea la estructura de antropometría con valores registrados a
% mano (falta cargar los correctos, puse los que me dio Chatty)
%
% Salida:
% Antropometria - estructura con medidas antropométricas

%% Datos generales del sujeto
Antropometria.Masa.Valor = 75;  % kg
Antropometria.Masa.Unidad = 'kg';

Antropometria.Altura.Valor = 1.94;  % m
Antropometria.Altura.Unidad = 'm';

Antropometria.Sexo = 'M';  % 'M' o 'F'

%% Medidas específicas para miembro superior
% Distancia entre acromiones (ancho de hombros)
Antropometria.DistanciaAcromiones.Valor = 0.42;  % m
Antropometria.DistanciaAcromiones.Unidad = 'm';

% Longitud del húmero (acromion a epicóndilo lateral)
Antropometria.LongitudHumeroR.Valor = 0.36;  % m
Antropometria.LongitudHumeroR.Unidad = 'm';

Antropometria.LongitudHumeroL.Valor = 0.36;  % m
Antropometria.LongitudHumeroL.Unidad = 'm';

% Longitud del antebrazo (epicóndilo lateral a estiloides radial)
Antropometria.LongitudAntebrazoR.Valor = 0.29;  % m
Antropometria.LongitudAntebrazoR.Unidad = 'm';

Antropometria.LongitudAntebrazoL.Valor = 0.29;  % m
Antropometria.LongitudAntebrazoL.Unidad = 'm';

% Longitud de la mano (estiloides radial a punta del dedo medio)
Antropometria.LongitudManoR.Valor = 0.21;  % m
Antropometria.LongitudManoR.Unidad = 'm';

Antropometria.LongitudManoL.Valor = 0.21;  % m
Antropometria.LongitudManoL.Unidad = 'm';

% Ancho de la pelvis (distancia entre ASIS)
Antropometria.AnchoPelvis.Valor = 0.31;  % m
Antropometria.AnchoPelvis.Unidad = 'm';

fprintf('Estructura de antropometría creada. \n');

end