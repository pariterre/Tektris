function BouncingBall()
%  usage:    BouncingBall()
%  purpose:  Creates an interactive bouncing ball application.
%            Users can lift and throw the ball using the Wiimote
%            and watch it bounce.
%  Note:     The animation is a little off.  If the y-velocity gets low
%            enough, there are little "hiccups" during which the ball's
%            bounce appears to be higher than the previous bounce.

    global xVel;
    global yVel;
    global ball;
    global graph;

   
    % add the path containing the bouncing ball functions
    addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\BouncingBallFunctions
    % add the path containing simple graph functions
    addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\GraphingFunctions
       
    % initialize a new figure for the bouncing ball interactions
    createWindow(800, 480, 500, 300);
    setTitle('Bouncing Ball');
    bb_figure = gcf;
    
    % if a connection has been established with the Wiimote
    if(isWiimoteConnected())
        % take care of all the basic stuff and prepare the ball for motion
        resetWindow(bb_figure);
        dir3 = 'Press HOME to quit';
        t3 = text(250, 290, dir3, 'HorizontalAlignment', 'center', 'FontSize', 12);

        % get the ball's location
        [x, y] = getCenter(ball);
        % plot the coordinates of the bottom of the ball
        plot(graph, x, y-10, '*r');

        % while the ball has not yet bounced off the right side of the window
        while(x < 510 && ~isButtonPressed('HOME'))

            % constant horizontal velocity
            xMove(ball, 0.25*xVel);

            redraw;

            % get the new vertical velocity
            getYVel(y);

            % if the updated y-velocity will put the ball "into the ground",
            % only move it enough so that it will stop when it hits the bottom
            if ((y + yVel) < 10)
                yMove(ball, 10-y);
            % otherwise move it as far as the new y-velocity dictates
            else
                yMove(ball, yVel);
            end %if

            % for smoother animation
            redraw;
            pause(0.001);

            % get the ball's new coordinates
            [x, y] = getCenter(ball);
            % plot the position
            plot(graph, x, y-10, '*r');
            pause(0.001);

        end %while

        while(~isButtonPressed('home'))
           %wait for the user to press home and exit 
        end

        hide(t3);
        pause(0.5);

        % close bouncing ball figure
        close(bb_figure);
        close;

        
    % if the Wiimote is not connected
    else
        text(250, 290, 'Wiimote not connected.  Please try again.', ...
            'HorizontalAlignment', 'center', 'FontSize', 12);
        pause(2);
        % close figures
        close(gcf);
        close(gcf);
        
    end %if
    
end
