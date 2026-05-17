function [W1po, W2po, hist_w1, hist_w2_ciag, hist_ce] = ucz2 (W1przed, W2przed, P, T, n, k)
    liczbaPrzykladow = size (P,2);
    W1 = W1przed; W2 = W2przed;
    
    beta = 5; alpha = 0.9;
    eta = 0.1; rho_d = 0.7; rho_i = 1.05; k_w = 1.04;
    
    % Tablice na historię dla wizualizacji
    hist_w1 = zeros(1, n); hist_w2_ciag = zeros(1, n); hist_ce = zeros(1, n);

    Y2_init = zeros(1, liczbaPrzykladow);
    for s = 1:liczbaPrzykladow
        [~, Y2_init(s)] = dzialaj2(W1, W2, P(:, s));
    end
    E_old = sum((T - Y2_init).^2) / liczbaPrzykladow;

    dw1_old = zeros(size(W1)); dw2_old = zeros(size(W2));

    for i = 1 : n
        % --- NOWOŚĆ: Zerowanie sumatorów dla paczki k przykładów ---
        dw1_batch = zeros(size(W1));
        dw2_batch = zeros(size(W2));

        % --- NOWOŚĆ: Pętla zbierająca błędy z k pokazów ---
        for j = 1 : k
            nrPrzykladu = randi(liczbaPrzykladow);
            X = P(:, nrPrzykladu); X1 = [-1; X];
            [Y1, Y2] = dzialaj2(W1, W2, X); X2 = [-1; Y1];

            D2 = T(:, nrPrzykladu) - Y2;
            E2 = beta * D2 .* Y2 .* (1 - Y2);
            D1 = W2(2:end, :) * E2;
            E1 = beta * D1 .* Y1 .* (1 - Y1);

            % Kumulujemy poprawki z każdego pokazu wewnątrz kroku
            dw1_batch = dw1_batch + (X1 * E1');
            dw2_batch = dw2_batch + (X2 * E2');
        endfor

        % --- NOWOŚĆ: Wyznaczenie średniej poprawki dla kroku ---
        dw1_curr = dw1_batch / k;
        dw2_curr = dw2_batch / k;

        % Reszta algorytmu (Momentum, Adaptacja, Wykresy) zostaje bez zmian
        dW1 = (eta * dw1_curr) + (alpha * dw1_old);
        dW2 = (eta * dw2_curr) + (alpha * dw2_old);

        W1_new = W1 + dW1; W2_new = W2 + dW2;

        Y2_all = zeros(1, liczbaPrzykladow);
        for s = 1:liczbaPrzykladow
            [~, Y2_all(s)] = dzialaj2(W1_new, W2_new, P(:, s));
        end
        E_curr = sum((T - Y2_all).^2) / liczbaPrzykladow;

        if E_curr > k_w * E_old
            eta = rho_d * eta;
            dw1_old = zeros(size(W1)); dw2_old = zeros(size(W2));
        else
            if E_curr < E_old; eta = rho_i * eta; endif
            W1 = W1_new; W2 = W2_new;
            dw1_old = dW1; dw2_old = dW2;
            E_old = E_curr;
        endif

        % Zapisujemy stan dokładny po KAŻDEJ epoce do historii
        hist_w2_ciag(i) = E_old;
        hist_ce(i) = (sum(abs(T - Y2_all) > 0.3) / liczbaPrzykladow) * 100;
        [~, Y2_last] = dzialaj2(W1, W2, P(:, end));
        hist_w1(i) = sum((T(:, end) - Y2_last).^2) * 0.1;

        % Warunek stopu 'e' wbudowany w uczenie
        if E_old <= 0.01
            hist_w2_ciag = hist_w2_ciag(1:i);
            hist_ce = hist_ce(1:i);
            hist_w1 = hist_w1(1:i);
            break;
        endif
    endfor
    W1po = W1; W2po = W2;
endfunction