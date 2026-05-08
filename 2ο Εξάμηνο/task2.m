clear
clc
close all

kb = 8.62e-5

format long % για να φαίνονται οι αριθμοί καλύτερα

m = [3.2841e15, 1.12; % οι γραμμές αντιπροσωπεύουν τις τιμές των
     1.52e15, 0.66; % Si, Ge, GaAs αντίστοιχα, ενώ οι στήλες στα
     3.49e14, 1.4] % Α και Eg αντίστοιχα.
     
T = linspace(10, 1600, 1000);
n = calculateSeries(T, m(:, 1), m(:, 2), kb);

semilogy(T, n)

grid on

set(gcf, "Color", "w")
set(gca, "Color", "w", ...
    "YLim", [1, 1e20], ...
    "XColor", "k", ...
    "YColor", "k", ...
    "XTick", 0:200:1600, ...
    "MinorGridAlpha", 0.1) % για να μοιάζει περισσότερο με το παράδειγμα

legend("Si", "Ge", "GaAs", ...
    "Color", "w", ...
    "TextColor", "k", ...
    "EdgeColor", "k", ...
    "Location", "east", ...
    "IconColumnWidth", 10) % για τον ίδιο λόγο

title("Intrinsic Density vs Temperature", ...
    "FontWeight", "bold", ...
    "Color", "k")

ylabel("n_{i} (cm^{-3})")
xlabel("Temperature (K)")

function n = calculateSeries(T, A, Eg, kb)
    n = (A .* exp(-Eg ./ (2 * kb * T))) .* T .^ (3 / 2);
end
