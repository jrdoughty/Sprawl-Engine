package components;

class Catcher {
    public var framesUntil:Int;
    public var value:Int;
    public function new(frames:Int = 0, value:Int = 10) 
    {
        framesUntil = frames; 
        this.value = value;
    }
}