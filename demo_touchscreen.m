
% reset
clc;

% definitions
wait4release = @() TouchReleaseWait();

% record touch press
ok = 1;
tstart = GetSecs;
while ok 
    [xMouse,yMouse,buttons] = GetMouseTransient([],1);
    ok = ~any(buttons); 
    disp(buttons);
end
disp('press!');
tpress = GetSecs - tstart;
disp(tpress);

% record touch release
wait4release() ;
disp('release!');
trelease = GetSecs - tstart;
disp(trelease);

