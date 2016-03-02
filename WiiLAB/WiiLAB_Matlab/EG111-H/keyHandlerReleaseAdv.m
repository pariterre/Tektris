function keyHandlerReleaseAdv(src,evnt)
% usage: keyHandlerReleaseAdv (src, evnt)
% purpose: Capture keystroke releases from the keyboard
    global   gCurrentKeyPress
    
    
key = get(gcf,'CurrentCharacter');

% Convert to an integer
key = key-0;

gCurrentKeyPress(key) = 0;
end