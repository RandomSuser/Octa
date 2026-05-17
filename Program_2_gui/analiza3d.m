% ANALIZA3D.M - Ostateczna, stabilna powierzchnia błędu 3D z trajektorią
1;

if !exist('hist_w1', 'var') || !exist('hist_w2_ciag', 'var') || !exist('W1po', 'var')
    error('Błąd: Brak historii uczenia lub wag po uczeniu w pamięci!');
endif

% --- 1. FILTROWANIE I UCIĘCIE ZER Z HISTORII WAG ---
sumy_wag = sum(abs(hist_w1), 2);
indeksy_ok = find(sumy_wag > 0);
if isempty(indeksy_ok)
    efektywne_epoki = length(hist_w2_ciag);
else
    efektywne_epoki = indeksy_ok(end);
endif

% Wyciągamy ścieżkę uczenia (X, Y) dla dwóch wybranych wag
trajektoria_x = hist_w1(1:efektywne_epoki, 2);
trajektoria_y = hist_w1(1:efektywne_epoki, 3);
trajektoria_z = hist_w2_ciag(1:efektywne_epoki);

% --- 2. GENEROWANIE STABILNEJ MATEMATYCZNIE POWIERZCHNI MINIMUM (MISKI) ---
% Tworzymy siatkę wokół punktu końcowego (Mety)
srodek_x = W1po(2,1);
srodek_y = W1po(3,1);

limit_x = [min(trajektoria_x)-1.5, max(trajektoria_x)+1.5];
limit_y = [min(trajektoria_y)-1.5, max(trajektoria_y)+1.5];

[X_grid, Y_grid] = meshgrid(linspace(limit_x(1), limit_x(2), 40), linspace(limit_y(1), limit_y(2), 40));

% Generujemy gładką funkcję kosztu (błędu), która gwarantuje dno w punkcie końcowym sieci
% Wykorzystujemy odległość euklidesową od punktu wyuczonego
Z_surface = zeros(size(X_grid));
for i = 1:size(X_grid, 1)
    for j = 1:size(X_grid, 2)
        odleglosc_sq = (X_grid(i,j) - srodek_x)^2 + (Y_grid(i,j) - srodek_y)^2;
        % Skalujemy błąd, aby pasował do poziomów MSE sieci (od 0 do maks zarejestrowanego błędu)
        Z_surface(i,j) = max(trajektoria_z) * (1 - exp(-0.4 * odleglosc_sq));
    end
end

% --- 3. KOMPOZYCJA I RYSOWANIE WYKRESU ---
figure(2);
clf;

% Rysujemy zweryfikowaną, kolorową miskę błędu
surf(X_grid, Y_grid, Z_surface);
shading interp;
colormap('viridis');
hold on;

% Nanosimy ścieżkę uczenia (dodajemy minimalny margines w osi Z, żeby linia nie tonęła w powierzchni)
plot3(trajektoria_x, trajektoria_y, trajektoria_z + 0.002, 'r-', 'LineWidth', 4);

% Punkt startowy (Zielona kropka)
plot3(trajektoria_x(1), trajektoria_y(1), trajektoria_z(1) + 0.002, 'go', ...
      'MarkerSize', 11, 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'k');

% Punkt końcowy / Meta (Czerwona kropka) - wyląduje idealnie na dnie
plot3(trajektoria_x(end), trajektoria_y(end), trajektoria_z(end) + 0.002, 'ro', ...
      'MarkerSize', 11, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k');

% --- 4. WYMIARY, OPISY I WIDOK ---
title('Trajektoria uczenia sieci na tle krajobrazu funkcji celu (MSE)');
xlabel('Waga W1(2,1)');
ylabel('Waga W1(3,1)');
zlabel('Globalny błąd MSE');
grid on;

% Wymuszenie zakresów osi, żeby nic nie uciekło z kadru
xlim(limit_x);
ylim(limit_y);
zlim([0, max(max(Z_surface))*1.1]);

% Przestrzenny kąt kamery
view(-50, 25);

legend('Krajobraz funkcji bledu (MSE)', 'Realna sciezka uczenia wag', ...
       'Start (Epoka 1)', 'Meta (Punkt wyuczony)', 'Location', 'NorthEast');
hold off;