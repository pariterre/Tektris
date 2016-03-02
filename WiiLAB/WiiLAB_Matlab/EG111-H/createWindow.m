function f = createWindow(w, h, xmax, ymax)
%	usage: 	w = createWindow (wid, ht, xmax, ymax)
%	purpose:	Generates a window whose width is wid pixels and height is ht pixels. 
%                This function also specifies the relationship between coordinates used in
%                drawing functions and screen coordinates in pixels.  The origin of 
%                drawing coordinates corresponds to the lower-left corner of the window.
%                The lower-right corner has drawing coordinates (xmax,0). The upper-
%                left corner has drawing coordinates (0,ymax) and the upper-right
%                corner has coordinates (xmax,ymax).  This function returns a handle
%                to the window.
f = figure;
set(gcf, 'KeyPressFcn', '[left_right_counter, up_down_counter] = getArrowKeyCounts(left_right_counter, up_down_counter);');
left = 50;
bottom = 50;
pos = [left bottom w h];
set (f, 'Pointer', 'arrow')
set (f, 'MenuBar', 'none')
set (f, 'Name', 'EG 10111 - Project 2')
set (f, 'Units', 'pixels')
set (f, 'Position', pos)
set (f, 'NumberTitle', 'off')
set (f, 'Resize', 'off')

apos = [0 0 w h];
set (gca, 'Units', 'pixels')
set (gca, 'Position', apos)
set (gca, 'XTick', 0);
set (gca, 'YTick', 0);
set (gca, 'XTickLabel', '');
set (gca, 'YTickLabel', '');

x = [0 w];
y = [0 h];
hold on
axis equal
axis ([0 xmax 0 ymax])

box on

