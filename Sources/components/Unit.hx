package components;

class Unit   implements hxbit.Serializable {
    @:s public var framesUntil:Int;
    public function new(frames:Int = 0) 
    {
        framesUntil = frames;   
    }
}