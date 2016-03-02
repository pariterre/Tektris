%------------------------------------------------------------------------
%  Getting Started Program Demo
%  
%  This program is designed to give a new user the skeleton code to allow
%  them to easily and quickly begin using WiiLAB. The program contains all
%  the vital code that is needed to connect to and use the Wiimote along
%  with reserved sections for the user to add their code.
%
%  Jordan Brindza, University of Notre Dame
%------------------------------------------------------------------------

% Add the paths for the Wiimote and Graphics Functions
% These paths are assuming you are using the installer for WiiLAB that was
% provided. If you did not then change the paths to the location of the
% WiimoteFunctions and EG111-H folders on your computer
addpath C:\'Program Files'\Wiimote\WiiLAB_Matlab\WiimoteFunctions
addpath C:\'Program Files'\Wiimote\WiiLAB_Matlab\EG111-H


% Connect to the Wiimote
initializeWiimote();

% Create the graphics Window (optional but recommended)
initializeWindow(0);


% -------------------------------------------------------------


% YOUR CODE HERE
% Any graphics objects that will be used throughout your program should go
% here.
% For example, if you are creating an program that will use the Wiimote 
% to move a circle around the screen, you should create the circle here.


% -------------------------------------------------------------


% Check to make sure the Wiimote is connected
if( isWiimoteConnected() > 0 )
    
    
    % Main program loop
    % Used for polling the Wiimote data
    % This loop will run until 'HOME' on the Wiimote is Pressed
    while(~isButtonPressed('HOME'))
        
        
        % -------------------------------------------------------------    
    
    
    
        
        % YOUR CODE HERE
        % The main portion of your program will go here.
        
    
    
        % -------------------------------------------------------------    
    
    
        % Redraw - This is for the graphics functions to make sure they are
        % displaying the most recent changes
        redraw();
        
        % Pause - This is a required step. If it is not included you will
        % experience unexpected behavior.
        pause(.001);                
    
    end % while    
    
else
    
    % The Wiimote was not successfully connected
    message = [ 'There was a problem with connecting to the Wiimote. ' ...
                'Please make sure the Wiimote is properly connected ' ...
                'to the computer and rerun the program.' ];
                
    % This will write the message to the command line        
    disp(message);
    
    % This will create a message box with the message
    uiwait(msgbox(message, 'Connection Problem', 'error'));   
    
end % if


% Disconnect the Wiimote
disconnectWiimote();