% GoIrish.m

% If you run this in the learning center, you will need the
%   addpath statement
clear all
initializeWindow(0);

rectGo = drawRectangle(50,100,70,50, [1 1 0]);
rectIrish = drawRectangle(200,100,70,50,[1 1 0]);

textGo = writeText(70,125,'GO');
textIrish = writeText(210, 125, 'IRISH');
setTextColor(textGo,[0 0 1]);
setTextColor(textIrish,[0 0 1]);
setTextSize(textGo,40);
setTextSize(textIrish,40);

keepLooping = true;

hide(rectGo);
hide(rectIrish);
hide(textGo);
hide(textIrish);

while keepLooping == true
    unhide(rectGo);
    unhide(textGo);
    pause(3);
    hide(rectGo);
    hide(textGo);
    unhide(rectIrish);
    unhide(textIrish);
    pause(3);
    hide(rectIrish);
    hide(textIrish);
end

    