% WIZUALIZACJA_UCZENIA_CLI.M - Wykresy tekstowe z osiami dopasowanymi co do znaku
1;

if !exist('hist_w2_ciag', 'var') || !exist('hist_ce', 'var') || !exist('hist_w1', 'var')
    error('Błąd: Brak kompletnych danych uczenia w pamięci. Uruchom najpierw test2.m!');
endif

szerokosc_wykresu = 41; 
liczba_punktow = length(hist_w2_ciag);
krok = max(1, floor(liczba_punktow / 20));

disp(' ');
disp('========================================================================');
disp('            PANEL RAPORTÓW TEKSTOWYCH CLI ');
disp('========================================================================');

% =====================================================================
% WYKRES 1: Globalny błąd średniokwadratowy (MSE) - zakres [0.0 - 0.40]
% =====================================================================
disp(' ');
disp('--- [1/3] GLOBALNY BŁĄD ŚREDNIOKWADRATOWY (MSE) ---');
disp('                    0.0       0.10      0.20      0.30      0.40');
disp('                    |---------|---------|---------|---------|');

for idx = 1:krok:liczba_punktow
    val = hist_w2_ciag(idx);
    pos = round((val / 0.40) * (szerokosc_wykresu - 1)) + 1;
    pos = max(1, min(szerokosc_wykresu, pos));
    
    linia = repmat('.', 1, szerokosc_wykresu);
    linia(pos) = '*';
    fprintf('Epoka %4d [%.4f] | %s\n', idx, val, linia);
endfor
disp('                    |---------|---------|---------|---------|');


% =====================================================================
% WYKRES 2: Błąd klasyfikacji (CE) - zakres [0% - 100%]
% =====================================================================
disp(' ');
disp('--- [2/3] BŁĄD KLASYFIKACJI (CE [%]) ---');
disp('                    0%        25%       50%       75%       100%');
disp('                    |---------|---------|---------|---------|');

for idx = 1:krok:liczba_punktow
    val = hist_ce(idx);
    pos = round((val / 100) * (szerokosc_wykresu - 1)) + 1;
    pos = max(1, min(szerokosc_wykresu, pos));
    
    linia = repmat('.', 1, szerokosc_wykresu);
    linia(pos) = '#';
    fprintf('Epoka %4d [%5.1f%%] | %s\n', idx, val, linia);
endfor
disp('                    |---------|---------|---------|---------|');


% =====================================================================
% WYKRES 3: Wskaźnik energii zmian wagowych (WAG) - zakres [0.0 - 0.10]
% =====================================================================
disp(' ');
disp('--- [3/3] WSKAŹNIK ENERGII ZMIAN WAGOWYCH (WAG) ---');
disp('                    0.0       0.025     0.05      0.075     0.10');
disp('                    |---------|---------|---------|---------|');

for idx = 1:krok:liczba_punktow
    val = hist_w1(idx);
    pos = round((val / 0.10) * (szerokosc_wykresu - 1)) + 1;
    pos = max(1, min(szerokosc_wykresu, pos));
    
    linia = repmat('.', 1, szerokosc_wykresu);
    linia(pos) = 'o';
    fprintf('Epoka %4d [%.4f] | %s\n', idx, val, linia);
endfor
disp('                    |---------|---------|---------|---------|');
disp('========================================================================');