function InvertedPendulum()
%  usage:    InvertedPendulum()
%  purpose:  allows the user to attempt to balance an
%            inverted pendulum using the Nintendo Wiimote

    
    % create a new empty window
    createWindow(600, 450, 400, 300);
    setTitle('Inverted Pendulum');
    
    % CONSTANTS
    % length of rod
    length = 155;
    % angle of elevation such that the mass is resting on the ground
    lowestAngle = asin(20/(length + 20));
    % equilibrium point
    center = 200;
    % /CONSTANTS
    
    % coordinates of the rod's ends
    x = [center center];
    y = [0 length];
            
    % draw the inverse pendulum
    rod = line(x, y, 'Color', 'black', 'LineWidth', 5);
    mass = drawCircle(center, 175, 20);
    
    if(isWiimoteConnected() > 0)
        % user directions
        t1 = text(center, 290, 'Push A to begin', 'HorizontalAlignment', 'center', 'FontSize', 12);
    
        % user should push the Wiimote's A button to begin
        waitForButtonPress('A');
    
        % cycle through more directions
        hide(t1);
        t2 = text(center, 290, 'Tilt the Wiimote to keep the mass balanced.', 'HorizontalAlignment', 'center', 'FontSize', 12);
        pause(4);
        hide(t2);
        t3 = text(center, 290, 'Ready?', 'HorizontalAlignment', 'center', 'FontSize', 12);
        pause(2);
        hide(t3);
        text(center, 290, 'GO!', 'HorizontalAlignment', 'center', 'FontSize', 12);
        pause(0.1);
        text(390, 10, 'Press HOME to quit', 'HorizontalAlignment', 'right');

        % pressing the Wiimote's HOME button will terminate the program
        while (~isButtonPressed('HOME'))
            % want to rotate the inverse pendulum based on the Wiimote's
            % x-acceleration
            theta = -2*getWiimoteAccel();

            % obtain the mass's current x-coordinate
            XCMass = getCenter(mass);
            % account for gravity by increasing the angle of rotation as the
            % pendulum gets further from its equilibrium point
            theta = theta - 0.08*(XCMass - center);

            % use a basic trigonometric function to calculate the pendulum's
            % current angle of elevation
            beta = acos((XCMass-center)/(length + 20));
            % determine what the new angle of elevation will be upon rotation
            alpha = beta - deg2rad(-1*theta);
            % use the new angle to determine what the mass's height will be
            newYCMass = (length + 20)*sin(alpha);

            % if the obtained angle of rotation would put the pendulum
            % unrealistically "into the ground", adjust the angle by which it
            % will rotate so that it just hits the bottom of the window and
            % stops there
            if (newYCMass < 20)
                alpha = lowestAngle;
                % if the mass is to the left of the center/equilibrim point
                if (XCMass < center)
                    % adjust the angle so that it correctly lies in the second
                    % quadrant
                    alpha = pi-alpha;
                end %if
                % adjust the rotation angle based on the lowest realistic angle
                % of elevation and the pendulum's current angle of elevation
                theta = -1*rad2deg(beta - alpha);
            end %if

            % rotate the pendulum around its fixed base by the specified angle
            rotate(rod, [0,0,1], theta, [center,0,0]);
            rotate(mass, [0,0,1], theta, [center,0,0]);

            % slight pause to keep animation running smoothly
            pause(0.1);

        end %while
        
        pause(0.5);
        % close window
        close;
     
    % if wiimote is not connected    
    else 
        % notify the user
        text(center, 290, 'Wiimote is not connected.  Please try again.', ...
            'HorizontalAlignment', 'center', 'FontSize', 12);
        
        pause(1.5);
        % close window
        close(gcf);
        
    end %if
    
end
    

    
    