% This script is the main file of the Spinning Disk program
%
%
% Author: Jordan Brindza, University of Notre Dame


% Constants
diskRadius = 100;     % # indicating the radius of the disk
diskCenter = [150 150];
cursorRadius = 2;     % # indicating the radius of the cursor
frictionCoef = .02;
wedges = 8;
wedgeColors =  ['b' 'g' 'r' 'y' 'b' 'g' 'r' 'y'];

% Variables
posTheta = 0;
posQuad = 0;
velTheta = 0;
velQuad = 0;

% Check if a wiimote was connected
% If not end the script
if(isWiimoteConnected() > 0)

    % Initialize the screen
    % ---------------------------------------------------------------
    % Init basic window
    initializeWindow(0);
    
    %initialize text display
    x_accelDispLbl = writeText(20,280,'X accel = ');
    y_accelDispLbl = writeText(20,270,'Y accel = ');
    diskVelDispLbl = writeText(20,260,'Disk vel = ');
    x_accelDisp = writeText(50, 280, 'xx');
    y_accelDisp = writeText(50, 270, 'xx');
    diskVelDisp = writeText(50, 260, 'xx');
    
    
    % Init the wiimote cursor
    wiimoteCursor = drawCircle(150, 150, cursorRadius, 'black');
    
    % Init the main disk    
    disk = drawCircleWedges(diskCenter(1), diskCenter(2), diskRadius, wedges, wedgeColors);
    
    
    % Local Variables
    onDisk = false;
    prevAttached = false;
    attached = false;
    diskVel = 0;
    
    % While "Home" is not pressed
    while (~isButtonPressed('HOME'))

        try
        
            % Determine if the wiimoteCursor is on the disk
            % ---------------------------------------------
            [xc yc] = getCenter(wiimoteCursor);
            
            distanceFromDiskCenter = sqrt((xc-diskCenter(1))^2 + (yc-diskCenter(2))^2);
            
            if(distanceFromDiskCenter <= diskRadius)
                onDisk = true;
            else
                onDisk = false;
            end             
            % ---------------------------------------------
            
                        
            if(isButtonPressed('B'))
                                
                % if the cursor is on the disk
                if(onDisk)
                    attached = true;                                        
                else
                    attached = false;                    
                end                
            else
                if(attached)
                    attached = false;
                    prevAttached = true;
                else
                    prevAttached = false;
                end
            end
            
            if(prevAttached)

                [x_accel y_accel] = getWiimoteAccel();
                
                
                % Calculate Disk Velocity
                % Sort of works
                % -----------------------------------------------------
                % Calculate position and acceleration angles (0 >< 90)
                posTheta = atan(abs(yc-diskCenter(2))/abs(xc-diskCenter(1))) * (180/pi);
                velTheta = atan(abs(y_accel)/abs(x_accel)) * (180/pi);

                % Calc quadrent
                if((xc - diskCenter(1) > 0) && (yc - diskCenter(2) > 0))
                    posQuad = 1;
                elseif ((xc - diskCenter(1) > 0) && (yc - diskCenter(2) < 0))
                    posQuad = 4;    
                elseif ((xc - diskCenter(1) < 0) && (yc - diskCenter(2) < 0))
                    posQuad = 3;
                elseif ((xc - diskCenter(1) < 0) && (yc - diskCenter(2) > 0))
                    posQuad = 2;
                end

                if (x_accel > 0 && y_accel > 0)
                    velQuad = 1;
                elseif (x_accel > 0 && y_accel < 0)
                    velQuad = 4;
                elseif (x_accel < 0 && y_accel < 0)
                    velQuad = 3;
                elseif (x_accel < 0 && y_accel > 0)
                    velQuad = 2;
                end

                switch (velQuad)
                    case 2
                        velTheta = 180 - velTheta;                        
                    case 3
                        velTheta = 180 + velTheta;
                    case 4
                        velTheta = 360 - velTheta;
                end

                switch (posQuad)
                    case 1
                        theta = (90 - posTheta) + velTheta;
                    case 2
                        theta = -1*(90 - posTheta) + velTheta;
                    case 3
                        theta = (90 - posTheta) + velTheta;
                     case 4
                        theta = -1*(90 - posTheta) + velTheta;
                 end


                diskVel = cos((theta*pi/180)) * sqrt(x_accel^2 + y_accel^2);                    
                % factor in distance from the center
                diskVel = 2 * diskVel * (distanceFromDiskCenter/diskRadius);     
                if(posQuad < 3)
                    diskVel = -1*diskVel;
                end
                    

                set(x_accelDisp, 'String', x_accel);
                set(y_accelDisp, 'String', y_accel);
                set(diskVelDisp, 'String', diskVel);
                
                % Draw Vector
                try
                hide(vector);
                hide(arrow);
                catch me
                end
                vector = drawLine(xc, yc, xc+(2*x_accel), yc+(2*y_accel), 'k');
                %------------------------------------------------------
                                        
            end                
                        
            % If the Wiimote is "attached" to the disk
            % don't move the wiimote
            if(~attached)
                rotate(disk, [0 0 1], diskVel);
                
                % If the disk is rotating decrease its speed according to
                % the "frictionCoef"
                if(diskVel ~= 0)
                    diskVel = diskVel - diskVel * frictionCoef;
                end
                
                % Update the wiimote cursor position
                moveObjectWithWiimote(wiimoteCursor, 1, false);
            end
           
            redraw();
            pause(.01);
            
        catch ME

            % Happens if you close the window instead of presing "HOME" to exit                        
            disp(ME);
            break;

        end
        
    end % while

    close(gcf);

end
