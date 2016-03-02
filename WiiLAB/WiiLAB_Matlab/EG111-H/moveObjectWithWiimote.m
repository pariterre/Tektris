function moveObjectWithWiimote(obj, velDamping, allowOutsideEdges)
%	usage:      moveObjectWithWiimote (obj)
%	purpose:	Moves the object whose handle is obj by dx and dy drawing 
%               units. dx and dy will be calculated from the x and y accel
%               of the wiimote respectively. If obj is an array, each 
%               element of obj that is a handle will be moved. 
%               velDamping is a double value used to scale the Accel values 
%   note:       Determining if the object is outside of the edges assumes
%               the object is regular for best results (rectangle, circle, etc)

if(nargin < 2)
    allowOutsideEdges = true;
    velDamping = 1;
end


[wvelx wvely] = getWiimoteAccel();
wvelx = wvelx * velDamping;
wvely = -1 * wvely * velDamping;

if(~allowOutsideEdges)
    xd = get(obj, 'xdata');
    yd = get(obj, 'ydata');
           
    if ( max(xd) + wvelx > 300 )
        wvelx = (300 - (max(xd)));
    elseif ( min(xd) + wvelx < 0 )
        wvelx = 0 - min(xd);
    end
    
    if ( max(yd) + wvely > 300 )
        wvely = (300 - (max(yd)));
    elseif ( min(yd) + wvely < 0 )
        wvely = 0 - min(yd);
    end    
end

xMove(obj, wvelx);
yMove(obj, wvely);
