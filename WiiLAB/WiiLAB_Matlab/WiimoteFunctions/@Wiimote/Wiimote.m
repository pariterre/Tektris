% This script is the main file of the Wiimote Class
% This class provides the main functionality to connect to and interact
% with a wiimote using Matlab
%
% Version 1.1
%
% Author:   Jordan Brindza, University of Notre Dame
%           Jessica Szweda, University of Notre Dame

%% Wiimote Class
classdef Wiimote < handle
    
    
    %% Public properties
    properties 
       
        % None at this time
                        
%     end % Public properties
   
    
    %% Private properties
%     properties (SetAccess = private)
   % Private properties, viewable but not settable by the user
   
       % An int value depending on which wiimote is connected
       % 1/2/3/4 - specifies which wiimote is connected
       % 0 - if there are no available wiimotes (they are all in use)
       % -1 - There are no wiimotes on this computer to connect to
       % -2 - Default value before initialization
       isConnected = -2;
       % LED struct
       LEDs = LEDState;
       % Rumble
       Rumble = false;
       % Accel struct:
       % [X Y Z]
       Accel = AccelState;
       % AccelIndicator struct:
       % [Enabled refObj dampingCoef vector]
       AccelIndicator = struct( 'Enabled', false, ...
                                'refObj', [], ...
                                'dampingCoef', 0, ...
                                'vector', []);
       % Buttons struct:
       % [A B Up Right Down Left Plus Minus Home One Two]
       Buttons = ButtonState;
       % IR struct:
       % [source1 source2 source3 source4 midpoint]
       % each of these is a IRState struct:
       % [found X Y]
       IR = IRState;
       % Double value from 0-100 representing the percentage of battery
       % remaining
       Battery
       
       % Nunhuck properties
       % Button Struct:
       % [C Z]
       NunchukButtons = NunchukButtonState;
       % Accel struct:
       % [X Y Z]
       NunchukAccel = AccelState;
       % Joystick struct:
       % [X Y]
       NunchukJoystick = NunchukJoystickState;

       BalanceBoardSensors = SensorState;
       BalanceBoardCoG = CoGState;
       
       % AccelGraph struct:
       % [Enabled handle subplots yMin yMax width timer]
       AccelGraph = struct( 'Enabled', false, ...
                            'handle', [], ...
                            'subplots', 0, ...
                            'yMin', 0, ...
                            'yMax', 0, ...
                            'width', 0, ...
                            'timer', 0);
   
%     end % Private properties
      
    

    %% Non Accessible properties
