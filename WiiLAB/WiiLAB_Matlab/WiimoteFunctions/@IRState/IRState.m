% IRState is the class that creates the data structure for storing the IR
% values from the Wiimote

classdef IRState
    
    properties 
        
        source1 = struct('found', false, 'X', 0, 'Y', 0);
        source2 = struct('found', false, 'X', 0, 'Y', 0);
        source3 = struct('found', false, 'X', 0, 'Y', 0);
        source4 = struct('found', false, 'X', 0, 'Y', 0);
        midpoint = struct('found', false, 'X', 0, 'Y', 0);
        
    end % properties
    
end
    