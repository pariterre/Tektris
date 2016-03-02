function getYVel(y)
%  usage:    getYVel(yPosition)
%  purpose:  calculate the new Y-velocity so the ball can be moved
%            "accurately" (a relative term) in the BouncingBall program

    global yVel;

    % if the ball has hit the bottom of the screen
    if (y <= 10)
        % change the direction of y-velocity and account for elasticity
        yVel = -0.8*yVel;

    % if ball is moving just fine
    else
        % make it either fall more quickly or climb more slowly, due to gravity
        yVel = yVel - 0.98;
    end %if

end