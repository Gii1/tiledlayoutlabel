
% create figure with a tiled layout
fig = figure;
tiledlayout(2, 2);

% add three plots
nexttile;
plot(0, 0);

nexttile;
plot(0, 0);
title("test")

nexttile([1, 2]);
plot(0, 0)

% add label AFTER adding the plots
tiledlayoutlabel;