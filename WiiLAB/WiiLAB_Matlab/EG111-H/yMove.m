function yMove(obj, dy)
%	usage:      yMove (h, dy)
%	purpose:    Moves the object whose handle is h by dy drawing units vertically. If h
%            	is an array, each element of h that is a handle will be moved. dy may be 
%        		positive or negative.

if sum(size(obj)) > 2
    for y = obj
        yMove(y,dy)
    end
elseif ishandle(obj)
    try
        set(obj, 'yData', get(obj, 'yData') + dy)
    catch
    end
end
