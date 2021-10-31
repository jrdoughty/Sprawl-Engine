package components.core;

import hxbit.Serializable;
import haxe.Timer;

class TimeComp implements Serializable
{
    @:s public var timeMS:Int;
    @:s public var loop:Bool = false;
    @:s public var isComplete:Bool = false;
    @:s public var startTime:Float;
    @:s public var endTime:Float;
    @:s public var currentTime:Float;
    public function new(t:Int, loop:Bool = false) 
    {
        startTime = Timer.stamp();
        currentTime = Timer.stamp();
        endTime = Timer.stamp() + t;
        timeMS = t;
        this.loop = loop;
    }
}