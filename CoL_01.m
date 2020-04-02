%% Problem 1
clear

T_i = 298.15;
T = 1120.15;
T_m = 1356.15;
T_f = 1500;

c_s = 22.63544;
c_l = 31.38;

H_m = 12970.4;

S_s = @(T) c_s * log(T / T_i);
S_l = @(T) c_s * log(T_m / T_i) + H_m / T_m + c_l * log(T / T_m);

figure
plot([T T], [c_s * log(T / T_i) c_s * log(T_m / T_i) + H_m / T_m + c_l ...
     * log(T / T_m)])
hold on
plot([T_m T_m], [c_s * log(T_m / T_i) c_s * log(T_m / T_i) + H_m / T_m ...
     + c_l * log(T_m / T_m)])
fplot(S_s,[T_i T_m])
fplot(S_l,[T T_f])
title('Part 1D','Interpreter','latex')
xlabel('$T (K)$','Interpreter','latex')
ylabel('$\Delta S (J/mol \cdot K)$','Interpreter','latex')
legend('$\Delta S^{\circ,*}$','$\Delta S^{\circ}_m$','Interpreter', ...
       'latex','Location','northwest')


%% Problem 2
clear

T_1 = 298;
T_i = 300;
T_f = 1000;
T_2 = 1273;

P_i = 1;
P_f = 1000;

H_T = @(T) 11.17 * (T - T_i) + 37.78 * 10^(-3) / 2 * (T^2 - T_i^2);
H_P = @(P) 101.325 * 0.0066 * (1 - 40 * 10^(-6)) * (P - P_i);

figure
tiledlayout(2,1)

ax1 = nexttile;
fplot(H_T, [T_1 T_2])
title(ax1, 'Part 2B ($P \equiv cst.)$','Interpreter','latex')
xlabel(ax1, '$T (K)$','Interpreter','latex')
ylabel(ax1, '$\Delta H (J/mol)$','Interpreter','latex')

ax2 = nexttile;
fplot(H_P, [P_i P_f])
title(ax2, 'Part 2B ($T \equiv cst.$)','Interpreter','latex')
xlabel(ax2, '$P (atm)$','Interpreter','latex')
ylabel(ax2, '$\Delta H (J/mol)$','Interpreter','latex')


%% Problem 5
clear

R = 8.314;

T_i = 298;
T_m = 693;
T_v = 1181;
T_f = 1400;
T_2 = 1773;

P_i = 1;
P_f = 30;
P_2 = 35;

S_1 = -30;
S_2 = 153;

H_m = 7388;
H_v = 115366;

x_1 = [linspace(P_i,P_2);linspace(P_i,P_2)];
x_2 = [linspace(P_i,P_2);linspace(P_i,P_2)];

y_1 = T_m * ones(2,100);
y_2 = T_v * ones(2,100);

syms f(T,P)
S_s(T,P) = 22.4 * log(T / T_i) + 0.001 * (T - T_i) - R * log(P);

S_m(1,:) = 22.4 * log(T_m / T_i) + 0.001 * (T_m - T_i) - R * log(x_1(1,:));
S_m(2,:) = 22.4 * log(T_m / T_i) + 0.001 * (T_m - T_i) + H_m / T_m ...
         + 31.4 * log(T_m/T_m) - R * log(x_1(2,:));

S_l(T,P) = 22.4 * log(T_m / T_i) + 0.001 * (T_m - T_i) + H_m / T_m ...
         + 31.4 * log(T / T_m) - R * log(P);

S_v(1,:) = 22.4 * log(T_m / T_i) + 0.001 * (T_m - T_i) + H_m / T_m ...
         + 31.4 * log(T_v / T_m) - R * log(x_2(1,:));
S_v(2,:) = 22.4 * log(T_m / T_i) + 0.001 * (T_m - T_i) + H_m / T_m ...
         + 31.4 * log(T_v / T_m) + H_v / T_v + 20.7 * log(T_v / T_v) ...
         - R * log(x_2(2,:));

