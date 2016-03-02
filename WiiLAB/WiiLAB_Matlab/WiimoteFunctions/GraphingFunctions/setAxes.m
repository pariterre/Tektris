function [yMin yMax width] = setAxes(plotNumber, xmin, xmax, ymin, ymax, subplots, yMin, yMax, width)
%  usage:    setAxes(plotNumber, xMin, xMax, yMin, yMax);
%  purpose:  initializes the min and max values of both the x- and y-axis

% store the y-values so the graph height remains constant, and the width
% variable allows automatic horizontal scrolling when data is plotted

width(plotNumber) = xmax - xmin;
yMin(plotNumber) = ymin;
yMax(plotNumber) = ymax;

subplot(subplots, 1, plotNumber)
axis([xmin, xmax, ymin, ymax]);