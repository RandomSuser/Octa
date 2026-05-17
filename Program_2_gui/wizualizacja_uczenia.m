% WIZUALIZACJA_UCZENIA.M - Graficzny wykres zbieżności w układzie kafelkowym 2x2
1;

if !exist('hist_w2_ciag', 'var') || !exist('hist_ce', 'var')
    error('Błąd: Brak danych do wykresów. Uruchom najpierw test2.m!');
endif

graphics_toolkit('gnuplot');

% Tworzymy szerokie, kwadratowe okno idealne pod układ 2x2
figure('position', [150, 150, 950, 700]);

% --- PANEL 1: Średni błąd kwadratowy (MSE) -> Lewy Górny Róg ---
subplot(2, 2, 1);
plot(hist_w2_ciag, 'r', 'LineWidth', 1.5);
title('Globalny błąd średniokwadratowy (MSE)');
xlabel('Epoki'); ylabel('Błąd');
grid on;

% --- PANEL 2: Błąd klasyfikacji (CE %) -> Prawy Górny Róg ---
subplot(2, 2, 2);
plot(hist_ce, 'b', 'LineWidth', 1.5);
title('Błąd klasyfikacji (CE [%] - margines 0.3)');
xlabel('Epoki'); ylabel('Procent [%]');
grid on;

% --- PANEL 3: Energia zmian wagowych -> Lewy Dolny Róg ---
subplot(2, 2, 3);
plot(hist_w1, 'g', 'LineWidth', 1.5);
title('Wskaźnik energii zmian wagowych');
xlabel('Epoki'); ylabel('Wartość');
grid on;

% Czwarte okienko (prawy dolny róg) zostaje puste, co daje idealny oddech 
% i sprawia, że żadne wykresy nie są ściśnięte w pionie.

drawnow();