%     properties (Access = private, Hidden = true)
    % These properties are not accessible or viewable by the user
       
        % actxserver for the wiimote library
        wm
       
        % Raw Wiimote Values
        % These variables contain the arrays that are returned from the dll
        % These are for internal use and quick access without the need to
        % go through the structs
        rawLEDs = [false false false false];
        rawAccel
        rawButtons
        rawIR
        rawNunchukAccel
        rawNunchukButtons
        rawNunchukJoystick
       
   end % Non Accessible properties

   
   
    %% Public methods 
    methods    
   
        
        %% Constructor
        %  Constructor
        %  Initializes the COM sever 'WiiLab.WiiLab'
        %  @return wiimote object
        function wiimote = Wiimote()
            %keyboard
            wiimote.wm = actxserver('WiiLAB.WiiLAB');
            
        end % Constructor

        
        %% Connect / Disconnect
        %  Connect
        %  Connects to the wiimote and sets the input report type
        %  @param wiimote The wiimote object
        function Connect(wiimote)
       
            if(wiimote.isConnected <= 0)
                % Connect to the wiimote
                wiimote.isConnected = wiimote.wm.Connect();

                if(wiimote.isConnected > 0)                
                    % Set LEDs property
                    wiimote.SetLEDs((bitand(wiimote.isConnected, 1) > 0), ...
                                    (bitand(wiimote.isConnected, 2) > 0), ...
                                    (bitand(wiimote.isConnected, 4) > 0), ...
                                    (bitand(wiimote.isConnected, 8) > 0));
                    % Display Connection Message
                    disp(['Wiimote ' int2str(wiimote.isConnected)...
                            ' Successfully Connected']);
                elseif (wiimote.isConnected == 0)
                    % There are wiimotes connected to this computer but they
                    % are all in use
                    disp('All Wiimotes connected to the computer are in use.');
                elseif (wiimote.isConnected == -1)
                    % There are no wiimotes connected to this computer
                    disp('There are no Wiimotes connected to this computer.');
                end
            else
                disp('The wiimote is already connected.');
            end

        end % Connect

        
        %  CheckConnection
        %  Attempts to retrieve information from the Wiimote
        %  This function is a "quick" fix around a Wiimote Read Error that
        %  will cause Matlab to crash if the Wiimote is Prematurely
        %  disconnected
        %  If the connection is bad the function will throw an error and
        %  halt execution
        %  If the connection is good the function will return and execution
        %  will continue
        %  This method will be called by every function that comunicates
        %  with the Wiimote
        function CheckConnection(wiimote)
        
            % Check the connection
            if (wiimote.wm.CheckConnection()<0)
                % Tell the user the connection has been lost
                uiwait(msgbox(['The connection to the Wiimote has been lost. ' ...
                                'Please reconnect the Wiimote'], ...
                                'Connection Lost', 'error'));
            
                % throw an error to halt the program
                error(['The connection to the Wiimote has been lost. '...
                        'Please reconnect the Wiimote.']);
            end
            
        end
        
        %  Disconnect
        %  Disconnects the wiimote
        %  @param wiimote The wiimote object
        function Disconnect(wiimote)
       
            % Check Connection
            wiimote.CheckConnection();
            
            % Clean up the Wiimote
            % Turn off Rumble if it is on
            wiimote.SetRumble(false);
            % Set All LEDs On
            wiimote.SetLEDs(true, true, true, true);
            % temp wiimote id
            tempID = wiimote.isConnected;
            % Disconnect the wiimote
            wiimote.isConnected = ~wiimote.wm.Disconnect();          
            % Reset Properties
            wiimote.ResetProperties();          
            % Display Disconnect Message
            if(~wiimote.isConnected)
                disp(['Wiimote ' int2str(tempID) ' Successfully Disconnected']);
            else
                disp(['Wiimote ' int2str(tempID) ' Not Disconnected']);
                wiimote.isConnected = tmpID;
            end

        end % Disconnect

       
        %  DisconnectAllWiimotes
        %  Attempts to disconnect all the wiimotes connected
        %  @param wiimote The wiimote object
        function DisconnectAllWiimotes(wiimote)
       
            % Disconnect all the Wiimotes
            wiimote.wm.DisconnectAll();
            
            % Reset the properties of this Wiimote object
            wiimote.isConnected = -2;
            wiimote.ResetProperties();
            
            % Inform the user
            disp('All Wiimotes Disconnected');
            
        end % DisconnectAllWiimotes

       
        %% Wiimote Feedback
        %  SetRumble
        %  @param wiimote wiimote object
        %  @param on bool value indicating to turn the rumble on or off
        function SetRumble(wiimote, on)

            % Check Connection
            wiimote.CheckConnection();
            
            % Make call to the wiimote
            if(wiimote.Rumble ~= on)
                wiimote.wm.SetRumble(on);
                wiimote.Rumble = on;
            end

        end % SetRumble
        
        
        %  SetLEDs
        %  @param wiimote wiimote object
        %  @param led1 bool value indicating to turn LED 1 on or off
        %  @param led2 bool value indicating to turn LED 2 on or off
        %  @param led3 bool value indicating to turn LED 3 on or off
        %  @param led4 bool value indicating to turn LED 4 on or off
        function SetLEDs(wiimote, led1, led2, led3, led4)
        
            % Check Connection
            wiimote.CheckConnection();
            
            % Make call to the wiimote if the LEDs have changed
            if ( wiimote.rawLEDs(1) ~= led1 ...
                 || wiimote.rawLEDs(2) ~= led2 ...
                 || wiimote.rawLEDs(3) ~= led3 ...
                 || wiimote.rawLEDs(4) ~= led4)
                
                wiimote.LEDs.LED1 = led1;
                wiimote.LEDs.LED2 = led2;
                wiimote.LEDs.LED3 = led3;
                wiimote.LEDs.LED4 = led4;
                wiimote.rawLEDs = [led1 led2 led3 led4];
                
                wiimote.wm.SetLEDsBool( led1, led2, led3, led4);                                    
            end
                                
        end % SetLEDs
        
        
        %% Wiimote State
        %  UpdateWiimoteState
        %  General function that updates all needed data for the wiimote
        %  Probably should be called at the beginning of every loop to
        %  ensure up to date data
        %  @param wiimote wiimote object
        function UpdateWiimoteState(wiimote)

            % Buttons
            wiimote.GetButtonsState();
            % Accel
            wiimote.GetAccelState();
            % IR
            wiimote.GetIRState();
            %Get Nunchuk data
            wiimote.UpdateNunchukState();
            %Get BalanceBoard data
            wiimote.UpdateBalanceBoardState();

        end % UpdateWiimoteState

        
        %  GetButtonsState
        %  Function that updates the buttons state of the wiimote
        %  @param wiimote wiimote object
        function GetButtonsState(wiimote)
       
            % Check Connection
            wiimote.CheckConnection();
            
            % Buttons
            buttons = boolean(wiimote.wm.GetButtonState());
            
            wiimote.Buttons.A =     buttons(1);
            wiimote.Buttons.B =     buttons(2);
            wiimote.Buttons.Up =    buttons(3);
            wiimote.Buttons.Right = buttons(4);
            wiimote.Buttons.Down =  buttons(5);
            wiimote.Buttons.Left =  buttons(6);
            wiimote.Buttons.Plus =  buttons(7);
            wiimote.Buttons.Minus = buttons(8);
            wiimote.Buttons.Home =  buttons(9);
            wiimote.Buttons.One =   buttons(10);
            wiimote.Buttons.Two =   buttons(11);
            wiimote.rawButtons = buttons;
                        
        end % GetButtonsState

        
        %  GetAccelState
        %  Function that updates the acceleration state of the wiimote
        %  @param wiimote wiimote object
        function GetAccelState(wiimote)
        
            % Check Connection
            wiimote.CheckConnection();
                        
            % Accel
            accel = wiimote.wm.GetAccelState() * 9.8;
            
            
            wiimote.Accel.X = accel(1);
            wiimote.Accel.Y = -1 * accel(2);
            wiimote.Accel.Z = accel(3);
            wiimote.rawAccel = accel;

        end % GetAccelState
       
        %  GetIRState
        %  Function that updates the IR state of the wiimote
        %  @param wiimote wiimote object
        function GetIRState(wiimote)
           
            % Check Connection
            wiimote.CheckConnection();
            
            ir = wiimote.wm.GetIRState();            
            
            %disp(ir);
            
            % sort the array values into the struct
            wiimote.IR.source1.found =   ir(1,1);
            wiimote.IR.source1.X =       ir(1,2);
            wiimote.IR.source1.Y =       ir(1,3);
            wiimote.IR.source2.found =   ir(2,1);
            wiimote.IR.source2.X =       ir(2,2);
            wiimote.IR.source2.Y =       ir(2,3);
            wiimote.IR.source3.found =   ir(3,1);
            wiimote.IR.source3.X =       ir(3,2);
            wiimote.IR.source3.Y =       ir(3,3);
            wiimote.IR.source4.found =   ir(4,1);
            wiimote.IR.source4.X =       ir(4,2);
            wiimote.IR.source4.Y =       ir(4,3);
            wiimote.IR.midpoint.found =  ir(5,1);         
            wiimote.IR.midpoint.X =      ir(5,2);
            wiimote.IR.midpoint.Y =      ir(5,3);
            wiimote.rawIR = ir;
            
        end %GetIRState
       
        %  GetBatteryState
        %  Function that updates the Battery state of the wiimote
        %  @param wiimote wiimote object
        function GetBatteryState(wiimote)
           
            % Check Connection
            wiimote.CheckConnection();
            
            % Battery
            wiimote.Battery = wiimote.wm.GetBatteryState();
           
        end %GetIRState
                
       
        %% Nunchuk State
        
        
        %  IsNunchukConnected
        %  @param wiimote wiimote object
        %  @return isConnected whether or not the Nunchuk is connected
        function isConnected = IsNunchukConnected(wiimote)

            % Check Connection
            wiimote.CheckConnection();
            
            isConnected = wiimote.wm.IsNunchukConnected();
            
        end % IsNunchuckConnected
        
        
        %  UpdateNunchukState
        %  @param wiimote wiimote object
        function UpdateNunchukState(wiimote)

            % Buttons
            wiimote.GetNunchukButtonsState();
            % Accel
            wiimote.GetNunchukAccelState();
            % Joystick
            wiimote.GetNunchukJoystickState();
            
        end % UpdateNunchukState     

    
        %  GetNunchukButtonsState
        %  @param wiimote wiimote object
        function GetNunchukButtonsState(wiimote)

            % Check Connection
            wiimote.CheckConnection();
            
            % Buttons
            buttons = boolean(wiimote.wm.GetNunchukButtonState());
            
            wiimote.NunchukButtons.C = buttons(1);
            wiimote.NunchukButtons.Z = buttons(2);
            wiimote.rawNunchukButtons = buttons;

        end % GetNunchukButtonsState     


        %  GetNunchukAccelState
        %  @param wiimote wiimote object
        function GetNunchukAccelState(wiimote)

            % Check Connection
            wiimote.CheckConnection();
            
            % Accel
            accel = wiimote.wm.GetNunchukAccelState() * 9.8;
            
            wiimote.NunchukAccel.X = accel(1);
            wiimote.NunchukAccel.Y = -1 * accel(2);
            wiimote.NunchukAccel.Z = accel(3);
            wiimote.rawNunchukAccel = accel;
            
       end % GetNunchukAccelState     


        %  GetNunchukJoystickState
        %  @param wiimote wiimote object
        function GetNunchukJoystickState(wiimote)

            % Check Connection
            wiimote.CheckConnection();
            
            % Joystick
            joystick = wiimote.wm.GetNunchukJoystickState();   
            
            wiimote.NunchukJoystick.X = joystick(1);
            wiimote.NunchukJoystick.Y = joystick(2);
            wiimote.rawNunchukJoystick = joystick;

       end % GetNunchukJoystickState

       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        %  IsBalanceBoardConnected
        %  @param wiimote wiimote object
        %  @return isConnected whether or not the BalanceBoard is connected
        function isConnected = IsBalanceBoardConnected(wiimote)

            % Check Connection
            wiimote.CheckConnection();
            isConnected = wiimote.wm.IsBalanceBoardConnected();
            
        end
        %  UpdateBalanceBoardState
        %  @param wiimote wiimote object
        function UpdateBalanceBoardState(wiimote)

            % Sensors
            wiimote.GetBalanceBoardSensorState();
            % CoG
            wiimote.GetBalanceBoardCoGState();
            
        end
        %  GetBalanceBoardSensorsState
        %  @param wiimote wiimote object
        function GetBalanceBoardSensorState()

            % Check Connection
            wiimote.CheckConnection();
            sensors = wiimote.wm.GetBalanceBoardSensorState();
            wiimote.BalanceBoardSensors.BottomLeft = sensors(1);
            wiimote.BalanceBoardSensors.BottomRight = sensors(2);
            wiimote.BalanceBoardSensors.TopLeft = sensors(3);
            wiimote.BalanceBoardSensors.TopRight = sensors(4);
        end
        %  GetBalanceBoardCoGState
        %  @param wiimote wiimote object
        function GetBalanceBoardCoGState()

            % Check Connection
            wiimote.CheckConnection();
            cog = wiimote.wm.GetBalanceBoardCoGState();
            wiimote.BalanceBoardCoG.X = cog(1);
            wiimote.BalanceBoardCoG.Y = cog(2);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
        
       %% Accel Indicator
       %  Initialize Accel indicator
       function InitializeAccelIndicator(wiimote, obj, velDamping)
           
           % if an indicator is already created then close it
           if(wiimote.AccelIndicator.Enabled)
               wiimote.CloseAccelIndicator();
           end
           
           wiimote.AccelIndicator.refObj = obj;
           wiimote.AccelIndicator.dampingCoef = velDamping;
           wiimote.AccelIndicator.Enabled = true;
                     
       end % InitializeAccelIndicator
       
       
       %  UpdateAccelIndicator
       function UpdateAccelIndicator(wiimote)
           if(wiimote.AccelIndicator.Enabled)
                try
                    delete(wiimote.AccelIndicator.vector);
