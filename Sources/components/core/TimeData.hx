package components.core;

import haxe.Timer;

class TimeData
{
    public var timeMS:Int;
    public var loop:Bool;
    public var isComplete:Bool = false;
    public var startTime:Float;
    public var endTime:Float;
    public var currentTime:Float;
    public function new(t:Int, loop:Bool = false) 
    {
        startTime = Timer.stamp();
        currentTime = Timer.stamp();
        endTime = Timer.stamp() + t;
        timeMS = t;
        this.loop = loop;
    }
}