clear
close all

% initial period

T_0 = 0.05;

% initial time constant

tau_0 = 0.05;

% load list of aif files

%files = dir('*.aif');

files = dir('*.txt');

Fs = 44100;

% open figure for loop

figure

% loop over all files

for n = 1:length(files)
    
    % read aif file
    
%     eval(['[y,Fs] = audioread(''' files(n).name ''');']);
%     
%     eval(['file_name = files(n).name;']);

    eval(['y = load(''' files(n).name ''');']);
    
    eval(['file_name = files(n).name;']);

    
    % y must be a column vector
    
    if(size(y,2) ~= 1)
        
        y = y.';
        
    end
    
    % time vector
    
    delta_t = 1/Fs;
    
    t = delta_t*(0:(length(y)-1));
    
    if(size(t,2) ~= 1)
        
        t = t.';
        
    end

    % moving average
    
    y = movmean(y,100);
    
    [~,ix_max] = max(y);
    [~,ix_min] = min(y);
    
    % initial estimate of frequency
    
    T_0 = 2*abs((t(ix_max) - t(ix_min)));
    
    omega_0 = 2*pi/T_0;
    
    % search
    
    [omega_fit, tau_fit, nrmse(n), y_fit] =...
        decaying_sinusoid_search(t, y, omega_0, tau_0, file_name);
    
    if(nrmse(n) > 0.3)
        
        hp = plot(t, y, t, y_fit, t(ix_max), y(ix_max), 'o', t(ix_min), y(ix_min), 'o');
        xlabel('Time (sec)')
        ylabel('Response')
        title([file_name], 'Interpreter', 'none')
        legend('Actual', 'Fit')
        format_plot(hp)        
        drawnow
        pause(0.5)
        
        if(n == 1)
            
            print -dpsc decaying_sinusoid_analysis.ps
            155
        else
            
            print -append -dpsc decaying_sinusoid_analysis.ps
            
        end
        
    end
    
end

hp = plot(nrmse, 'o');
format_plot(hp);