%                 catch me %#ok<NASGU>
                catch
                end

                % Find the Center of the object
                try
                    [x1 y1] = getCenter(wiimote.AccelIndicator.refObj);
%                 catch me %#ok<NASGU>
                catch
                    % If the user deletes the AccelIndicatorObj before
                    % closing the Accel Indicator, we need to close it
                    wiimote.CloseAccelIndicator();
                    return;
                end
                    
                % Calculate the object's center from the acceleration values and velocity damping                    
                x1 = x1 + wiimote.Accel.X * wiimote.AccelIndicator.dampingCoef;
                y1 = y1 + wiimote.Accel.Y * wiimote.AccelIndicator.dampingCoef;

                % Calculate the Accel Vector
                % -----------------------------------------------------
                x2 = x1 + wiimote.Accel.X * 5;
                y2 = y1 + wiimote.Accel.Y * 5;

                vector = drawLine(x1, y1, x2, y2, 'black');
                indCircle = drawCircle(x2, y2, 2, 'black');  
                
                wiimote.AccelIndicator.vector = [vector indCircle];
                % -----------------------------------------------------
           end
       end
  
       
       %  CloseAccelIndicator
       function CloseAccelIndicator(wiimote)
           if(wiimote.AccelIndicator.Enabled)
                wiimote.AccelIndicator.refObj = [];
                try
                    delete(wiimote.AccelIndicator.vector);
