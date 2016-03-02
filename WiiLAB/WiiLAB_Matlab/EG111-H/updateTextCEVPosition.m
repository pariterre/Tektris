function updateTextCEVPosition (XPos, YPos) 
% usage: updateTextCEVPosition (XPos, YPos)
% purpose: Update the position information for the CEV text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtPosAbs;

tmpString = strcat(num2str(XPos, '%6.2f'),',',num2str(YPos, '%6.2f'));

set(hdlTxtPosAbs, 'String', tmpString); 