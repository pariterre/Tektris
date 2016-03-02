function updateTextTime (simTime) 
% usage: updateTextTime (simTime)
% purpose: Update the simulation time passed for the text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtTime;

set(hdlTxtTime, 'String', num2str(simTime));

end