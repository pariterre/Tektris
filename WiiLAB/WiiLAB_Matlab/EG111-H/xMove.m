function xMove(obj, dx)
%	usage: 	xMove (h, dx)
%	purpose:	Moves the object whose handle is h by dx drawing units horizontally. If 
%        		h is an array, each element of h that is a handle will be moved. dx may
%        		be positive or negative.


if sum(size(obj)) > 2
    for x = obj
        xMove(x,dx)
    end
elseif ishandle(obj)
    try
        set(obj, 'xData', get(obj, 'xData') + dx)
    catch
    end
end
