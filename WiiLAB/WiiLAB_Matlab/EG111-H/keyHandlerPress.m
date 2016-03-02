function keyHandlerPress(src,evnt)
% usage: keyHandlerPress(src, evnt)
% purpose: Sets the global variable to reflect the current key press
    global   gCurrentKeyPress
    
    %disp('Invoked key handler');
    
    gCurrentKeyPress = get(gcf,'CurrentCharacter');
    
%    disp(y);    
%    disp(evnt.Character);
end