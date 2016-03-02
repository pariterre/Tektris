function finished(plotNumber, subplots)
%  usage:    finished(plotNumber)
%  purpose:  Turns off hold so that new data will overwrite current data
%            instead of adding to the current plots


subplot(subplots, 1, plotNumber)
hold off