%% Filtro Pasa-Altas - Analisis de Audio
clc; clear; close all;

%% 1. Cargar audio
[x, Fs] = audioread('audio_30s.wav');

% Convertir a mono si el archivo es estéreo
if size(x,2) > 1
    x = mean(x, 2);
end

t = (0:length(x)-1)/Fs;

%% 2. Definir la respuesta al impulso h(t) del filtro pasa-altas
% h(t) = δ(t) - e^{-a t} u(t)

a = 5;   % Constante del filtro (ajustable)

t_h = 0:1/Fs:1;         % Duración de 1 segundo para la cola exponencial
h_low = exp(-a*t_h)';   % Parte exponencial (del pasa-bajos)
h = [1; -h_low];        % δ(t) se representa como un 1 en la primera muestra

%% 3. Aplicar la convolución
y_full = conv(x, h, 'full');
y = y_full(1:length(x));   % Recortar para igualar longitud original

%% 4. Graficar resultados
figure('Name','Filtro Pasa-Altas','Color',[1 1 1],'Position',[100 100 1200 800]);

subplot(3,1,1);
plot(t, x, 'b');
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Señal Original x(t)');
grid on;

subplot(3,1,2);
plot((0:length(h)-1)/Fs, h, 'r', 'LineWidth',1.5);
xlabel('Tiempo [s]');
ylabel('h(t)');
title('Respuesta al Impulso h(t) - Filtro Pasa-Altas');
grid on;

subplot(3,1,3);
plot(t, y, 'g');
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Señal Filtrada y(t) = x(t) * h(t)');
grid on;

sgtitle('Análisis de Señal de Audio con Filtro Pasa-Altas');

%% 5. Guardar audio filtrado
audiowrite('audio_30s_filtrado_pasa_altas.wav', y, Fs);
disp('Audio filtrado guardado como audio_30s_filtrado_pasa_altas.wav');