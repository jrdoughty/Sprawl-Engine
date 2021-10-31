package components;

class Enemy   implements hxbit.Serializable {
    @:s public var framesUntil:Int;
    public function new(frames:Int = 0) 
    {
        framesUntil = frames;   
    }
}