%                 catch me %#ok<NASGU>
                catch
                end
                wiimote.AccelIndicator.Enabled = false;
           end
       end
       
        
        %% Acceleration Graphing
        %  Initialize Wiimote Acceleration Graph
        %  This function creates the graphs and listeners to the Accel
        %  prop
        %  @param wiimote wiimote object
        function InitWiimoteAccelGraph(wiimote)
            
            if(wiimote.AccelGraph.Enabled)
                disp('The Wiimote Accel Graph is already initialized.');
            else
                % path of graphing functions in case they were not already
                % included
                addpath C:\'Program Files'\WiiLAB\WiiLAB_Matlab\WiimoteFunctions\GraphingFunctions


                % initialize variables
                xmin = 0;
                xmax = 1;
                wiimote.AccelGraph.subplots = 3;
                wiimote.AccelGraph.yMin = -20;
                wiimote.AccelGraph.yMax = 20;
                wiimote.AccelGraph.width = xmax-xmin;
                tmpSubplots = wiimote.AccelGraph.subplots;
                
                wiimote.AccelGraph.handle = createWindow(600, 600, 300, 300);
                
                % create a figure containing 3 empty graphs
                initializeGraph(tmpSubplots);

                % set X- and Y-axis labels
                setLabels(1, 'Time (seconds)', 'Acceleration (m/s)', 'X-Acceleration', tmpSubplots);
                setLabels(2, 'Time (seconds)', 'Acceleration (m/s)', 'Y-Acceleration', tmpSubplots);
                setLabels(3, 'Time (seconds)', 'Acceleration (m/s)', 'Z-Acceleration', tmpSubplots);

                % set each graph's axes
                for i=1 : tmpSubplots
                    [ wiimote.AccelGraph.yMin ...
                      wiimote.AccelGraph.yMax ...
                      wiimote.AccelGraph.width ] = ...
                            setAxes(i, xmin, xmax, -20, 20, ...
                                        tmpSubplots, ...
                                        wiimote.AccelGraph.yMin, ...
                                        wiimote.AccelGraph.yMax, ...
                                        wiimote.AccelGraph.width);
                end

                set(gcf, 'Name', 'Wiimote Acceleration Values');

                % Initialize Time to 0
                wiimote.AccelGraph.timer = 0;

                wiimote.AccelGraph.Enabled = true;

                tic;
            end
            
        end % initializeWiimoteAccelGraph
       
        %  Update Wiimote Acceleration Graph
        %  This is what is called to update the graphs whenever the Accel
        %  changes
        %  @param wiimote wiimote object
        function UpdateWiimoteAccelGraph(wiimote, src, evnt) %#ok<INUSD>
            
            if (wiimote.AccelGraph.Enabled)

                tmp_hdlCurrentWindow = gcf;
                if(wiimote.AccelGraph.handle ~= tmp_hdlCurrentWindow)
                    set(0,'CurrentFigure', wiimote.AccelGraph.handle);                
                end

                wiimote.AccelGraph.timer = wiimote.AccelGraph.timer + toc;

                % plot the current time against acceleration values
                for i=1 : wiimote.AccelGraph.subplots
                    plotData(i, wiimote.AccelGraph.timer, wiimote.rawAccel(i), ...
                                wiimote.AccelGraph.subplots, ...
                                wiimote.AccelGraph.yMin, ...
                                wiimote.AccelGraph.yMax, ...
                                wiimote.AccelGraph.width);
                end
                
                set(0, 'CurrentFigure', tmp_hdlCurrentWindow);

                tic;            

            end
            
        end % UpdateWiimoteAccelGraph
       
        %  Close Wiimote Acceleration Graph
        %  This function closes the graphs and disables the listeners
        %  @param wiimote wiimote object
        function CloseWiimoteAccelGraph(wiimote)
            
            if (wiimote.AccelGraph.Enabled)
                
                tmp_hdlCurrentWindow = gcf;
                if(wiimote.AccelGraph.handle ~= tmp_hdlCurrentWindow)
                    set(0,'CurrentFigure', wiimote.AccelGraph.handle);
                end

                % Done with these graphs.  Don't allow new data to be plotted.
                for i=1 : wiimote.AccelGraph.subplots
                    finished(i, wiimote.AccelGraph.subplots);
                end
                
                wiimote.AccelGraph.Enabled = false;

                close(wiimote.AccelGraph.handle);
                
                try
                    set(0, 'CurrentFigure', tmp_hdlCurrentWindow);
