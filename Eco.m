%% Sistema de Eco con dos retardos - Analisis de Audio
clc; clear; close all;

%% 1. Cargar audio
[x, Fs] = audioread('audio_30s.wav'); % archivo WAV de 10 s (ajusta nombre)

if size(x,2) > 1
    x = mean(x, 2); % convertir a mono
end

t = (0:length(x)-1)/Fs;

%% 2. Definir respuesta al impulso h(t)
T1 = 1;            % primer retardo = 1s
T2 = 2;            % segundo retardo = 2s
alpha1 = 0.8;      % atenuacion primer eco
alpha2 = 0.5;      % atenuacion segundo eco

N_delay1 = round(T1 * Fs);
N_delay2 = round(T2 * Fs);

max_delay = max(N_delay1, N_delay2);

t_h = (0:max_delay)/Fs;

h = zeros(max_delay+1,1);
h(1) = 1;          % delta(t)
h(N_delay1+1) = alpha1;  % eco en t = 1s
h(N_delay2+1) = alpha2;  % eco en t = 2s

%% 3. Aplicar convolucion sin recortar
y = conv(x, h);
t_y = (0:length(y)-1)/Fs;

%% 4. Normalizar salida para max = 1


%% 5. Graficar
figure('Name','Sistema de Eco con dos retardos','Color',[1 1 1],'Position',[100 100 1200 800]);

subplot(3,1,1);
plot(t, x, 'b');
xlabel('Tiempo [s]'); ylabel('Amplitud');
title('Senal Original x(t)');
grid on;

subplot(3,1,3);
stem(t_h, h, 'filled', 'r');
xlabel('Tiempo [s]'); ylabel('h(t)');
title('Respuesta al Impulso - Sistema de Eco con dos retardos');
grid on;

subplot(3,1,2);
plot(t_y, y, 'g');
xlabel('Tiempo [s]'); ylabel('Amplitud');
title('Salida Completa con Eco y(t) = x(t) * h(t)');
grid on;

sgtitle('Analisis de Senal de Audio con Sistema de Eco de dos retardos');

%% 6. Guardar audio completo y normalizado
audiowrite('audio_10s_eco_dos_retardos.wav', y, Fs);
disp('Archivo guardado: audio_10s_eco_dos_retardos.wav');
