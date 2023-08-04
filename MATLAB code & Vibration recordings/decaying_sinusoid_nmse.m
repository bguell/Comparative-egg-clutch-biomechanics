function [nmse] = decaying_sinusoid_nmse(x, t, g, title_text)

% extract model parameters from parameter vector

omega = x(1);
tau = x(2);

% best model fit to data for amplitude

[h] = decaying_sinusoid_field(t, g, omega, tau);

% normalized mean square error (nmse)

nmse = sqrt(mean((abs(g) - abs(h)).^2))/sqrt(mean(abs(g).^2));

% hp = plot(t, g, t, h);
% xlabel('Time (sec)')
% ylabel('Response')
% title(title_text, 'Interpreter', 'none')
% legend('Actual', 'Fit')
% format_plot(hp)
% pause(0.01)

end

