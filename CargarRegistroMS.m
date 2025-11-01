function [Datos,fileName] = CargarRegistroMS()
% Función para cargar archivo c3d para análisis de MIEMBRO SUPERIOR
% Versión simplificada: solo carga datos de MARCADORES
% Los datos antropométricos se cargan por separado
% 
% Salidas:
% "Datos" - estructura con datos de marcadores para miembro superior
% "fileName" - nombre del archivo cargado

[DatosMarcadores, infoCinematica, Eventos, fileName] = Leer_c3d_MS();

% Asignación de datos a la estructura
Datos.Registro.Marcadores.Crudos = DatosMarcadores;  % Datos de marcadores reflectivos
Datos.info.Cinematica = infoCinematica;               % Información cinemática
Datos.eventos = Eventos;                              % Eventos temporales del movimiento

end