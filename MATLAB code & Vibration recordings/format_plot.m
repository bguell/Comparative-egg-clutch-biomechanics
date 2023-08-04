function [] = format_plot(hp)

font_size = 14;

font_name = 'helvetica';

line_width = 1.5;

set(gcf,'color','w');

set(hp, 'linewidth', line_width);

set(gca, 'fontsize', font_size);

set(gca, 'fontname', font_name);

set(gca, 'linewidth', line_width);

set(get(gca, 'XLabel'), 'FontSize', font_size, 'FontName', font_name);

set(get(gca, 'YLabel'), 'FontSize', font_size, 'FontName', font_name);

set(get(gca, 'ZLabel'), 'FontSize', font_size, 'FontName', font_name);

set(get(gca, 'title'),  'FontSize', font_size, 'FontName', font_name);

set(legend, 'Fontsize', font_size, 'FontName',...
    font_name, 'linewidth', line_width);

set(gca, 'GridLineStyle', '-');
