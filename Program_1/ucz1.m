function [Wpo] = ucz1 (Wprzed , P , T , n)
  liczbaPrzykladow = size (P,2);
  liczbaWyjsc = size (T,1);
  W = Wprzed;
  wspUcz = 0.1 ; beta = 5;
  MSE = zeros (1,n);
  for i = 1 : n ,
    % losuj numer przykladu
    nrPrzykladu = randi (liczbaPrzykladow);
    % podaj przyklad na wejscia i oblicz wyjscia
    X = P ( : , nrPrzykladu) ;
    Y = dzialaj1 (W,X);
    % oblicz bledy wyjscia
    D = T (: , nrPrzykladu) - Y;

    E = D .* beta.*Y.*(1-Y); % dla pedantow - razy pochodna...
    % oblicz poprawki wag
    dW = wspUcz * X * E' ;
    % dodaj poprawki do wag
    W = W + dW ;
    MSE (i) = 0.5 * 1/liczbaWyjsc * D' * D; % do wykresu bledu

  endfor % i to wszystko n razy
  Wpo = W ;

