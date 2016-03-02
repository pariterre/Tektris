function keyHandlerRelease(src,evnt)
% usage: keyHandlerRelease (src, evnt)
% purpose: Capture keystroke releases from the keyboard
    global   gCurrentKeyPress

    %disp('Invoked release key handler');
    
    clear global gCurrentKeyPress;
    
    gCurrentKeyPress = 0;
    
%    disp(y);    
%    disp(evnt.Character);
end