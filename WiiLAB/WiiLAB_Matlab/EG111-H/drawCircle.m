function b = drawCircle(xc, yc, rad, col)
%	usage:      h = drawCircle (xc, yc, r)
%	alternate:	h = drawCircle (xc, yc, r, ‘color’)
%	purpose:	Draws a filled circle centered at (xc, yc) in drawing coordinates, and
%               with a radius of r in drawing coordinates. Returns a handle to the 
%               circle being created.  If present, col specifies the color of the circle.  If 
%               not specified, red will be used.
%

i = sqrt(-1);
c = plot(exp(i*[0:pi/100:2*pi])*rad + xc + yc*i);

xd = get(c, 'xdata');
yd = get(c, 'ydata');

set(c, 'Visible', 'off');

if (nargin < 4)
    col = 'red';
end

b = fill(xd, yd, col, 'EdgeColor', col);
set(b, 'Erase', 'xor')
set(b, 'Linewidth', 1)