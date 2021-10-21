package systems;

import haxe.Timer;
import echoes.System;
import components.*;

class TimeSystem extends System
{
    @u function updateTimers(t:TimeComp)
    {
        for(i in t.keys())
        {
            t.get(i).currentTime = Timer.stamp();
        }
    }

    @u function isGameDone(t:TimeComp, s:ScoreComp)
    {
        if(t.get('timer').endTime - t.get('timer').currentTime <= 0)
        {
            Project.active = false;
        }
    }
}