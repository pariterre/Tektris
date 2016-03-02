% Pong - Recreation using the Nintendo Wiimote as a controller
%
% Author: Jordan Brindza, University of Notre Dame

% add the path containing simple graphics functions
addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\EG111-H
% add the path containing the Wiimote functions
addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\WiimoteFunctions

% Constants
velDamping = 1;     % # <=1 to scale the incoming accel to vel
ballSize = 2;       % # indicating the ball size (1/2 the actual size)
paddleSize_x = 2.5; % # indicating the x paddle size (1/2 of the actual size)
paddleSize_y = 10;  % # indicating the y paddle size (1/2 of the actual size)
ballSpeed = 1.5;      % # indicating the total speed of the ball
gameover = false;

% Disconnect all wiimotes to initialize new wiimotes
wiimote = Wiimote();
wiimote.DisconnectAllWiimotes();

% Create an instance of the wiimote and connect it
wiimote1 = Wiimote();
wiimote2 = Wiimote();
wiimote1.Connect();
wiimote2.Connect();


% If two wiimotes were found
if(wiimote1.isConnected > 0 && wiimote2.isConnected > 0)
     
    % Initialize Window
    % -----------------------------------------------------------------
    % Init window
    initializeWindow(0);
    setTitle('Pong');
    
    % set background color
    set(gca,'Color','black');

    % Draw Center Line
    for i = 0 : 19
        drawRectangle(149, (5 + i*15), 2, 5, [.7 .7 .7]);    
    end

    % Draw score
    p1_score = 0;
    p2_score = 0;
    p1_score_disp = writeText(80,280,'0');
    set(    p1_score_disp, 'FontWeight', 'bold', ...
            'FontSize', 64, 'FontName', 'OCR A Extended', ...
            'Color', [.7 .7 .7]);
    p2_score_disp = writeText(180,280,'0');
    set(    p2_score_disp, 'FontWeight', 'bold', ...
            'FontSize', 64, 'FontName', 'OCR A Extended', ...
            'Color', [.7 .7 .7]);

    % Draw user paddles
    player1_Paddle = drawRectangle(5, 135, paddleSize_x * 2, paddleSize_y * 2, 'white');
    player2_Paddle = drawRectangle(290, 135, paddleSize_x * 2, paddleSize_y * 2, 'white');

    % Draw ball
    ball = drawRectangle((150 - ballSize), (150 - ballSize), (ballSize * 2), (ballSize * 2), 'white');
    needNewBall = false;
    % Initialize ball speed
    ydir = (rand * 2) - 1; 
    xdir = ballSpeed;   
    % -----------------------------------------------------------------


    % While "Home" is not pressed
    wiimote1.UpdateWiimoteState();
    wiimote2.UpdateWiimoteState();

    while (~wiimote1.Buttons.Home && ~gameover)

        % Get the wiimote status
        wiimote1.UpdateWiimoteState();
        wiimote2.UpdateWiimoteState();

        % Move the paddle with Accel mapped directly to velocity
        % player 1
        %--------------------------------------------------------------   
        vely1 = wiimote1.Accel.Y * velDamping;
        [x_p1 y_p1] = getCenter(player1_Paddle);

        if( ((y_p1 + paddleSize_y) + vely1 < 300) && ((y_p1 - paddleSize_y) + vely1 > 0) ) 
            yMove(player1_Paddle, vely1);    
        elseif ( ((y_p1 + paddleSize_y) + vely1 > 300) && ((300 - (y_p1 + paddleSize_y)) > 0) )
            yMove(player1_Paddle, (300 - (y_p1 + paddleSize_y)));   
        elseif ( ((y_p1 - paddleSize_y) + vely1 < 0) && (0 - (y_p1 - paddleSize_y) < 0) )
            yMove(player1_Paddle, (0 - (y_p1 - paddleSize_y)));   
        end
        %--------------------------------------------------------------

        % Move the paddle with Accel mapped directly to velocity
        % player 2
        %--------------------------------------------------------------   
        vely2 = wiimote2.Accel.Y * velDamping;
        [x_p2 y_p2] = getCenter(player2_Paddle);

        if( ((y_p2 + paddleSize_y) + vely2 < 300) && ((y_p2 - paddleSize_y) + vely2 > 0) ) 
            yMove(player2_Paddle, vely2);    
        elseif ( ((y_p2 + paddleSize_y) + vely2 > 300) && ((300 - (y_p2 + paddleSize_y)) > 0) )
            yMove(player2_Paddle, (300 - (y_p2 + paddleSize_y)));   
        elseif ( ((y_p2 - paddleSize_y) + vely2 < 0) && (0 - (y_p2 - paddleSize_y) < 0) )
            yMove(player2_Paddle, (0 - (y_p2 - paddleSize_y)));   
        end
        %--------------------------------------------------------------


        % Move the ball
        %---------------------------------------------------------------
        [x_ball y_ball] = getCenter(ball);

        % if it is against the upper or lower wall switch its ydir
        if( ((y_ball + ballSize) > 300) || ((y_ball - ballSize) < 0) )
            ydir = -1 * ydir;
        end

        % If the ball is behind player 1's line
        if( ((x_ball + ballSize) > 290) )
            if( ((y_ball - ballSize) < y_p2 + paddleSize_y) ...
                    && ((y_ball + ballSize) > y_p2 - paddleSize_y) )
                
                xdir = -1 * xdir;
                
                ydir = vely2 * (.5 * velDamping);                
                
            else
                p1_score = p1_score + 1;
                set(p1_score_disp, 'string', p1_score);
                needNewBall = true;
            end       
        % If the ball is behind player 2's line
        elseif( ((x_ball - ballSize) < 10) )
            if( ((y_ball - ballSize) < y_p1 + paddleSize_y) ...
                    && ((y_ball + ballSize) > y_p1 - paddleSize_y) )
                
                xdir = -1 * xdir;
                
                ydir = vely1 * (.5 * velDamping);                 
                
            else
                p2_score = p2_score + 1;
                set(p2_score_disp, 'string', p2_score);
                needNewBall = true;
            end
        end


        % Actually move the ball
        xMove(ball, xdir);
        yMove(ball, ydir);
        %---------------------------------------------------------------


        % make a new ball if needed
        if(needNewBall)

            % make the new ball
            hide(ball);
            ball = drawRectangle((150 - ballSize), (150 - ballSize), (ballSize * 2), (ballSize * 2), 'white');

            % set a random y dir
            ydir = (rand * 2) - 1; % number between -5 and 5

            % reset the paddles back to the center
            hide(player1_Paddle);
            hide(player2_Paddle);
            player1_Paddle = drawRectangle(5, 135, paddleSize_x * 2, paddleSize_y * 2, 'white');
            player2_Paddle = drawRectangle(290, 135, paddleSize_x * 2, paddleSize_y * 2, 'white');

            needNewBall = false;

            % pause
            pause(1);

        end

        % check if someone has won 
        if (p1_score == 11)
            winner = 1;
            gameover = true;
        elseif (p2_score == 11)
            winner = 2;
            gameover = true;
        end

        % Redraw the screen and pause
        redraw();    
        pause(0.01);

    end % while

else
    
    disp('Not enough wiimotes available to play');
    
end

if(gameover)
    winDisp = writeText(65,100,['Player ' int2str(winner) ' Wins!']);
    set(    winDisp, 'FontWeight', 'bold', ...
            'FontSize', 32, 'FontName', 'OCR A Extended', ...
            'Color', 'red');
end

pause(5);
    
% Disconnect the Wiimote
if(wiimote1.isConnected > 0)
    wiimote1.Disconnect();
end
if(wiimote2.isConnected > 0)
    wiimote2.Disconnect();
end