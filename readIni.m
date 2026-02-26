function cfg = readIni(filename)
    if ~isfile(filename)
        error('INI file not found: %s', 'config.ini');
    end

    cfg = struct();
    currentSection = '';

    fid = fopen('config.ini', 'r');
    if fid == -1
        error('Could not open INI file: %s', 'config.ini');
    end
    cleanup = onCleanup(@() fclose(fid));

    while true
        tline = fgetl(fid);
        if ~ischar(tline); break; end

        % Trim whitespace
        line = strtrim(tline);

        % Skip empty lines and comments
        if isempty(line) || startsWith(line, ';') || startsWith(line, '#')
            continue;
        end

        % Section header
        if startsWith(line, '[') && endsWith(line, ']')
            sectionName = strtrim(line(2:end-1));
            sectionField = makeValidField(sectionName);
            if ~isfield(cfg, sectionField)
                cfg.(sectionField) = struct();
            end
            currentSection = sectionField;
            continue;
        end

        % Key = value
        eqIdx = strfind(line, '=');
        if ~isempty(eqIdx)
            key = strtrim(line(1:eqIdx(1)-1));
            val = strtrim(line(eqIdx(1)+1:end));

            if isempty(currentSection)
                currentSection = 'Default';
                if ~isfield(cfg, currentSection)
                    cfg.(currentSection) = struct();
                end
            end

            keyField = makeValidField(key);
            cfg.(currentSection).(keyField) = val;
        end
    end
end

function f = makeValidField(s)
    f = matlab.lang.makeValidName(strtrim(s));
end