function updateTextDebrisPos (DebrisItem, XPos, YPos) 
% usage: updateTextDebrisPos (DebrisItem, XPos, YPos)
% purpose: Update the position information of a specific piece of debris
%          in the text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtDebrisPos;

if DebrisItem > 6 || DebrisItem < 0 
    %disp('Bad input for debris item');
    return;
end

tmpString = strcat(num2str(XPos, '%6.2f'),',',num2str(YPos, '%6.2f'));

set(hdlTxtDebrisPos(DebrisItem), 'String', tmpString); 
