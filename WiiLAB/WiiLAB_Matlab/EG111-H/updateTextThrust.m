function updateTextThrust (PctVThrust, PctHThrust, AccelX, AccelY)
% usage: updateTextThrust (PctVThrust, PctHThrust, AccelX, AccelY)
% purpose: Update the thrust information (percent) and the acceleration
%          provided by that level of thrust for the text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtVThrustPct;
global hdlTxtHThrustPct;
global hdlTxtVThrustAccel;
global hdlTxtHThrustAccel;

tmpString = strcat(num2str(PctVThrust, '%6.2f'),'%');
set(hdlTxtVThrustPct, 'String', tmpString);

tmpString = strcat(num2str(PctHThrust, '%6.2f'),'%');
set(hdlTxtHThrustPct, 'String', tmpString);

tmpString = strcat(num2str(AccelX, '%6.2f'),' m/s2');
set(hdlTxtVThrustAccel, 'String', tmpString);

tmpString = strcat(num2str(AccelY, '%6.2f'),' m/s2');
set(hdlTxtHThrustAccel, 'String', tmpString);
