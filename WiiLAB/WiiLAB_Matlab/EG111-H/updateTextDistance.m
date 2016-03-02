function updateTextDistance (XDist, YDist, ActDist)
% usage: updateTextDistance (XDist, YDist, ActDist)
% purpose: Update the distance information of the CEV relative to the
%          docking port on the space station for the text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtDistance;

tmpString = strcat(num2str(XDist, '%6.2f'),',',num2str(YDist, '%6.2f'),' -> ',num2str(ActDist, '%6.2f'));

set(hdlTxtDistance, 'String', tmpString); 