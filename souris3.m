%display rectangle at random position
%wait for user click
%if click is inside, the rectangle become green
%if outside, red
%recation time is displayed and printed on console
%while the green or red rectangle is displayed, user can exit the loop by
%pressing any key on keyboard

% By Gilles Rautureau, October 2017

%Screen('Preference', 'Verbosity', 7);
% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

%open screen
[windowPtr,windowRect]=Screen('OpenWindow',screenNumber, [255 255 255]);%, [50, 50, 760, 450]); % );%

% Get the size of the on screen window in pixels  
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', windowPtr);

%define a small rectangle
baseRect = round(windowRect/15,0);

%calculate min/max position on screen
sizeRect = SizeOfRect(baseRect);
xPosMin = round(windowRect(1)+sizeRect(1)/2,0);
xPosMax = round(windowRect(1)+windowRect(3)-sizeRect(1)/2,0);
yPosMin = round(windowRect(2)+sizeRect(2)/2,0);
yPosMax = round(windowRect(2)+windowRect(4)-sizeRect(2)/2,0) ;



exit = 0;
while(exit == 0)
    
    xPos = randi([xPosMin xPosMax]);
    yPos = randi([yPosMin yPosMax]);

    while 1 %reset clics counters and wait for release all buttons
        [xClick,yClick,buttons] = GetMouseTransient(windowPtr,1); 
        if  ~any(buttons)
            break;
        end
    end
    
    %display something
    Screen('FillRect', windowPtr,0); % clear screen
    rect=CenterRectOnPoint(baseRect,xPos,yPos); %create a rect at position xPos,yPos based on baseRect
    Screen('Framerect', windowPtr, [127 127 127], rect, 5 ); %display a small rectangle
    Screen('Flip', windowPtr);
    
    %display time
    start = GetSecs( );
        
    responseTime = realmax;
    
    while (1)
        [xClick,yClick,buttons] = GetMouseTransient(windowPtr,1); %
        if any(buttons)
            responseTime = GetSecs() - start;
            break;
        end
        
        if (GetSecs() - start) > 5
            fprintf('timeOut\n');
            break
        end
    end
    
    
    
    %result
    % display the rectangle in green color if click inside. red otherwise
    
    color = [255 0 0];
    if responseTime < 5 && IsInRect(xClick, yClick, rect)
        color = [0 255 0];
    end
    Screen('FillRect', windowPtr,0); % clear screen
    Screen('Framerect', windowPtr, color, rect, 5 ); %display a small rectangle at center
    
    %display reaction time
    rTstring = [sprintf('%d ms',round(responseTime*1000))];
    %disp(rTstring); 
    DrawFormattedText(windowPtr, rTstring, 'center', 'center', color, [], [], [], [], [], rect);
    Screen('Flip', windowPtr);
    
    %check keyboard to exit
    delay = 1.5 + (randi([0 10]))/10;
    start = GetSecs();
    while(GetSecs()<start+delay)
        WaitSecs(.05);
        [ keyIsDown, ~, ~ ] = KbCheck;
        if keyIsDown
            exit = 1;
            break;
        end
    end
    
end

Screen('CloseAll');
