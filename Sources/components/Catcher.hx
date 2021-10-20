package components;

class Catcher {
    public var framesUntil:Int;
    public var dFramesUntil:Int;//default
    public var value:Int;
    public function new(frames:Int = 0, value:Int = 1) 
    {
        framesUntil = frames; 
        dFramesUntil = frames;
        this.value = value;
    }
}