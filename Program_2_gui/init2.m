function [W1, W2] = init2 (S, K1, K2)
%INIT2 Losowa inicjalizacja macierzy wag dwuwarstwowej sieci neuronowej.
%
%   Użycie:
%       [W1, W2] = init2(S, K1, K2)
%
%   Argumenty wejściowe:
%       S  - Liczba wejść sieci (rozmiar wektora cech, np. 2 dla XOR)
%       K1 - Liczba neuronów w warstwie ukrytej (pierwszej)
%       K2 - Liczba neuronów w warstwie wyjściowej (drugiej)
%
%   Argumenty wyjściowe:
%       W1 - Macierz wag dla warstwy ukrytej o wymiarach (S + 1) x K1
%       W2 - Macierz wag dla warstwy wyjściowej o wymiarach (K1 + 1) x K2
%
%   Opis:
%       Funkcja losuje wagi początkowe z rozkładu jednostajnego w przedziale
%       od -0.1 do 0.1. Uwzględnia dodatkowy wiersz dla wag przesunięcia (bias).

  % Losowanie wag warstwy 1: zakres [0,1] * 0.2 -> [0, 0.2] - 0.1 -> [-0.1, 0.1]
  W1 = rand (S + 1, K1) * 0.2 - 0.1;
  
  % Losowanie wag warstwy 2: zakres [-0.1, 0.1]
  W2 = rand (K1 + 1, K2) * 0.2 - 0.1;

endfunction