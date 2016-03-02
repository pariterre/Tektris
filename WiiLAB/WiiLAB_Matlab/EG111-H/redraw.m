function redraw
%	usage:      redraw
%	purpose:	Redraws all objects to reflect their new positions (and flushes the 
%                buffer). Not always needed (depends on the computer’s speed, memory,
%                etc.), but always recommended (it doesn’t hurt to call it). Program may
%                “freeze” without it.
drawnow