%                 catch me %#ok<NASGU>
                catch
                    % Do Nothing, there is no other window
                end
                
            end
                
        end % CloseWiimoteAccelGraph       
               
        
        %% Property Set Overrides
                    
        % rawAccel
        function set.rawAccel(wiimote, newState)
            
            wiimote.rawAccel = newState;
            if(wiimote.AccelGraph.Enabled)
                wiimote.UpdateWiimoteAccelGraph();
            end
            if(wiimote.AccelIndicator.Enabled);
                wiimote.UpdateAccelIndicator();
            end            
            
        end % set.rawAccel 
        
%     end % Public methods
    
    
    %% Private Methods
%     methods (Access = private)
        
                
        %  Reset properties
        %  @param wiimote wiimote object
        function ResetProperties(wiimote)

            % Set default values for the properties
            wiimote.Accel = AccelState;
            wiimote.Buttons = ButtonState;
            wiimote.IR = IRState;
            wiimote.NunchukButtons = NunchukButtonState;
            wiimote.NunchukAccel = AccelState;
            wiimote.NunchukJoystick = NunchukJoystickState;
            
            % Close the optional functions
            try
                wiimote.CloseWiimoteAccelGraph();                 
%             catch me %#ok<NASGU>
            catch
                % Do Nothing
            end
            try
                wiimote.CloseAccelIndicator();                 
%             catch me %#ok<NASGU>
            catch
                % Do Nothing
            end
            
       end % Reset properties
       
       
    end % Private Methods
    
end % Wiimote