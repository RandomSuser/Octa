% TEST2 to RUN - Skrypt uruchomieniowy i testowy dla sieci neuronowej
1;

% --- 1. DEFINICJA PROBLEMU LOGICZNEGO (XOR - Exclusive OR) ---
% Macierz P - Wejścia sieci (4 przykłady, każdy ma 2 cechy)
% Kolumny reprezentują kolejne kombinacje stanów logicznych:
% Kolumna 1: [0; 0] -> Fałsz i Fałsz
% Kolumna 2: [0; 1] -> Fałsz i Prawda
% Kolumna 3: [1; 0] -> Prawda i Fałsz
% Kolumna 4: [1; 1] -> Prawda i Prawda
P = [
  0 0 1 1 ;
  0 1 0 1
];

% Macierz T - Zadane (oczekiwane) wyjścia sieci dla problemu XOR
% Odpowiada kolumnom z macierzy P:
% Wynik 0: dla wejścia [0; 0] (stany są takie same)
% Wynik 1: dla wejścia [0; 1] (stany są różne)
% Wynik 1: dla wejścia [1; 0] (stany są różne)
% Wynik 0: dla wejścia [1; 1] (stany są takie same)
T = [
  0 1 1 0
];


% --- 2. INICJALIZACJA STRUKTURY SIECI ---
% Funkcja init2(wejścia, neurony_ukryte, wyjścia)
% Tworzymy najmniejszą architekturę zdolną rozwiązać problem XOR:
% 2 wejścia, 2 neurony w warstwie ukrytej, 1 neuron w warstwie wyjściowej
[W1przed, W2przed] = init2(2, 2, 1); 

%{
  % Alternatywne, większe (łatwiejsze do wyuczenia) struktury sieci:
  [W1przed, W2przed] = init2 (2, 4, 1);
  [W1przed, W2przed] = init2 (2, 5, 1);
%}


% --- 3. TEST SIECI PRZED UCZENIEM (STAN POCZĄTKOWY) ---
% WYMUSZENIE CZYTELNEGO FORMATU LICZB (cztery miejsca po przecinku, bez notacji e-03)
format short ;

% Przepuszczamy każdy z 4 przykładów przez niewytrenowaną sieć (losowe wagi)
[Y1, Y2a] = dzialaj2(W1przed, W2przed, P(:, 1));
[Y1, Y2b] = dzialaj2(W1przed, W2przed, P(:, 2));
[Y1, Y2c] = dzialaj2(W1przed, W2przed, P(:, 3));
[Y1, Y2d] = dzialaj2(W1przed, W2przed, P(:, 4));

% Yprzed - Wektor odpowiedzi sieci przed procesem uczenia.
% Wartości będą bliskie losowym (np. w okolicach 0.5), zupełnie niezgodne z macierzą T.
disp('Odpowiedzi sieci PRZED uczeniem:');
Yprzed = [Y2a, Y2b, Y2c, Y2d]
disp(' ');


% --- 4. PROCES UCZENIA SIECI ---
% Wywołanie zaktualizowanej funkcji ucz2 z nowym zestawem parametrów:
% Argumenty: wagi startowe, dane P, cele T, max epok (4500), k (liczba pokazów w kroku = 1)
% Zwraca: zoptymalizowane macierze wag W1po i W2po oraz pełną historię błędów do wykresów.
max_epok = 4500;
k_pokazow = 1; % 1 = klasyczne uczenie stochastyczne (przykład po przykładzie)

[W1po, W2po, hist_w1, hist_w2_ciag, hist_ce] = ucz2(W1przed, W2przed, P, T, max_epok, k_pokazow);


% --- 5. TEST SIECI PO UCZENIU (STAN KOŃCOWY) ---
% Przepuszczamy te same przykłady przez sieć o skorygowanych wagach
[Y1, Y2a] = dzialaj2(W1po, W2po, P(:, 1));
[Y1, Y2b] = dzialaj2(W1po, W2po, P(:, 2));
[Y1, Y2c] = dzialaj2(W1po, W2po, P(:, 3));
[Y1, Y2d] = dzialaj2(W1po, W2po, P(:, 4));

% Ypo - Wektor odpowiedzi sieci po zakończeniu uczenia.
% Jeśli uczenie przebiegło pomyślnie, wartości powinny idealnie dążyć do założeń z macierzy T,
% czyli osiągnąć wartości zbliżone do: [0.0... , 0.9... , 0.9... , 0.0...]
disp('Odpowiedzi sieci PO uczeniu:');
Ypo = [Y2a, Y2b, Y2c, Y2d]