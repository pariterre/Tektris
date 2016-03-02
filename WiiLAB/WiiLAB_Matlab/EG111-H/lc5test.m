function lc5test ()

%addpath I:\courses\eg\eg10111.xx\Public\functions 
clear all
 
% Set up the keyboard functions and create a 300 x 300 m space
initializeWindow(0);
 
% draw something in it
c = drawCircle(5,5,5);
 
while 1==1
 tic;
	
 if isKeyPressed('upArrow') == 1
   disp('Up arrow key is pressed');
   yMove(c, 10);
 end
 redraw
 disp('Sleeping');
 pause(0.25-toc);
end 