S_g(T,P) = 22.4 * log(T_m / T_i) + 0.001 * (T_m - T_i) + H_m / T_m ...
         + 31.4 * log(T_v / T_m) + H_v / T_v + 20.7 * log(T / T_v) ...
         - R * log(P);

figure
ezsurf(S_s,[P_i,P_2,T_i,T_m])
hold on
surf(x_1,y_1,S_m)
ezsurf(S_l,[P_i,P_2,T_m,T_v])
surf(x_2,y_2,S_v)
ezsurf(S_g,[P_i,P_2,T_v,T_2])
xlim([P_i P_2])
ylim([T_i T_2])
zlim([S_1 S_2])
title('Part 5C','Interpreter','latex')
xlabel('$P (atm)$','Interpreter','latex')
ylabel('$T (K)$','Interpreter','latex')
zlabel('$\Delta S^{\circ} (J / mol \cdot K)$','Interpreter','latex')


%% Problem 7
clear

T_i = 298;
T_flame = 2331.53;
T_2 = 2500;

H_298 = 890500;
H_min = -800000;
H_max = 800000;

x = [0.75 0.84];
y = [0.57 0.52];
str = {'$\left[T_{flame}\right]$'};

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
scatter(T_CH4,c_CH4,'filled')
hold on
fplot(C_CH4,[50 3000])
title(ax1,'Problem 7: $C_p$ for $CH_4$','Interpreter','latex')
xlabel(ax1,'$T (K)$','Interpreter','latex')
ylabel(ax1,'$C_p (J/mol \cdot K)$','Interpreter','latex')
legend(ax1,'Experimental Data','Curve Fit','Location','northwest')

ax2 = nexttile;
scatter(T_O2,c_O2,'filled')
hold on
fplot(C_O2,[0 3000])
title(ax2,'Problem 7: $C_p$ for $O_2$','Interpreter','latex')
xlabel(ax2,'$T (K)$','Interpreter','latex')
ylabel(ax2,'$C_p (J/mol \cdot K)$','Interpreter','latex')
legend(ax2,'Experimental Data','Curve Fit','Location','northwest')

CH4 = polyint(p_CH4);
O2 = polyint(p_O2);
CO2 = [4.4 * 10^(-3) 44.25 -16476 8.62 * 10^5];
H2O = [5.36 * 10^(-3) 30.01 34660 3.3 * 10^4];
N2 = [2.13 * 10^(-3) 27.88 -8502];

H_R = @(T) (CH4(1) * (T.^3 - T_i^3) + CH4(2) * (T.^2 - T_i^2) + CH4(3) ...
    * (T - T_i)) + 2 * (O2(1) * (T.^3 - T_i^3) + O2(2) * (T.^2 - T_i^2) ...
    + O2(3) * (T - T_i)) + 7.52 * (N2(1) * T.^2 + N2(2) * T + N2(3));
   
H_P = @(T) (CO2(1) * T.^2 + CO2(2) * T + CO2(3) + CO2(4) ./ T) + 2 ...
    * (H2O(1) * T.^2 + H2O(2) * T + H2O(3) + H2O(4) ./ T) + 7.52 ...
    * (N2(1) * T.^2 + N2(2) * T + N2(3)) - H_298;

H_Rx = @(T) 0;
   
figure
fplot(H_R,[T_i T_2])
hold on
fplot(H_P,[T_i T_2])
fplot(H_Rx,[T_i T_flame])
annotation('textarrow',x,y,'String',str,'Interpreter','latex')
xlim([T_i T_2])
ylim([H_min H_max])
title('Problem 7: Adiabatic Flame Temperature','Interpreter','latex')
xlabel('$T (K)$','Interpreter','latex')
ylabel('$\Delta H^{\circ} (J/K)$','Interpreter','latex')
legend('$\Delta H^{\circ}_{React}$','$\Delta H^{\circ}_{Prod}$', ...
       '$\oint H^{\circ}_{Rx} = 0$','Interpreter','latex','Location', ...
       'northwest')