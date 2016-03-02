function lift(ball)
%  usage:    lift(ball)
%  purpose:  allows the user to move the ball vertically to the position
%            from which they want to throw it

% while the user is holding down the B trigger
    while (isButtonPressed('B'))
        % get the Wiimote's current acceleration
        [xVel yVel] = getWiimoteAccel();
        % get the ball's current position
        [x, y] = getCenter(ball);
        
        % if the default motion will put the ball off the bottom of the
        % window, adjust it so that it'll stop at the bottom of the window
        if ((y - 0.4*yVel) < 10)
            yVel = 10 - y;
            yMove(ball, yVel);
        % if the default motion will put the ball off the top of the
        % window, adjust it so that it'll stop at the top of the window
        elseif ((y - 0.4*yVel) > 290)
            yVel = 290 - y;
            yMove(ball, yVel);
        % default motion to move the ball in response to the Wiimote's
        % y-acceleration
        else
            yMove(ball, -0.4*yVel);
        end %if
        
        % for smoother animation
        redraw;
        pause(0.02);
        
    end %while
    
end