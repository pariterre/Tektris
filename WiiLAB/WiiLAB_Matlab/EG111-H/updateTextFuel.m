function updateTextFuel (FuelLevel)
% usage: updateTextFuel (FuelLevel)
% purpose: Update the fuel information for the text display
% note:  initializeWindow(1) must be called before calling this function

global hdlTxtFuelLeft;

tmpString = strcat(num2str(FuelLevel, '%7.2f'),'%');
set(hdlTxtFuelLeft, 'String', tmpString);