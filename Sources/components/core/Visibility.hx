package components.core;


class Visibility
{
    @:s public var opacity:Float = 1;//Not Yet Implemented
    @:s public var visible:Bool = true;

    public inline function new(opacity:Float = 1,visible:Bool = true)
    {
        this.opacity = opacity;
        this.visible = visible;
    }
}
