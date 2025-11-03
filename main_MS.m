%% Main - Análisis de Miembro Superior

clear all
close all
clc

%% Cargar datos
[Datos, fileName] = CargarRegistroMS();
ant = CargarAntropometriaMS();

fprintf('\nArchivo cargado: %s\n', fileName);

%% Acceder a los datos
% Los marcadores están en:
mar = Datos.Registro.Marcadores.Crudos.Valores;

% La frecuencia de muestreo:
fm = Datos.info.Cinematica.frequency;

%% Filtrado
frec_corte = 10;
orden = 4;
mar_filt = FiltrarStruct(mar, fm, frec_corte, orden);

%% Sistemas coordenados locales
SCL = ObtenerSCL_MS(mar, ant);

% Graficar
Graficar_SCL_MS(SCL)
Graficar_SCL_MS_Juntos(SCL, 5, 0.08)

%% Excursión angular
angulos = ObtenerAngulos_MS(SCL);

Graficar_Angulos_MS(angulos)