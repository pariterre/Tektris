function keyHandlerPressAdv(src,evnt)
% usage: keyHandlerPress(src, evnt)
% purpose: Sets the global variable to reflect the current key press
    global   gCurrentKeyPress
    
key = get(gcf,'CurrentCharacter');

% Convert to an integer
key = key-0;

gCurrentKeyPress(key) = 1;
    
end