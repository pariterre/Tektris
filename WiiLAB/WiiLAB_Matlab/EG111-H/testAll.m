% Test function

initializeWindow(0);


KeepGoing = true;

while KeepGoing == true
    
    if checkKeyPress('g')
        disp('g');
    end
    
    if checkKeyPress('b')
        disp('b');
    end
    
    if checkKeyPress('q')
        KeepGoing = false;
    end
    
    pause(0.01);
end

