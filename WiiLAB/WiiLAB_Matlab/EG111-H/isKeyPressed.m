function [keyPressed]= isKeyPressed(keyToCheck)
%	usage:      isKeyPressed(keyToCheck)
%	purpose:	Tests to see if a key is being pressed
   global gCurrentKeyPress;

   currentKey = gCurrentKeyPress;

% Is there anything to process?
   if isempty(currentKey) == 1;
      keyPressed = 0; 
      return;
   end

% Default is 0 unless we find otherwise
   keyPressed = 0;

% Quick check of an exact match
   if keyToCheck == currentKey
      keyPressed = 1;
   else 
% Exceptions using string checks for the string mappings of arrows
%   (our mapping, not MATLAB's)
      if strcmp(keyToCheck, 'upArrow') == 1;
         if currentKey == 30
            keyPressed = 1
         end
      end  
      if strcmp(keyToCheck, 'downArrow') == 1;
         if currentKey == 31
            keyPressed = 1
         end
      end  
      if strcmp(keyToCheck, 'rightArrow') == 1;
         if currentKey == 29
            keyPressed = 1
         end
      end  
      if strcmp(keyToCheck, 'leftArrow') == 1;
         if currentKey == 28
            keyPressed = 1
         end
      end  
   end
end
