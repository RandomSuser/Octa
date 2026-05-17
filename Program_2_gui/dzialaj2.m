function [Y1, Y2] = dzialaj2 (W1, W2, X)
%DZIALAJ2 Realizuje propagację sygnału w przód (Forward Propagation) 
%         dla dwuwarstwowej sieci neuronowej.
%
%   Użycie:
%       [Y1, Y2] = dzialaj2(W1, W2, X)
%
%   Argumenty wejściowe:
%       W1 - Macierz wag warstwy ukrytej (wymiary: [S+1 x K1])
%       W2 - Macierz wag warstwy wyjściowej (wymiary: [K1+1 x K2])
%       X  - Pionowy wektor sygnałów wejściowych (wymiary: [S x 1])
%
%   Argumenty wyjściowe:
%       Y1 - Wektor wyjściowy warstwy ukrytej (wymiary: [K1 x 1])
%       Y2 - Wektor wyjściowy warstwy wyjściowej (całej sieci) (wymiary: [K2 x 1])
%
%   Opis:
%       Funkcja oblicza odpowiedzi poszczególnych warstw sieci neuronowej
%       przy użyciu unipolarnej funkcji aktywacji (sigmoidy) ze współczynnikiem
%       stromości beta. Automatycznie uwzględnia sygnał polaryzacji (bias = -1).

  % Współczynnik stromości funkcji aktywacji
  beta = 5;

  % --- WARSTWA 1 (UKRYTA) ---
  % Dopisywanie wartości -1 na początku wektora wejściowego X (sygnał biasu)
  X1 = [ -1 ; X ];
  
  % Obliczenie potencjału układu U1 jako iloczynu skalarnego wag i wejścia rozszerzonego
  U1 = W1' * X1;
  
  % Przepuszczenie potencjału przez unipolarną funkcję sigmoidalną
  Y1 = 1 ./ ( 1 + exp( -beta * U1 ) );

  % --- WARSTWA 2 (WYJŚCIOWA) ---
  % Wyjścia warstwy pierwszej (Y1) stają się wejściami dla warstwy drugiej.
  % Ponownie dopisujemy wartość -1 na początku wektora (sygnał biasu dla warstwy 2)
  X2 = [ -1 ; Y1 ];
  
  % Obliczenie potencjału układu U2 dla neuronów wyjściowych
  U2 = W2' * X2;
  
  % Obliczenie ostatecznej odpowiedzi sieci (Y2) przy użyciu tej samej funkcji aktywacji
  Y2 = 1 ./ ( 1 + exp( -beta * U2 ) );

endfunction