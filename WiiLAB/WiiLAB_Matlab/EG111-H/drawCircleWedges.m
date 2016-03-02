function H = drawCircleWedges(xc, yc, radius, wedges, colors)
%	usage:      H = drawCircleWedges (xc, yc, radius, wedges, colors)
%	purpose:	Draws a filled circle centered at (xc, yc) in drawing coordinates, and
%               with a radius of radius in drawing coordinates. The circle
%               will be divided into sections equal to 'wedges' each one
%               will be colored based on the colors in 'colors'.
%               Returns a handle to the circle being created. 
%   note:       colors is an array of colors whose size is at least the
%               number of wedges


if (nargin < 4)
    error('Too few arguments.');
elseif (length(colors) < wedges)
    error('You must provide at least as many colors as the number of wedges');
end

NOP = 50;

H = zeros(1, 2 * wedges);

for i = 1 : wedges

    THETA = linspace((i-1) * (2*pi/wedges), i * (2*pi/wedges), NOP);
    RHO = ones(1,NOP)*radius;

    [X,Y] = pol2cart(THETA,RHO);
    X = X + xc;
    Y = Y + yc;

    c = plot(X,Y);

    xd = get(c, 'xdata');
    yd = get(c, 'ydata');

    hide(c);

    H(i) = fill(xd, yd, colors(i), 'EdgeColor', colors(i));
    
    H(wedges + i) = drawTriangle(   xc, ...
                                    xc + radius*cos((i-1) * (2*pi/wedges)), ...
                                    xc + radius*cos((i) * (2*pi/wedges)), ...
                                    yc, ...
                                    yc + radius*sin((i-1) * (2*pi/wedges)), ...
                                    yc + radius*sin((i) * (2*pi/wedges)), ...
                                    colors(i));
    
end

axis square;