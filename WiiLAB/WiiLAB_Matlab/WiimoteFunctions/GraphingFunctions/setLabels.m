function setLabels(plotNumber, xAxis, yAxis, aTitle, subplots)
%   usage:      setLabels(plotNumber, x-axis label, y-axis label)
%   alternate:  setLabels(plotNumber, x-axis label, y-axis label, title)
%   purpose:    sets the x- and y-axis labels and an optional title of the
%               specified subplot

%   if no title specified, set it to an empty string
if (nargin < 4)
    aTitle = '';
end

%   select the subplot to edit
subplot(subplots, 1, plotNumber)

%   set the labels as specified
xlabel(xAxis);
ylabel(yAxis);
title(aTitle, 'FontSize', 11, 'FontWeight', 'bold');