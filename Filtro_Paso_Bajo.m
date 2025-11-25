%% Filtro Pasa-Bajos - Analisis de Audio
clc; clear; close all;

%% 1. Cargar audio
[x, Fs] = audioread('audio_30s.wav');

% Convertir a mono si es estereo
if size(x,2) > 1
    x = mean(x, 2);
end

t = (0:length(x)-1)/Fs;

%% 2. Definir respuesta al impulso h(t)
a = 5;
t_h = 0:1/Fs:1;
h = exp(-a*t_h)';

%% 3. Aplicar convolucion
y_full = conv(x, h);
y = y_full(1:length(x));

%% 4. Graficar resultados
figure('Name','Filtro Pasa-Bajos','Color',[1 1 1],'Position',[100 100 1200 800]);

subplot(3,1,1);
plot(t, x, 'b');
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Senal Original x(t)');
grid on;

subplot(3,1,2);
plot(t_h, h, 'r', 'LineWidth',1.5);
xlabel('Tiempo [s]');
ylabel('h(t)');
title('Respuesta al Impulso h(t) - Filtro Pasa-Bajos');
grid on;

subplot(3,1,3);
plot(t, y, 'g');
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Senal Filtrada y(t) = x(t) * h(t)');
grid on;

sgtitle('Analisis de Senal de Audio con Filtro Pasa-Bajos');

%% 5. Guardar audio filtrado
audiowrite('audio_30s_filtrado.wav', y, Fs);
disp('Archivo filtrado guardado como audio_30s_filtrado.wav');
