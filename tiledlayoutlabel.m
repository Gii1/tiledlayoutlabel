function tiledlayoutlabel(varargin)
    % TILEDLAYOUTLABEL Label each subplot for a figure with a
    % tiledlayout
    %   TILEDLAYOUTLABEL labels each subplot of the current figure using
    %   letters in alphabetical order.
    %   TILEDLAYOUTLABEL(labelset) specifies the set to use for labeling. 
    %   TILEDLAYOUTLABEL("custom", customset) specifies a custom set.
    %   TILEDLAYOUTLABEL(obj, __) labels the target figure.


    % parse input
    [layout, label] = parseinput(varargin);

    % get all components from the layout
    ax = flip(layout.Children);

    % iterate over all axes
    for i = 1:length(ax)
        % get axis size converted in charactersize
        axunit = get(ax(i), "Units");
        set(ax(i), Units="characters");
        axsize = get(ax(i), "Position");
        set(ax(i), Units=axunit);

        text(ax(i), 0, axsize(4) + .5, label(i), Units="characters", HorizontalAlignment="left", VerticalAlignment="bottom");
    end
end

function [layout, labels] = parseinput(input)
    % get figure either from input or gcf
    if ~isempty(input) && isgraphics(input{1}, "figure")
        fig = figure(input{1}); 
        input{1} = [];
    else
        fig = gcf;
    end

    % get layout object from figure
    if ~isgraphics(fig.Children, "tiledlayout")
        error("The figure has no tiledlayout component");
    end

    layout = fig.Children;

    % default labelset
    labelsets = dictionary;
    labelsets("number") = {@(i) sprintf("%i)", i)};

    if ~isempty(input)
        setname = string(input{1});
        input{1} = [];
    else
        setname = "number";
    end

    if labelsets.isKey(setname)
        labels = labelsets{setname};
    end
end