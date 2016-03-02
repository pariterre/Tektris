function setColor(obj, col)
%	usage:      setColor(obj, ‘color’)  or  setColor(obj, [r g b])
%	purpose:	Changes the color of the object whose handle is obj to the color
%                specified either by color or by the [r g b] red/green/blue triplet, 
%                where each value is a real number between 0 and 1.

set(obj, 'FaceColor', col);
set(obj, 'EdgeColor', col);