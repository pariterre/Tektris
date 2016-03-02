function rc = drawRectangle(x, y, w, h, col)
%	usage: 	rc = drawRectangle (x, y, w, h)
%	alternate: 	rc = drawRectangle (x, y, w, h, color)
%	purpose:	Draws a filled rectangle, with the lower left hand corner  at point (x, y) 
%       		with width w and height h; w and h may be negative.  It returns a 
%       		handle to the rectangle being created. If present, color specifies the color 
%       		of the rectangle.  If not specified, red will be used.

x1 = x;
x2 = x + w;
y1 = y;
y2 = y + h;
if nargin < 5
    col = 'red';
end
rc = fill([x1 x1 x2 x2], [y1 y2 y2 y1], col,'EdgeColor',col);