function [x, y] = getCenter(b)
%	usage:      [x y] = getCenter (h)
%	purpose:	Returns the coordinates, in drawing units, of the center of the object 
%        		whose handle is h
xd = get(b, 'xData');
yd = get(b, 'yData');
x = ( min(xd) + max(xd) ) / 2;
y = ( min(yd) + max(yd) ) / 2;



