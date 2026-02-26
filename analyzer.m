% analyzer.m
% MATLAB equivalent of the Python analyzer: reads config.ini and prints settings.
% Also ensures the output folder exists and writes a simple line to the output file.

function analyzer()
    % Read config
    cfg = readIni('config.ini');

    % Extract values (strings in INI → convert to numeric where needed)
    freqMHz = str2double(cfg.TestParameters.frequency);
    powerDbm = str2double(cfg.TestParameters.power);

    % Print the run message (same as Python)
    fprintf('Running test at %.0f MHz with %.0f dBm power...\n', freqMHz, powerDbm);

end