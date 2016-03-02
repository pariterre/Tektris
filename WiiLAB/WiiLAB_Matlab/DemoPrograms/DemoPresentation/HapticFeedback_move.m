% This script is the main file of the Haptic Feedback program
%
%
% Author: Jordan Brindza, University of Notre Dame

% Constants
numTargets = 4;  % # >= 1 indicating the total number of target squares
velDamping = 1;  % # <= 1 indicating how the accel values are scaled to vel


% Check if a wiimote was connected
% If not end the script
if(isWiimoteConnected() > 0)

    % Init WiimoteAccelGraph
    initializeWiimoteAccelGraph();
        
    % Init window
    initializeWindow(0);

    % Draw user circle
    wiimoteCircle = drawCircle(150.0, 150.0, 2.5, 'black');
    
    % Draw 4 Random Target Squares
    targets = zeros(1,numTargets);
    sizes = zeros(1,numTargets);
    for i=1:numTargets
        
        size = (rand * 10) + 5;
        target = drawRectangle( ((rand * (300 - 2 * size)) + size), ...
                                ((rand * (300 - 2 * size)) + size), ...
                                size, size, 'red');
        targets(i) = target;
        sizes(i) = (size/2);
        
    end % for
    
    

    % While "Home" is not pressed
    while (~isButtonPressed('HOME'))

        try
        
            % Check if the Center of the userCircle is inside one of the Targets
            % Set Rumble if it is
            setRumble = false;
            [uc_x uc_y] = getCenter(wiimoteCircle);
            targetsAttached = [];

            % Iterate through targets
            for i=1:length(targets)

                % Gather data on targets
                [tc_x tc_y] = getCenter(targets(i));
                isOnTarget = ( ((uc_x > (tc_x - sizes(i))) ...
                                && (uc_x < (tc_x + sizes(i))) ...
                                && (uc_y > (tc_y - sizes(i))) ...
                                && (uc_y < (tc_y + sizes(i)))));

                % If B is pressed and the userCircle is on a target
                if(isButtonPressed('B') && isOnTarget)
                    setColor(targets(i), 'green');
                    targetsAttached = [targetsAttached, i]; %#ok<AGROW>
                else 
                    setColor(targets(i), 'red');
                end % if

            end % for


            % Move with Accel mapped directly to velocity
            % main circle
            %--------------------------------------------------------------   
            [wvelx wvely] = getWiimoteAccel();
            wvelx = wvelx * velDamping;
            wvely = wvely * velDamping;

            xMove(wiimoteCircle, wvelx);
            yMove(wiimoteCircle, wvely);
            %--------------------------------------------------------------

           
            % Move connected targets
            %--------------------------------------------------------------   
            for i=1:length(targetsAttached)  
                
                xMove(targets(targetsAttached(i)), wvelx);
                yMove(targets(targetsAttached(i)), wvely);
                setRumble = true;
                
            end
            %--------------------------------------------------------------   

            % Set the rumble on the wiimote
            setWiimoteRumble(setRumble);


            % Redraw the screen and pause
            redraw();    
            pause(0.001);
        
        catch ME
           
            % Happens if you close the window instead of presing "HOME" to exit       
            disp(ME);
            break;

        end
        
    end % while

    closeWiimoteAccelGraph();
    close(gcf);
   

end
