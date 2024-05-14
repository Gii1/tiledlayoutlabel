function tiledlayoutlabel(varargin)
    % TILEDLAYOUTLABEL Label each subplot for a figure with a
    % tiledlayout
    %   TILEDLAYOUTLABEL labels each subplot of the current figure using
    %   letters in alphabetical order. The tiledlayout have to be a direct
    %   child of the figure.
    %   TILEDLAYOUTLABEL(labelset) specifies the set to use for labeling.
    %   The following sets are avaible: "letter", "number"
    %   TILEDLAYOUTLABEL("custom", customset) specifies a custom set.
    %   customset should be either a string array or a function handle
    %   which takes an integer as an input and returns a string label as an
    %   output.
    %   TILEDLAYOUTLABEL(tiledlayout, __) labels the axes in the target layout.


    % parse input
    [layout, label] = parseinput(varargin);

    % get all components from the layout
    ax = flip(findobj(layout, "-depth", 1, "type", "axes", "-or", "type", "polaraxes", "-or", "type", "geographicaxes"));

    % iterate over all axes
    for i = 1:length(ax)
        % set label text
        text(ax(i), 0, 1.02, label(i), Units="normalized", HorizontalAlignment="left", VerticalAlignment="bottom");
    end
end

function [layout, labels] = parseinput(input)
    
    if ~isempty(input) && isgraphics(input{1}, "tiledlayout")
        % get layout from input
        layout = input{1}; 
        input(1) = [];
    else
        % get layout from current figure
        layout = findobj(gcf, "-depth", 1, "type", "tiledlayout");
        
        if isempty(layout)
            error("The current figure has no tiledlayout object");
        end
    end
    
    % default labelset
    labelsets = dictionary;
    labelsets("letter") = {string(('a':'z')')'+ ")"};
    labelsets("number") = {@(i) sprintf("%i)", i)};

    % get name of labelset from input
    if ~isempty(input)
        setname = string(input{1});
        input(1) = [];
    else
        setname = "letter";
    end

    if labelsets.isKey(setname)
        % get labels from default set
        labels = labelsets{setname};
    elseif strcmp(setname, "custom")
        % get labels from custom set

        % check if custom set is specified
        if isempty(input)
            error("Not enough input arguments.");
        end

        if isstringequivalent(input{1})
            % label is string array
            labels = string(input{1});
        elseif isa(input{1}, "function_handle")
            % label is function handle
            labels = input{1};
        else
            error("Custom label set should be either a string array or a function handle");
        end
    end
end

% check if var is a string or char array
function bool = isstringequivalent(var)
    bool = isstring(var) || ischar(var) || iscellstr(var);
end