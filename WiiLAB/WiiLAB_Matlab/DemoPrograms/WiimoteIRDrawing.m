% WiimoteIR.m
% Jessica Szweda
%
% Tracks the Wiimote's current position relative to the IR sensor bar
% and draws the location as the 'B' button is held.

% Note:  The movement is currently quite jumpy and erratic.

% add the path containing simple graphics functions
addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\EG111-H
% add the path containing the Wiimote functions
addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\WiimoteFunctions

% constants
RADIUS = 3;
MINVALUE = -1;

prevX = MINVALUE;
prevY = MINVALUE;

% establish a connection with the Wiimote
initializeWiimote();

% if the Wiimote was successfully connected
if isWiimoteConnected()
    % initialize a window
    createWindow(500, 500, 500, 500);
    setTitle('Wiimote IR Drawing');
    
    % The Wiimote's 'HOME' button is used to quit
    while ~isButtonPressed('HOME')
        % obtain the current IR readings
        [x1 y1 x2 y2]  = getWiimoteIR();
        % calculate the midpoint of the 2 IR points that were detected
        % and scale to the figure in which we will be drawing
        x = 500*(1-((x1 + x2)/2.0));
        y = 500*((y1 + y2)/2.0);
        % graphically display the Wiimote's current IR data
        pointer = drawCircle(x, y, RADIUS);
        
        % press and hold the 'B' button to draw
        if isButtonPressed('B')
            % if 'B' was already pressed the last time through the loop
            if ~((prevX == MINVALUE) || (prevY == MINVALUE))
                % connect the pointer's previous location to its current
                drawLine(prevX, prevY, x, y, 'black');
            end %if
            
            % save pointer's location for drawing
            prevX = x;
            prevY = y;
            
        else %if 'B' is not pressed
            % reset these values used for drawing
            prevX = MINVALUE;
            prevY = MINVALUE;
        end %if isButtonPressed
                
        % essential for MATLAB "animation"
        redraw();
        pause(0.01);
        
        % only want to display the current IR location
        hide(pointer);
        
    end %while isButtonPressed
    
    % close drawing figure
    close;
    % done using the Wiimote
    disconnectWiimote();
    
end %if isWiimoteConnected
