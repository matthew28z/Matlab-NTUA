clear
clc
close all

L = 0.8918 % πολύ κοντά στο παράδειγμα άρα δε χρειάζεται μετατροπή

N = logspace(14, 20, 500);

semilogx(N, calculatePoints(N, M, L))

set(gcf, "Color", "w")
set(gca, "Color", "w", ...
    "YColor", "k", ...
    "XColor", "k", ...
    "MinorGridAlpha", 0.05)

xlabel("Doping Concentration N_{D} or N_{A} (cm^{-3})")
ylabel("Mobility (cm^{2}/V.s)")

title("Mobility versus Doping", ...
      "FontWeight", "bold", ...
      "Color", "k")

legend("Electron Mobility", "Hole Mobility", ...
       "Color", "w", "TextColor", "k", ...
       "EdgeColor", "k", ...
       "IconColumnWidth", 10) % για να μοιάζει με το παράδειγμα

grid on

function output = calculatePoints(N, constants, L)
    output = (constants(:, 1) .* 10.^(constants(:, 2) + 3) * L + constants(:, 3) .* N.^constants(:, 4)) ./ ...
             (constants(:, 5) .* 10.^(constants(:, 2)) + N .^ constants(:, 4));
end
