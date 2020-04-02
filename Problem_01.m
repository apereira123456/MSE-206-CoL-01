%% Question 1
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
plot([T T], [c_s * log(T / T_i) c_s * log(T_m / T_i) + H_m / T_m + c_l * log(T / T_m)])
hold on
plot([T_m T_m], [c_s * log(T_m / T_i) c_s * log(T_m / T_i) + H_m / T_m + c_l * log(T_m / T_m)])
fplot(S_s,[T_i T_m])
fplot(S_l,[T T_f])
title('Question 1D','Interpreter','latex')
xlabel('$T (K)$','Interpreter','latex')
ylabel('$\Delta S (J/mol \cdot K)$','Interpreter','latex')
legend('$\Delta S^{\circ,*}$','$\Delta S^{\circ}_m$','Interpreter','latex','Location','northwest')