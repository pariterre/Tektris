function waitForButtonPress(button)
%  usage:    waitForBPress()
%  purpose:  sits and waits until the user has pressed the specified button
%            on the Wiimote

    % while the B button has not been pressed
    while (~isButtonPressed(button))
        % wait
        pause(0.01);
    end %while
    
end