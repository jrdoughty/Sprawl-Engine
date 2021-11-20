package sprawl.components;

class Bounds2D implements hxbit.Serializable
{
    public var w:Float = 0;
    public var h:Float = 0;
    public function new(w = .0, h = .0)
    {
        this.w = w;
        this.h = h;
    }
}
