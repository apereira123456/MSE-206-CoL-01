%% Question 7
clear

T_i = 298;

c_CH4 = [33.28 33.51 35.69 35.76 40.63 46.63 52.74 58.60 64.08 69.14 ...
        73.75 77.92 81.68 85.07 88.11 90.86 93.33 95.58 97.63 99.51 ...
        101.24 102.83 104.31 105.70 107.00 108.23 109.39 110.50 111.56 ...
        112.57 113.55];
c_O2 = [29.10 29.11 29.39 30.10 31.08 32.11 32.98 33.74 34.36 34.86 ...
        35.29 35.66 35.99 36.28 36.55 36.80 37.04 37.27 37.51 37.75 ...
        37.97 38.19 38.41 38.63 38.85 39.07 39.28 39.48 39.68 39.87];
    
T_CH4 = [100 200 298.15 300 400 500 600 700 800 900 1000 1100 1200 1300 ...
        1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 ...
        2600 2700 2800 2900 3000];
T_O2 = [100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 ...
        1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 ...
        2700 2800 2900 3000];
    
p_CH4 = polyfit(T_CH4,c_CH4,2);
p_O2 = polyfit(T_O2,c_O2,2);

C_CH4 = @(T) polyval(p_CH4,T);
C_O2 = @(T) polyval(p_O2,T);

figure
tiledlayout(2,1)

ax1 = nexttile;
plot(T_CH4,c_CH4)
hold on
fplot(C_CH4,[50 3000])
title(ax1,'Question 7: $C_p$ for $CH_4$','Interpreter','latex')
xlabel(ax1,'$T (K)$','Interpreter','latex')
ylabel(ax1,'$C_p (J/mol \cdot K)$','Interpreter','latex')
legend(ax1,'Experimental Data','Curve Fit','Location','northwest')

ax2 = nexttile;
plot(T_O2,c_O2)
hold on
fplot(C_O2,[0 3000])
title(ax2,'Question 7: $C_p$ for $O_2$','Interpreter','latex')
xlabel(ax2,'$T (K)$','Interpreter','latex')
ylabel(ax2,'$C_p (J/mol \cdot K)$','Interpreter','latex')
legend(ax2,'Experimental Data','Curve Fit','Location','northwest')

CH4 = polyint(p_CH4);
O2 = polyint(p_O2);
CO2 = [4.4 * 10^(-3) 44.25 -16476 8.62 * 10^5];
H2O = [5.36 * 10^(-3) 30.01 34660 3.3 * 10^4];
N2 = [2.13 * 10^(-3) 27.88 -8502];

H_R = @(T) (CH4(1) * (T.^3 - T_i^3) + CH4(2) * (T.^2 - T_i^2) + CH4(3) * (T - T_i)) ...
    + 2 * (O2(1) * (T.^3 - T_i^3) + O2(2) * (T.^2 - T_i^2) + O2(3) * (T - T_i)) ...
    + 7.52 * (N2(1) * T.^2 + N2(2) * T + N2(3));
   
H_P = @(T) (CO2(1) * T.^2 + CO2(2) * T + CO2(3) + CO2(4) ./ T) + 2 * (H2O(1) * T.^2 ...
    + H2O(2) * T + H2O(3) + H2O(4) ./ T) + 7.52 * (N2(1) * T.^2 + N2(2) * T + N2(3)) - 890500;
   
figure
fplot(H_R,[298 2500])
hold on
fplot(H_P,[298 2500])
plot([298 2331],[0,0])
xlim([298 2500])
ylim([-800000 800000])
title('Question 7: Adiabatic Flame Temperature','Interpreter','latex')
xlabel('$T (K)$','Interpreter','latex')
ylabel('$\Delta H (J/K)$','Interpreter','latex')
legend('$\Delta H^{\circ}_{React}$','$\Delta H^{\circ}_{Prod}$', ...
       '$\oint H^{\circ}_{Rx}$','Interpreter','latex','Location','northwest')