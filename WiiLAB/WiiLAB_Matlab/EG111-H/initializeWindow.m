function initializeWindow (showText) 
%	usage:      initializeWindow (showText)
%	purpose:	Takes care of creating the window, initializing the
%	keyboard handlers, etc. The showText parameter will determine if
%   the project text is shown.


% Global variables for changing the text content later via helper functions
global hdlTxtFuelLeft;
global hdlTxtVThrustPct;
global hdlTxtHThrustPct;
global hdlTxtVThrustAccel;
global hdlTxtHThrustAccel;

global hdlTxtPosAbs;
global hdlTxtPosVel;
global hdlTxtDistance;

global hdlTxtDebrisPos;
global hdlTxtDebrisVel;

global hdlTxtTime;

w = createWindow(600,600,300,300);

set(gcf,'KeyPressFcn','keyHandlerPressAdv');
set(gcf,'KeyReleaseFcn','keyHandlerReleaseAdv');

% Create the static/unchanging text

if showText == 1
    tmpH = writeText(200,56,'Spacecraft Info');

    set(tmpH, 'FontWeight', 'bold');
    set(tmpH, 'BackgroundColor', 'cyan');

    writeText(210,49, 'Position');
    writeText(210,42, 'Velocity');
    writeText(210,35, 'Distance');
    writeText(210,28, 'Thrust');
    writeText(220,21, 'Fuel');
    writeText(220,14, 'Vertical');
    writeText(220,7, 'Horizontal');


    writeText(275,21, 'kg');

    tmpH = writeText(5, 56, 'Debris Info');

    set(tmpH, 'FontWeight', 'bold');
    set(tmpH, 'BackgroundColor', 'cyan');

    writeText(20, 49, 'Position');
    writeText(70, 49, 'Velocity');
    writeText(10, 42, '1');
    writeText(10, 35, '2');
    writeText(10, 28, '3');
    writeText(10, 21, '4');
    writeText(10, 14, '5');
    writeText(10, 7, '6');

    writeText(200, 100, 'Time Elapsed');

    % Create the dynamic text that will need a handle

    hdlTxtPosAbs = writeText (240, 49,   ' XXX.X,  XXX.X');
    hdlTxtPosVel = writeText (240, 42,   '-XXX.X, -XXX.X');
    hdlTxtDistance = writeText (240, 35, '-XXX.X, -XXX.X');

    hdlTxtFuelLeft = writeText(250, 21, 'XXXX');
    hdlTxtVThrustPct = writeText(250, 14, 'XXX%');
    hdlTxtHThrustPct = writeText(250, 7, 'XXX%');
    hdlTxtVThrustAccel = writeText(270, 14, '-X.XX m/s2');
    hdlTxtHThrustAccel = writeText(270, 7, '-X.XX m/s2');

    hdlTxtDebrisPos(1) = writeText(20, 42, 'XXX.X,XXX.X');
    hdlTxtDebrisPos(2) = writeText(20, 35, 'XXX.X,XXX.X');
    hdlTxtDebrisPos(3) = writeText(20, 28, 'XXX.X,XXX.X');
    hdlTxtDebrisPos(4) = writeText(20, 21, 'XXX.X,XXX.X');
    hdlTxtDebrisPos(5) = writeText(20, 14, 'XXX.X,XXX.X');
    hdlTxtDebrisPos(6) = writeText(20, 7, 'XXX.X,XXX.X');

    hdlTxtDebrisVel(1) = writeText(70, 42, 'XXX.X,XXX.X');
    hdlTxtDebrisVel(2) = writeText(70, 35, 'XXX.X,XXX.X');
    hdlTxtDebrisVel(3) = writeText(70, 28, 'XXX.X,XXX.X');
    hdlTxtDebrisVel(4) = writeText(70, 21, 'XXX.X,XXX.X');
    hdlTxtDebrisVel(5) = writeText(70, 14, 'XXX.X,XXX.X');
    hdlTxtDebrisVel(6) = writeText(70, 7, 'XXX.X,XXX.X');
    
    hdlTxtTime = writeText (250, 100, 'XXX.XXX');
end

end
