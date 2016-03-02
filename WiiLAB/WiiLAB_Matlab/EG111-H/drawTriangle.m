function rt = drawTriangle(x1, x2, x3, y1, y2, y3, col)
%usage:	    rt = drawTriangle(x1, x2, x3, y1, y2, y3)
%   alternate:	rt = drawTriangle(x1, x2, x3, y1, y2, y3, ‘color’)
%   purpose: 	Draws a filled triangle, given three points (x1 y1), (x2, y2) and (x3, y3). 
%               It returns a handle to the triangle created. If present, color specifies the
%               color of the triangle.  If not specified, red will be used.

if (nargin < 5)
    col = 'red'
end

rt = fill([x1 x2 x3 ], [y1 y2 y3], col,'EdgeColor',col);