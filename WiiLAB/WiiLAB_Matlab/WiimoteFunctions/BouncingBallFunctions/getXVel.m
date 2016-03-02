function getXVel()
%  usage:    getXVel()
%  purpose:  obtains the velocity with which the user throws the ball by
%            swinging the Wiimote to the right

global xVel;

    % while the Wiimote's B trigger is held down
    while (isButtonPressed('B'))
        % update the velocity in response to the Wiimote's acceleration
        xVel = getWiimoteAccel();
    end %while

    % if user swung the Wiimote the wrong direction or let go of B at the
    % wrong time, producing a nonpositive velocity
    if (xVel <= 0)
        t4 = text(250, 275, 'Please try again.', 'HorizontalAlignment', 'center', 'FontSize', 12);
        %xVel = 1;
        waitForButtonPress('B');
        getXVel();
        hide(t4);
    end %if
    
end