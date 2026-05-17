% RUN.M - Główny skrypt sterujący całego projektu laboratoryjnego
% clc;
clear -all;
% clear all;
%clear functions; % <--- TUTAJ! Czyści pamięć podręczną funkcji przed startem
fclose('all');

disp('======================================================================');
disp('   URUCHAMIANIE PEŁNEGO PROCESU: UCZENIE + WIZUALIZACJA + ANALIZA 3D');
disp('======================================================================');
disp(' ');

% --- KROK 1: Inicjalizacja i uruchomienie bazy (test2.m) ---
disp('[KROK 1/4] Ładowanie danych i inicjalizacja wag (test2.m)...');
test2;
disp(' ');

% --- KROK 2: Wizualizacja tekstowa w konsoli (CLI) ---
disp('[KROK 2/4] Generowanie raportu tekstowego i wykresów ASCII...');
wizualizacja_uczenia_cli;
disp(' ');

% --- KROK 3: Wizualizacja graficzna (Gnuplot) ---
disp('[KROK 3/4] Uruchamianie graficznej wizualizacji uczenia (Gnuplot)...');
wizualizacja_uczenia;
disp(' ');

% --- KROK 4: Analiza krajobrazu błędu 2D i 3D ---
disp('[KROK 4/4] Generowanie trójwymiarowej powierzchni błędu (3D)...');
analiza3d;

disp(' ');
disp('======================================================================');
disp('   PROCES ZAKOŃCZONY POMYŚLNIE! WSZYSTKIE WYKRESY SĄ GOTOWE.');
disp('======================================================================');