function [omega, tau, nrmse, y_fit] = decaying_sinusoid_search(t, y, omega_0, tau_0, file_name)

% search options

options = [];
options = optimset(options, 'TolFun', 1E-4);
options = optimset(options, 'TolX',   1E-4);

% initial guesses

x_0(1) = omega_0;
x_0(2) = tau_0;
x_0(3) = 0;
x_0(4) = 0;
x_0(5) = 0;

[x, fval, exitflag] =...
    fminsearch(@(x) decaying_sinusoid_nmse(x, t, y, file_name), x_0, options);

omega = x(1);
tau = x(2);

[y_fit] = decaying_sinusoid_field(t, y, omega, tau);

nrmse = sqrt(mean((abs(y) - abs(y_fit)).^2))/sqrt(mean(abs(y).^2));
