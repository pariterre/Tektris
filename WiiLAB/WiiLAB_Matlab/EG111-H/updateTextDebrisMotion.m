function updateTextDebrisMotion (DebrisItem, XVel, YVel) 
% usage: updateTextDebrisMotion (DebrisItem, XVel, YVel)
% purpose: Update the velocity information of a specific piece of debris
%          in the text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtDebrisVel;

if DebrisItem > 6 || DebrisItem < 0 
    %disp('Bad input for debris item');
    return;
end
        
tmpString = strcat(num2str(XVel, '%6.2f'),',',num2str(YVel, '%6.2f'));

set(hdlTxtDebrisVel(DebrisItem), 'String', tmpString); 
