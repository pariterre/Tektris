function initializeGraph(subplots)
%   usage:       initializeGraph(number of sepapate graphs)
%   purpose:     sets up a basic window for plotting data

% global needed to modify labels and axes
% global subplots

% tracks currently created number of subplots
counter = 0;

% assigns user-specified value to the global variable
% subplots = numSubplots;

% while there are fewer subplots created than the user specified
while (counter < subplots)
    
    counter = counter + 1;
    
    % specify the next subplot and create an empty standard plot for it
    subplot(subplots, 1, counter), plot(0, 0, 'w');
    
    % allow more data to be written to the subplot
    hold on
    
end %while