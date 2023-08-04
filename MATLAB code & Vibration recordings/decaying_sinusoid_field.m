function [h] = decaying_sinusoid_field(t, g, omega, tau)

% model matrix

A = [exp(-t/tau).*cos(omega*t) exp(-t/tau).*sin(omega*t) ones(size(t)) t t.^2 ];

% model coefficients

C = A\g;

% model

h = A*C;

end