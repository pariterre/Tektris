function resetWindow(bb_figure)
%  usage:    resetWindow()
%  purpose:  creates a ball in the open window, displays the appropriate
%            user instructions, and allows the user to lift and toss the
%            ball

global xVel;
global yVel;
global ball;
global graph;
    
    % initialize a plot for graphing the ball's y-position
    figure(2);
    plot(0, 0, 'w');
    hold on;
    setLabels(1, 'X-Coordinates', 'Y-Coordinates', 'Ball''s Position', 1);
    axis([0, 500, 0, 300]);
    graph = gca;

    figure(bb_figure);
    % draw a ball
    ball = drawCircle(18, 10, 10);
    
    % user instructions
    dir1 = 'Hold the B button and tilt the Wiimote up to lift the ball.';
    dir2 = 'Now hold B, swing the Wiimote to the right, and release B to throw the ball.';
    
    t1 = text(250, 290, dir1, 'HorizontalAlignment', 'center', 'FontSize', 12);
            
    waitForButtonPress('B');
    
    lift(ball);
    
    hide(t1);
    t2 = text(250, 290, dir2, 'HorizontalAlignment', 'center', 'FontSize', 12);
    
    waitForButtonPress('B');
    
    % obtain the horizontal velocity as the user "throws" the ball
    getXVel();
    yVel = 0;
    
    hide(t2);
    
end