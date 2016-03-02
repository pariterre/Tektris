% Menu
% Demo menu to choose which game to play

% Initialize Window
% --------------------------------------------------------

addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\WiimoteFunctions
addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\EG111-H


initializeWindow(0);
menuHdl = gcf;

% title
setTitle('WiiLAB Demo');
title = writeText(110, 285, 'WiiLAB');
setTextFont(title, 'arial');
setTextColor(title, 'black');
setTextSize(title, 36);

% instructions
insn = writeText(60, 260, 'Please select a demo program below.');
setTextFont(insn, 'arial');
setTextColor(insn, 'black');
setTextSize(insn, 18);
insn2 = writeText(110, 245, 'Press 1 and 2 to Exit.');
setTextFont(insn2, 'arial');
setTextColor(insn2, 'black');
setTextSize(insn2, 14);



% vars
rectSizeX = 80;
rectSizeY = 35;

optionPositions = [ 110 180 ; 50 120 ; 170 120 ; 50 60 ; 170  60 ];
optionRects = zeros(1, 5);
optionText = zeros(2, 5);

% Pong
optionRects(1) = drawRectangle(optionPositions(1,1), optionPositions(1,2), ...
                    rectSizeX, rectSizeY, 'blue');

optionText(1,1) = writeText(135, 198, 'Pong');
setTextFont(optionText(1,1), 'arial');
setTextColor(optionText(1,1), 'white');
setTextSize(optionText(1,1), 20);  

% Inverted Pendulum
optionRects(2) = drawRectangle(optionPositions(2,1), optionPositions(2,2), ...
                    rectSizeX, rectSizeY, 'blue');

optionText(2,1) = writeText(65, 145, 'Inverted');
setTextFont(optionText(2,1), 'arial');
setTextColor(optionText(2,1), 'white');
setTextSize(optionText(2,1), 20);  
optionText(2,2) = writeText(60, 130, 'Pendulum');
setTextFont(optionText(2,2), 'arial');
setTextColor(optionText(2,2), 'white');
setTextSize(optionText(2,2), 20);  

% Bouncing Ball
optionRects(3) = drawRectangle(optionPositions(3,1), optionPositions(3,2), ...
                    rectSizeX, rectSizeY, 'blue');

optionText(3,1) = writeText(183, 145, 'Bouncing');
setTextFont(optionText(3,1), 'arial');
setTextColor(optionText(3,1), 'white');
setTextSize(optionText(3,1), 20);  
optionText(3,2) = writeText(198, 130, 'Ball');
setTextFont(optionText(3,2), 'arial');
setTextColor(optionText(3,2), 'white');
setTextSize(optionText(3,2), 20);  
              

% Accel Motion Tracking
optionRects(4) = drawRectangle(optionPositions(4,1), optionPositions(4,2), ...
                    rectSizeX, rectSizeY, 'blue');

optionText(4,1) = writeText(51, 85, 'Accel Motion'); 
setTextFont(optionText(4,1), 'arial');
setTextColor(optionText(4,1), 'white');
setTextSize(optionText(4,1), 20);  
optionText(4,2) = writeText(65, 70, 'Tracking');
setTextFont(optionText(4,2), 'arial');
setTextColor(optionText(4,2), 'white');
setTextSize(optionText(4,2), 20);  


% Spinning Disk
optionRects(5) = drawRectangle(optionPositions(5,1), optionPositions(5,2), ...
                    rectSizeX, rectSizeY, 'blue');

optionText(5,1) = writeText(185, 85, 'Spinning');
setTextFont(optionText(5,1), 'arial');
setTextColor(optionText(5,1), 'white');
setTextSize(optionText(5,1), 20);  
optionText(5,2) = writeText(198, 70, 'Disk');
setTextFont(optionText(5,2), 'arial');
setTextColor(optionText(5,2), 'white');
setTextSize(optionText(5,2), 20);  


% --------------------------------------------------------


% Connect Wiimote
initializeWiimote();


if ( isWiimoteConnected() )
    
    while (true)

        try
            delete(pointer);
        catch me
        end

        pointerEnabled = false;
        
        
        
        % Draw Pointer
        [x y] = getWiimoteIR_new(0);
                
        if( x ~= 0 && y ~= 0 )
            pointer = drawTriangle( x - 3 , x - 3, x + 3 , y + 3 , y - 3, y, 'black');             
            pointerEnabled = true;
        end
        
        
        
        % Highlight Option
        % --------------------------------------------------------
        selectedOption = [false -1];
        if(pointerEnabled)
            [x y] = getCenter(pointer);
            x = x - 3;
            y = y + 3;
        else
            x = 0;
            y = 0;
        end
        
        for i = 1 : 5
            % figure out if the pointer is on one of the demos
            if ( optionPositions(i,1) < x && ...
                    optionPositions(i,1) + rectSizeX > x && ...
                    optionPositions(i,2) < y && ...
                    optionPositions(i,2) + rectSizeY > y  )
                setColor(optionRects(i), 'yellow');
                setTextColor(optionText(i,1), 'black');
                if ( i ~= 1)
                    setTextColor(optionText(i,2), 'black');
                end
                selectedOption = [true i];
            else
                setColor(optionRects(i), 'blue');
                setTextColor(optionText(i,1), 'white');
                if ( i ~= 1)
                    setTextColor(optionText(i,2), 'white');
                end
            end
        end               
        
        
        if ( isButtonPressed('B') )
            if ( selectedOption(1) )
                switch ( selectedOption(2) )
                    case -1
                        disp('Nothing - how did this happed???');
                    case 1
                        hide(menuHdl);
                        Pong
                        disp('Pong');                        
                        initializeWiimote();
                    case 2
                        hide(menuHdl);
                        InvertedPendulum
                        disp('Inverted Pendulum');
                    case 3
                        hide(menuHdl);
                        BouncingBall
                        disp('Bouncing Ball');
                    case 4
                        hide(menuHdl);
                        HapticFeedback_move
                        disp('Acceleration Movement');
                    case 5
                        hide(menuHdl);
                        SpinningDisk
                        disp('Spinning Disk');                        
                end
            end           
        end
        
        unhide(menuHdl);
        
        % --------------------------------------------------------
        
        % End Demo?
        if( isButtonPressed('one') && isButtonPressed('two') ) 
            disconnectWiimote();   
            close(gcf);
            return;
        end
        
        pause(.001);
        redraw();
        
        end
    
    disconnectWiimote();    
end


    