package components.core;

import kha.FastFloat;

class Visibility
{
    @:s var opacity:FastFloat = 1;
    @:s var visible:Bool = true;

    public inline function new(opacity:FastFloat = 1,visible:Bool = true)
    {
        this.opacity = opacity;
        this.visible = visible;
    }
}
