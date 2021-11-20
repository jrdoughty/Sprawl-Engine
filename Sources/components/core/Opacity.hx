package components.core;



class Visibility
{
    @:s public var opacity:Float = 1;
    @:s public var visible:Bool = true;

    public function new(opacity:Float = 1,visible:Bool = true)
    {
        this.opacity = opacity;
        this.visible = visible;
    }
}
