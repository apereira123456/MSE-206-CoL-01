%% Question 5
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
title('Question 5C','Interpreter','latex')
xlabel('$P (atm)$','Interpreter','latex')
ylabel('$T (K)$','Interpreter','latex')
zlabel('$\Delta S (J / mol \cdot K)$','Interpreter','latex')