clear;
close all; %σβήνει ό,τι υπήρχε πριν

u = symunit;

EcJ = double(separateUnits(unitConvert(2.2 * u.eV, u.J)))
EvJ = double(separateUnits(unitConvert(1 * u.eV, u.J)))

i = 918 % περίπου 3 φορές μεγαλύτερο από το παράδειγμα
m0 = 9.11 * 10^(-31)
me = 1.09 * i / 1000 * m0
mh = 1.15 * i / 1000 * m0
h = 1.055 * 10^(-34)

C = 1 / (2 * pi^2) * (2 / h^2)^(3 / 2);
Ce = C * me^(3 / 2); % συνεπώς όλα τα αποτελέσματα θα είναι περίπου
Ch = C * mh^(3 / 2); % % 5 φορές μεγαλύτερα λόγω του εκθέτη

EeVC = linspace(2.2, 3, 500);
EeVH = linspace(0, 1, 500);
EJC = double(separateUnits(unitConvert(EeVC .* u.eV, u.J)));
EJH = double(separateUnits(unitConvert(EeVH .* u.eV, u.J)));

Ne = calculateStates(EJC, true, Ce, EcJ, Ch, EvJ, u);
Nh = calculateStates(EJH, false, Ce, EcJ, Ch, EvJ, u);

figure(1)
set(1, "Color", "w")

plot(Ne, EeVC, "r")

grid on
hold on

plot(Nh, EeVH, "b")
ax = gca;

set(ax, ...
    "Color", "w", ...
    "XColor", "k", ...
    "YColor", "k", ...
    "YTick", [1, 2.2], ...
    "YTickLabel", {"Ev", "Ec"}, ...
    "XTick", 0:1e21:9e21, ... % το βήμα από 2e20 πενταπλασιάζεται 
    "XLim", [0, 9e21]) % και γίνεται 1e21 για να μοιάζουν οι γραφικές

%Για τις διακεκομένες
yline(2.2, "LineStyle", "--", "Color", "k")
yline(1.0, "LineStyle", "--", "Color", "k")

lgd = legend("electrons", "holes");
lgd.Color = "w";
lgd.TextColor = "k";

ttl = title("Density Of States vs Energy");
ttl.Color = "k";
ttl.FontWeight = "bold";

ylabel("E (eV)", "FontWeight", "bold")
xlabel("N (E) (cm^{-3} * eV^{-1})", "FontWeight", "bold")

hold off

function N = calculateStates(E, p, Ce, EcJ, Ch, EvJ, u) % takes Joules and converts to eV^(-1)*cm^(-3)
if p
    N = double(separateUnits(unitConvert(Ce .* sqrt(E - EcJ) .* (10^(-6) * u.J^(-1)) , u.eV^(-1))));

    return;
end

N = double(separateUnits(unitConvert(Ch .* sqrt(EvJ - E) .* (u.J^(-1) * 10^(-6)), u.eV^(-1))));
end