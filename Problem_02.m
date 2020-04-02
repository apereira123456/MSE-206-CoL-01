%% Question 2
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
title(ax1, 'Question 2B ($P \equiv cst.)$','Interpreter','latex')
xlabel(ax1, '$T (K)$','Interpreter','latex')
ylabel(ax1, '$\Delta H (J/mol)$','Interpreter','latex')

ax2 = nexttile;
fplot(H_P, [P_i P_f])
title(ax2, 'Question 2B ($T \equiv cst.$)','Interpreter','latex')
xlabel(ax2, '$P (atm)$','Interpreter','latex')
ylabel(ax2, '$\Delta H (J/mol)$','Interpreter','latex')