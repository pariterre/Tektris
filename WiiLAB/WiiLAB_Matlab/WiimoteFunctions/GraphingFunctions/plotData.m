function plotData(plotNumber, xval, yval, subplots, yMin, yMax, width)
%  usage:    plotData(plotNumber, xVal, yVal)
%  purpose:  plots a user-given data point in the specified subplot
%  note:     setAxes must be called before this function can be used

% determine the x-axis scaling so that it matches the original
% user-specified width
xMin = xval - 0.8*width(plotNumber);
xMax = xval + 0.2*width(plotNumber);

subplot(subplots, 1, plotNumber)
setAxes(plotNumber, xMin, xMax, yMin(plotNumber), yMax(plotNumber), subplots, yMin, yMax, width);
plot(xval, yval, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');