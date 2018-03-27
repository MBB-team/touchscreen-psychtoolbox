function [] = TouchReleaseWait()

    ok = 1;
    while ok 
        [xMouse,yMouse,buttons] = GetMouseTransient([],1);
        xMemory = xMouse;
        ok = any(buttons);
    end


end