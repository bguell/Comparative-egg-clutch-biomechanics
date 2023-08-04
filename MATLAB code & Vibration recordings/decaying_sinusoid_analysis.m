clear
close all

% initial period

T_0 = 0.05;

% initial time constant

tau_0 = 0.1;

% frequency

f_0 = 1/T_0;

omega_0 = 2*pi*f_0;

% load list of aif files

files = dir('*.txt');

% store filenames to save later

files_cell = struct2cell(files);

save_cell(:,1) = files_cell(1,:)';

% sampling frequency

Fs = 44100;

% open figure for loop

figure

% loop over all files

for n = 1:length(files)

    % read txt file

    eval(['y = load(''' files(n).name ''');']);

    eval(['file_name = files(n).name;']);

    % y must be a column vector

    if(size(y,2) ~= 1)

        y = y.';

    end

    % time vector

    delta = 1/Fs;

    t = delta*(0:(length(y)-1));

    if(size(t,2) ~= 1)

        t = t.';

    end

    [~,ix_max] = max(y);
    [~,ix_min] = min(y);

    % initial estimate of frequency

    T_0 = 2*abs((t(ix_max) - t(ix_min)));

    omega_0 = 2*pi/T_0;

    [omega_fit(n), tau_fit(n), nrmse(n), y_fit] =...
        decaying_sinusoid_search(t, y, omega_0, tau_0, file_name);



    hp = plot(t, y, t, y_fit);
    xlabel('Time (sec)')
    ylabel('Response')
    title([file_name], 'Interpreter', 'none')
    legend('Actual', 'Fit')
    format_plot(hp)

    if(n == 1)

        print -dpsc decaying_sinusoid_analysis.eps

    else

        print -append -dpsc decaying_sinusoid_analysis.eps

    end

    pause(1)

    f_fit(n) = omega_fit(n)/(2*pi);

    T_fit(n) = 1/f_fit(n);

    % save results

    save_cell(n,2) = num2cell(length(y));
    save_cell(n,3) = num2cell(delta*length(y));
    save_cell(n,4) = num2cell(f_fit(n));
    save_cell(n,5) = num2cell(T_fit(n));
    save_cell(n,6) = num2cell(tau_fit(n));
    save_cell(n,7) = num2cell(nrmse(n));


end

hp = plot(nrmse, 'o');
legend off
format_plot(hp)
xlabel('Experiment Number')
ylabel('NMSE')
print -depsc decaying_sinusoid_NMSE.eps

% create headings for xls file

headings{1,1} = 'File Name';
headings{1,2} = 'Number of Data Points';
headings{1,3} = 'Time Between Samples (s)';
headings{1,4} = 'Frequency (Hz)';
headings{1,5} = 'Period (s)';
headings{1,6} = 'Time Constant (s)';
headings{1,7} = 'NRMSE';

save_cell(1,:) = headings;
writecell(save_cell, 'xls_test.xls');

