function updateTextCEVMotion (VelX, VelY) 
% usage: updateTextCEVMotion (VelX, VelY)
% purpose: Update the velocity of the CEV text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtPosVel;

tmpString = strcat(num2str(VelX, '%6.2f'),',',num2str(VelY, '%6.2f'));

set(hdlTxtPosVel, 'String', tmpString); 