clear all
close all

g = textread('brandon.txt','%f');

f_s = 44100;
delta_t = 1/f_s;

t(:,1) = delta_t*(0:(length(g)-1));

% initial guesses

T_0 = 0.06;
f_0 = 1/T_0;
omega_0 = 2*pi*f_0;
tau_0 = 0.14;

% fit model

figure
[omega_fit, tau_fit, nmse, h] = decaying_sinusoid_search(t, g, omega_0, tau_0);

f_fit = omega_fit/(2*pi);

% plot results

figure
hp = plot(t, g, t, h);
xlabel('Time (sec)')
ylabel('Voltage (V)')
legend('Actual', 'Fit')
format_plot(hp)

fprintf(['\nFit f  = ' num2str(f_fit) ' Hz'])

fprintf(['\nFit tau  = ' num2str(tau_fit) ' s'])

fprintf(['\n\n'])