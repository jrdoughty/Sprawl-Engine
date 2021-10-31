package components;

class Catcher  implements hxbit.Serializable  {
    @:s public var framesUntil:Int;
    @:s public var dFramesUntil:Int;//default
    @:s public var value:Int;
    public function new(frames:Int = 0, value:Int = 1) 
    {
        framesUntil = frames; 
        dFramesUntil = frames;
        this.value = value;
    }
}