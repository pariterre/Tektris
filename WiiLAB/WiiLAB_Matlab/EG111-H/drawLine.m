function ln = drawLine(x1, y1, x2, y2, col)
%	usage: 	h = drawLine (x1, y1, x2, y2)
%	alternate: 	h = drawLine (x1, y1, x2, y2, ‘color’)
%    purpose:	Draws a line, given two points (x1, y1) and (x2, y2) Returns a handle h, 
%               to the line, i.e. a   variable that can help identify the line being created.
%               The handle can be used by some of the functions below. . If present,
%               color specifies the color of the line.  If not specified, red will be used.

if nargin < 5
    col = 'red'
end

ln = line([x1 x2], [y1 y2], 'Color', col);