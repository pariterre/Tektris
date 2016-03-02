function [keyPressed]= checkKeyPress(keyToCheck)
%	usage:      checkKeyPress(keyToCheck)
%	purpose:	Tests to see if a specific key is being pressed
global gCurrentKeyPress;

% gCurrentKeyPress is an array of values (1 to 255) that covers the
% different ASCII keys that can be pressed.  The element in the array
% will contain a 1 if the key is still being pressed, a 0 otherwise.

% A pause is necessary if the users forget to have one in their main
% loop. Since the callback functions only get invoked during that pause,
% if a student forgets to put in the pause, the code will hang 
pause(0.00001);

% Determine if this is a string or a single character
[R,C] = size(keyToCheck);
   
% Default is 0 unless we find otherwise
keyPressed = 0;   

% The checks on the array use boolean logic.  Boolean logic states that
% anything non-zero (-1, 15, 257) is true and anything zero is false

if R == 1 && C == 1 
    % Single key
    if ischar(keyToCheck)
        % Make the character a number to access the array
        key = keyToCheck-0;

        % If that element is a 1, the key is being pressed
        if gCurrentKeyPress(key)
            keyPressed=1;
            return;
        end    
    else
        if keyToCheck < 1 || keyToCheck > 255              
            error('Invalid ASCII value to check for, must be between 1 and 255');
        end

       % The value passed in is already a numeric ASCII value
        if gCurrentKeyPress(keyToCheck)
           keyPressed=1;
           return;
        end           
    end       
elseif R==1 && C > 1
    if strcmp(keyToCheck, 'upArrow') == 1;
        if gCurrentKeyPress(30)
            keyPressed = 1;
        end
    end
    if strcmp(keyToCheck, 'downArrow') == 1;
        if gCurrentKeyPress(31)
            keyPressed = 1;
        end
    end
    if strcmp(keyToCheck, 'rightArrow') == 1;
        if gCurrentKeyPress(29)
            keyPressed = 1;
        end
    end
    if strcmp(keyToCheck, 'leftArrow') == 1;
        if gCurrentKeyPress(28)
            keyPressed = 1;
        end
    end
else
    % Bad input
    error('Bad input to checkKeyPress, must be a letter or an arrow request');
end
       
   
